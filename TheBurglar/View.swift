import UIKit
import Foundation

extension UIView {
    
    func rotate(to radians: Double, duration: TimeInterval = -1) {
        let animation: () -> () = {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        }
        
        if duration > 0 {
            UIView.animate(withDuration: duration, animations: animation)
        }
        else {
            animation()
        }
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = [self.center.x - 5, self.center.y]
        shake.toValue = [self.center.x + 5, self.center.y]
        self.layer.add(shake, forKey: "position")
    }
}
    
