import Foundation
import Security

private let kSecClassValue = kSecClass as String
private let kSecAttrServiceValue = kSecAttrService as String
private let kSecAttrLabelValue = kSecAttrLabel as String
private let kSecAttrAccountValue = kSecAttrAccount as String
private let kSecValueDataValue = kSecValueData as String
private let kSecReturnDataValue = kSecReturnData as String
private let kSecMatchLimitValue = kSecMatchLimit as String
private let kSecAttrAccessibleValue = kSecAttrAccessible as String

class Keychain {
    
    static let shared: Keychain = Keychain()
    
    subscript(key: String) -> String? {
        set {
            self.set(value: newValue?.data(using: String.Encoding.utf8), for: key)
        }
        get {
            if let data = self.value(for: key)  {
                return String(data: data, encoding: String.Encoding.utf8)
            }
            
            return nil
        }
        
    }
    
    @discardableResult
    func set(value: Data?, for key: String) -> Bool {
        var query: [String: Any] = [kSecClassValue       : kSecClassGenericPassword,
                                    kSecAttrAccountValue : key]
        
        var status = SecItemDelete(query as CFDictionary)
        
        if status != noErr && status != errSecItemNotFound {
            debugPrint("Error while setting value for key: `\(key)` to keychain(delete): status `\(status)`, value: \(value)")
        }
        
        if let value = value {
            query[kSecValueDataValue] = value
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != noErr && status != errSecItemNotFound {
                debugPrint("Error while setting value for key: `\(key)` to keychain(add): status `\(status)`, value: \(value)")
            }
        }
        
        return status == noErr
    }
    
    func value(for key: String) -> Data? {
        let query: [String : Any] = [kSecClassValue         : kSecClassGenericPassword,
                                     kSecAttrAccountValue   : key,
                                     kSecReturnDataValue    : kCFBooleanTrue,
                                     kSecMatchLimitValue    : kSecMatchLimitOne]
        
        var result: AnyObject?
        
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if status == noErr  {
            return result as? Data
        }
        
        if status != errSecItemNotFound {
            debugPrint("Error while getting value for key: `\(key)` from keychain: status `\(status)`")
        }
        
        return nil
    }
    
    func clear() {
        let query = [kSecClassValue : kSecClassGenericPassword]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        if status != noErr {
            debugPrint("Error while clearing keychain. Status: \(status)")
        }
    }
}
