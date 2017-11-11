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
    
    var line: Line!
    
//    private var pcs: PolarCoordinateSystem!
//    private var accumulateValue: CGFloat = 0
//    private var currentDirectionCW: Bool?
//    private var controlPoint: CGPoint!
//    private var rotateAngle: Double = 0
    
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
        print(line.angle.value)
        self.rotateImage.rotate(to: -line.angle.converted(to: UnitAngle.radians).value)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.line = Line(begin: self.center, end: self.center)
    }
    
    
    // MARK: - help methods
    
//    private func calculatePoints(currentPoint: CGPoint) -> Int {
//        let topSide = self.controlPoint.y >= self.rotateImage.frame.size.height / 2
//        let rightSide = self.controlPoint.x >= self.rotateImage.frame.size.width / 2
//
//        let direction = self.calcDirection(currentPoint: currentPoint)
//
//        switch direction {
//        case .right:
//            return topSide ? -1 : 1
//        case .left:
//            return topSide ? 1 : -1
//        case .down:
//            return rightSide ? 1 : -1
//        case .up:
//            return rightSide ? -1 : 1
//        case .none:
//            return 0
//        }
//    }

//    private func calcDirection(currentPoint: CGPoint) -> Direction {
//        let dX = currentPoint.x - self.controlPoint.x
//        let dY = currentPoint.y - self.controlPoint.y
//
//        if max(dX, dY) <= 3 { return .none }
//
//        if dX > dY {
//            return dX > 0 ? .right : .left
//        }
//        else {
//            return dY > 0 ? .down : .up
//        }
//    }
}

 
