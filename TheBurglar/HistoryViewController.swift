import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet private(set) var backgroundView: UIView!
    @IBOutlet private(set) var contentView: UIView!
    @IBOutlet private(set) var tableView: UITableView!
    
    private var isSlided: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.set(slided: self.isSlided)
    }
    
    //MARK:- Actions
    
    @IBAction func backgroundTap(_ sender: Any) {
        self.set(slided: !self.isSlided, animated: true)
    }
    
    // MARK: - Sliding
    
    fileprivate func set(slided: Bool, animated: Bool = false, prepareToStart: Bool = true) {
        self.isSlided = slided
        self.contentView.superview?.isHidden = false
        
        if prepareToStart {
            self.contentView.frame.origin.x = slided ? -self.contentView.frame.width : 0
            self.backgroundView.alpha = !slided ? 1 : 0
        }
        
        let animations = {
            self.contentView.frame.origin.x = !slided ? -self.contentView.frame.width : 0
            self.backgroundView.alpha = slided ? 1 : 0
        }
        
        let completion: (Bool) -> () = { _ in
            self.contentView.superview?.isHidden = !slided
            
            if slided {
                self.reload()
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.2,
                           animations: animations,
                           completion: completion)
        }
        else {
            animations()
            completion(false)
        }
    }
    
    func reload() {
        print("reload!")
    }
}

//MARK:- Segue

extension HistoryViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainViewController {
            vc.menuAction = {
                self.set(slided: !self.isSlided, animated: true)
            }
        }
    }
}

//MARK:- TableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier:
            "Cell") as! HistoryTableViewCell

        cell.numberLabels[0].text = "\(indexPath.row)"
        cell.numberLabels[1].text = "\(indexPath.row)"
        cell.numberLabels[2].text = "\(indexPath.row)"
        cell.numberLabels[3].text = "\(indexPath.row)"
        
        return cell
    }
}

