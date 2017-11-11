import UIKit

class BrushView: UIView {

    fileprivate let shapeLayer = CAShapeLayer()
    
    private let bezierPath = UIBezierPath()
    private var controlPoint: Int = 0
    private var points = [CGPoint](repeating: CGPoint(), count: 5)
    
    @IBOutlet private var activeViews: [UIView]!
    
    @IBInspectable var lineWidth: CGFloat = 3 {
        didSet {
            self.shapeLayer.lineWidth = lineWidth
        }
    }
    
    @IBInspectable var lineColor: UIColor = .black {
        didSet {
            self.shapeLayer.strokeColor = self.lineColor.cgColor
        }
    }
    
    var isEmpty: Bool {
        return self.bezierPath.isEmpty
    }
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        
        self.layer.insertSublayer(self.shapeLayer, at: 0)
        
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.lineCap = kCALineCapRound
        self.shapeLayer.strokeColor = self.lineColor.cgColor
        self.shapeLayer.lineWidth = self.lineWidth
    }
    
    // MARK: - Handlers
    
    @IBAction private func clearPressed(_ sender: UIButton) {
        self.bezierPath.removeAllPoints()
        self.shapeLayer.path = nil
        
        self.setActive(hidden: true)
    }
    
    // MARK: - View lifecycle
    
    private func setActive(hidden: Bool) {
        self.activeViews.forEach { $0.isHidden = hidden }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setActive(hidden: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchPoint = touch.location(in: self)
        
        self.controlPoint = 0
        self.points[0] = touchPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        
        self.controlPoint += 1
        self.points[self.controlPoint] = touchPoint
        
        guard self.controlPoint == 4 else {
            return
        }
        
        if self.controlPoint == 4 {
            self.points[3] = CGPoint(x: (self.points[2].x + self.points[4].x) / 2.0,
                                     y: (self.points[2].y + self.points[4].y) / 2.0)
            
            self.bezierPath.move(to: self.points[0])
            self.bezierPath.addCurve(to: self.points[3],
                                     controlPoint1:self.points[1],
                                     controlPoint2:self.points[2])
            
            self.shapeLayer.path = self.bezierPath.cgPath
            
            self.points[0] = self.points[3]
            self.points[1] = self.points[4]
            
            self.controlPoint = 1
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.controlPoint == 0 else {
            self.controlPoint = 0
            self.setActive(hidden: false)
            return
        }
        
        let touchPoint = self.points[0]
        
        self.bezierPath.move(to: CGPoint(x: touchPoint.x - 1.0,
                                         y: touchPoint.y))
        
        self.bezierPath.addLine(to: CGPoint(x: touchPoint.x + 1.0,
                                            y: touchPoint.y))
        
        self.shapeLayer.path = self.bezierPath.cgPath
    }
}

extension BrushView {
    
    func renderedImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.shapeLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
