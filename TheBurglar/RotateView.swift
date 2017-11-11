import UIKit
import CoreGraphics

class RotateView: UIView {
    
    enum Direction {
        case up, left, right, down, none
    }
    
    @IBOutlet var rotateImage: UIImageView!
    @IBInspectable var sectionsNumber: Int = 10
    @IBInspectable var step: Int = 1
    
    var numberValue: Int = 0
    var updateValue: ((Int) -> ())?
    var touchEnd: (() -> ())?
    var changeDirection: (() -> ())?
    
    var line: Line!
    var angle: Double = 0.0
    
    var currentValue: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.pcs = PolarCoordinateSystem(center: self.rotateImage.center)
    }
    
    private var stepHelperDegree: CGFloat {
        return 20.0
    }
    
    //MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        let centerPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.line = Line(begin: centerPoint, end: touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        
        self.line.end = touchPoint
        self.rotateImage.rotate(to: -line.angle.converted(to: UnitAngle.radians).value)
        self.proccessAngle()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = self.touchEnd {
            t()
        }
    }
}

extension RotateView {
    
    fileprivate func proccessAngle() {
        let stepValue = 360.0 / Double(self.sectionsNumber)
        let number = Int(self.line.angle.value / stepValue)
        guard number != self.numberValue  else { return }
        self .numberValue = number
        if let updateValue = self.updateValue {
            updateValue(self.numberValue)
        }
    }
}

