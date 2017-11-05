import UIKit

extension UIImage {
    
    func jpegData(quality: CGFloat = 0.5) -> Data? {
        return UIImageJPEGRepresentation(self, quality)
    }
    
    func with(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @discardableResult
    func save(with name: String, quality: CGFloat = 1.0) -> Bool {
        let fileManager = FileManager.default
        
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor:nil,
                                                        create:false)
            let fileURL = documentDirectory.appendingPathComponent(name)
            
            print(fileURL)
            
            if let imageData = UIImageJPEGRepresentation(self, quality) {
                try imageData.write(to: fileURL)
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
}
