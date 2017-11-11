import UIKit

class MainViewController: UIViewController {

    @IBOutlet private(set) var rotateView: RotateView!
    @IBOutlet private(set) var numberLabels: [UILabel]!
    @IBOutlet private(set) var numbersView: UIView!
    
    var menuAction: (()->())?
    var currentNumber: Int = 0
    
    private var isSlided: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateView.changeDirection = {
            print("change value!")
        }
        
        rotateView.updateValue = { (value: Int) in
            print(value)
            self.numberLabels[self.currentNumber].text = "\(value)"
        }
        
        rotateView.touchEnd = { [weak self] in
            if let s = self {
                s.currentNumber = s.currentNumber < 3 ?
                    s.currentNumber + 1 : 0
                
                //debug!
                if s.currentNumber == 0 {
                    s.numbersView.shake()
                }
            }
        }
    }
    
    //MARK:- Actions
  
    @IBAction func historyPressed(_ sender: Any) {
        if let action = self.menuAction {
            action()
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        self.currentNumber = sender.tag
    }
}

