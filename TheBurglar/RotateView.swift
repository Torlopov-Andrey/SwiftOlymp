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
    var changeDirection: (() -> ())?
    
    private var pcs: PolarCoordinateSystem!
    private var accumulateValue: CGFloat = 0
    private var currentDirectionCW: Bool?
    private var controlPoint: CGPoint!
    private var rotateAngle: Double = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.pcs = PolarCoordinateSystem(center: self.rotateImage.center)
    }
    
    private var stepHelperDegree: CGFloat {
        return 20.0 //360.0 / CGFloat(self.sectionsNumber)
    }
    
    //MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.accumulateValue = 0
        self.controlPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
 
        let line = Line.init(begin: self.center, end: touchPoint)
        print("center: \(self.center) touchPoint: \(touchPoint) degree: \(line.angle)")
 
        self.controlPoint = touchPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
    }
    
    
    // MARK: - help methods
    
    private func calculatePoints(currentPoint: CGPoint) -> Int {
        let topSide = self.controlPoint.y >= self.rotateImage.frame.size.height / 2
        let rightSide = self.controlPoint.x >= self.rotateImage.frame.size.width / 2
        
        let direction = self.calcDirection(currentPoint: currentPoint)
        
        switch direction {
        case .right:
            return topSide ? -1 : 1
        case .left:
            return topSide ? 1 : -1
        case .down:
            return rightSide ? 1 : -1
        case .up:
            return rightSide ? -1 : 1
        case .none:
            return 0
        }
    }
    
    private func calcDirection(currentPoint: CGPoint) -> Direction {
        let dX = currentPoint.x - self.controlPoint.x
        let dY = currentPoint.y - self.controlPoint.y
        
        if max(dX, dY) <= 3 { return .none }
        
        if dX > dY {
            return dX > 0 ? .right : .left
        }
        else {
            return dY > 0 ? .down : .up
        }
    }
}

 
