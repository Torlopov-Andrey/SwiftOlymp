import UIKit

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
}
    
