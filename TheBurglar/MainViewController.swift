import UIKit

class MainViewController: UIViewController {

    @IBOutlet private(set) var rotateView: RotateView!
    @IBOutlet private(set) var numberLabels: [UILabel]!
    @IBOutlet private(set) var numbersView: UIView!
    @IBOutlet var lastCheckLabels: [DesignableView]!
    
    var leftPanelAction: (()->())?
    var currentNumber: Int = 0
    var history = [HistoryItem]()
    fileprivate let colors = (exactly: #colorLiteral(red: 0.5803921569, green: 0.8784313725, blue: 0.2666666667, alpha: 1), exist: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), absent: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    
    private var burglarEngine: BurglarEngine!
    
    private var isSlided: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.burglarEngine = BurglarEngine()
        
        self.rotateView.changeDirection = {
            print("change value!")
        }
        
        self.rotateView.updateValue = { (value: Int) in
            print(value)
            self.numberLabels[self.currentNumber].text = "\(value)"
        }
        
        self.rotateView.touchEnd = { [weak self] in
            if let s = self {
                s.currentNumber = s.currentNumber < 3 ?
                    s.currentNumber + 1 : 0
                
                
                if s.currentNumber == 0 {
                    
                    var numbers = [Int]()
                    s.numberLabels.forEach({ (label: UILabel) in
                        if let str = label.text {
                            numbers.append(Int(str) ?? 0)
                        }
                        else {
                            numbers.append(0)
                        }
                    })
                    if s.burglarEngine.checkNumber(numbers: numbers) {
                        debugPrint("WIiiiin!")
                    }
                    else {
                        s.numbersView.shake()
                    }
                    
                    if let lastItem = s.burglarEngine.history.last {
                        for i in 0...3 {
                            if i < lastItem.exactly {
                                s.lastCheckLabels[i].backgroundColor = s.colors.exactly
                            }
                            else if i >= lastItem.exactly && i < lastItem.exactly + lastItem.exist {
                                s.lastCheckLabels[i].backgroundColor = s.colors.exist
                            }
                            else {
                                s.lastCheckLabels[i].backgroundColor = s.colors.absent
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- Actions
  
    @IBAction func historyPressed(_ sender: Any) {
        if let action = self.leftPanelAction {
            self.history = self.burglarEngine.history
            action()
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        self.currentNumber = sender.tag
    }
}

