import Foundation
import UIKit

extension UIView {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = [self.center.x - 5, self.center.y]
        shake.toValue = [self.center.x + 5, self.center.y]
        self.layer.add(shake, forKey: "position")
    }
    
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
    
    func embed(subview: UIView,
               insets: UIEdgeInsets = UIEdgeInsets.zero,
               index: Int? = nil) {
        if let index = index {
            self.insertSubview(subview, at: index)
        }
        else {
            self.addSubview(subview)
        }
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["subview": subview]
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(\(insets.left))-[subview]-(\(insets.right))-|",
            options: [],
            metrics: nil,
            views: views))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(\(insets.top))-[subview]-(\(insets.bottom))-|",
            options: [],
            metrics: nil,
            views: views))
    }
    
    func addConstraints(with format: String,
                        views: [String: Any],
                        options: NSLayoutFormatOptions = [],
                        metrics: [String : Any]? = nil) {
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: options,
            metrics: metrics,
            views: views))
    }
    
    @discardableResult
    func addConstraint(with attr1: NSLayoutAttribute,
                       relatedBy relation: NSLayoutRelation = .equal,
                       toItem view2: Any? = nil,
                       attribute attr2: NSLayoutAttribute = .notAnAttribute,
                       multiplier: CGFloat = 1,
                       constant c: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attr1,
                                            relatedBy: relation,
                                            toItem: view2,
                                            attribute: attr2,
                                            multiplier: multiplier,
                                            constant: c)
        self.addConstraint(constraint)
        
        return constraint
    }
}
