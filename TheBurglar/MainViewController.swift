import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var rotateView: RotateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateView.changeDirection = {
            print("change value!")
        }
        
        rotateView.updateValue = { (value: Int) in
            print(value)
        }
    }
}

