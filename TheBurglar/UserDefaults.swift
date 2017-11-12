import Foundation

extension String {
    
    func ud_saveString(key: String) {
        UserDefaults.standard.set(self, forKey: key.uppercased())
    }
    
    func ud_object() -> Any? {
        return UserDefaults.standard.object(forKey: self.uppercased())
    }
}

extension Bool {
    
    func ud_saveBool(key: String) {
        UserDefaults.standard.set(self, forKey: key.uppercased())
    }
}

extension Int {
    
    func ud_saveInt(key: String) {
        UserDefaults.standard.set(self, forKey: key.uppercased())
    }
}

extension Double {

    func ud_saveDouble(key: String) {
        UserDefaults.standard.set(self, forKey: key.uppercased())
    }
}
