import Foundation
import UIKit

class PolarCoordinateSystem {

    enum AngleType {
        case degree, radians
    }
    
    private let center: CGPoint
    
    init(center: CGPoint = CGPoint(x: 0, y: 0)) {
        self.center = center
    }
    
    func angle(point: CGPoint, type: AngleType = .degree) -> CGFloat {
        
        let x = point.x - self.center.x
        let y = point.y - self.center.y
        
        if x == 0 && y == 0 {
            print("error! x == 0 and y == 0")
            return 0.0
        }
        
        if x > 0 && y >= 0 {
            return type == .degree ? atan(y / x) * 180.0 / CGFloat.pi : atan(y / x)
        }
        else if x > 0 && y < 0 {
            return type == .degree ? (atan(y / x) + 2*CGFloat.pi) * 180.0 / CGFloat.pi : (atan(y / x) + 2*CGFloat.pi)
        }
        else if x < 0 {
            return type == .degree ? (atan(y / x) +  CGFloat.pi) * 180.0 / CGFloat.pi : (atan(y / x) +  CGFloat.pi)
        }
        else if x == 0 && y > 0 {
            return type == .degree ? 90.0 : CGFloat.pi / 2
        }
        else if x == 0 && y < 0 {
            return type == .degree ? 270.0 : 3/2 * CGFloat.pi
        }
        else {
            print("else block! error!")
            return 0.0;
        }
    }

    func clockwiseDirection(currentPoint: CGPoint, basePoint: CGPoint) -> Bool {
        return self.deltaBetween(currentPoint: currentPoint, basePoint: basePoint) < 0
    }
    
    private func deltaBetween(currentPoint: CGPoint, basePoint: CGPoint) -> CGFloat {
        var basePointAngle = self.angle(point: basePoint)
        if basePointAngle <= 180 && self.angle(point: currentPoint) > 180 {
            basePointAngle += 360
        }
        
        return self.angle(point: currentPoint) - basePointAngle
    }

    func deltaDegree(currentPoint: CGPoint, basePoint: CGPoint) -> CGFloat {
        let delta: CGFloat = self.deltaBetween(currentPoint: currentPoint, basePoint: basePoint)
        return delta //.abs
    }
}
