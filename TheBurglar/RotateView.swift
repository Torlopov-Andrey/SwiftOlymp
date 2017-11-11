import UIKit

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
        
        if (touchPoint.x - self.frame.size.width / 2).abs < 30 ||
            (touchPoint.y - self.frame.size.height / 2).abs < 30 {
            self.controlPoint = touchPoint
            
            return
        }
        
        
        let calcedValue = CGFloat(calculatePoints(currentPoint: touchPoint))
        
        if self.currentDirectionCW == nil {
            self.currentDirectionCW = calcedValue == -1
        }
        
//        self.accumulateValue += calcedValue
        
//        self.accumulateValue +=
        calculateDegree(point: touchPoint)
        
        
//        print(self.accumulateValue)
        
//        if (self.currentDirectionCW == true && self.accumulateValue < 0) ||
//            self.currentDirectionCW == false && self.accumulateValue > 0 {
//            print("change direction!")
//        }
//        
        
//        if self.accumulateValue.abs >= self.stepHelperDegree {
//            self.numberValue += 1
//            print("change value \(self.numberValue)")
//            self.accumulateValue = 0
//        }
        
        
//        if self.currentDirection == nil {
//        
//            self.currentDirection = pcs.clockwiseDirection(currentPoint: touchPoint, basePoint: self.controlPoint)
//        }
        
//        calculate(point: touchPoint)
        
        self.controlPoint = touchPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
//        print("end point = \(pcs.angle(point: touch.location(in: self)))")
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
    
    private func calculateDegree(point: CGPoint) {
        
        let degree = self.pcs.deltaDegree(currentPoint: point, basePoint: self.controlPoint)
        self.accumulateValue += degree
        print("degree \(self.accumulateValue)")
        
//        let CWDirection = self.pcs.clockwiseDirection(currentPoint: point, basePoint: self.controlPoint)
        
//        self.accumulateValue += degree.abs
        
//        let rads = Double(degree / 180.0)
//        self.rotateAngle = CWDirection ? self.rotateAngle - rads/2 : self.rotateAngle + rads/2
//        self.rotateAngle = self.rotateAngle > Double.pi * 2 ? self.rotateAngle - Double.pi * 2 : self.rotateAngle
//        self.rotateImage.rotate(to: self.rotateAngle)
//
        
//        if self.currentDirection != CWDirection {
//            if let cd = self.changeDirection,
//                let uv = self.updateValue {
//                cd()
//                uv(self.numberValue)
//                
//            }
//            self.numberValue = 0
//            self.accumulateDegree = 0
//            self.currentDirection = CWDirection
//        }
//        
//        if self.accumulateDegree >= self.stepHelperDegree {
//            if let uv = self.updateValue {
//                self.numberValue += 1
//                if self.numberValue > 9 {
//                    self.numberValue = 0
//                }
//                uv(self.numberValue)
//            }
//            self.accumulateDegree = 0
//        }
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

 
