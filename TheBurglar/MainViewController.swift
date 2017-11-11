import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var rotateView: RotateView!
    var menuAction: (()->())?
    private var isSlided: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateView.changeDirection = {
            print("change value!")
        }
        
        rotateView.updateValue = { (value: Int) in
            print(value)
        }
    }
    
    //MARK:- Actions
  
    @IBAction func historyPressed(_ sender: Any) {
        if let action = self.menuAction {
            action()
        }
    }
}

