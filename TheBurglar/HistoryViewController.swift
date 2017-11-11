import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet private(set) var backgroundView: UIView!
    @IBOutlet private(set) var contentView: UIView!
    @IBOutlet private(set) var tableView: UITableView!
    
    private var isSlided: Bool = false
    fileprivate let colors = (exactly: #colorLiteral(red: 0.5803921569, green: 0.8784313725, blue: 0.2666666667, alpha: 1), exist: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), absent: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    fileprivate var history = [HistoryItem]()
    
    //MARK:- Lifecycle
    
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
            UIView.animate(withDuration: 0.5,
                           animations: animations,
                           completion: completion)
        }
        else {
            animations()
            completion(false)
        }
    }
    
    func reload() {
        self.tableView.reloadData()
    }
}

//MARK:- Segue

extension HistoryViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainViewController {
            vc.leftPanelAction = {
                self.history = vc.history
                self.set(slided: !self.isSlided, animated: true)
            }
        }
    }
}

//MARK:- TableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier:
            "Cell") as! HistoryTableViewCell

        let historyItem = self.history[indexPath.row]
        
        cell.numberLabels[0].text = "\(historyItem.numb1)"
        cell.numberLabels[1].text = "\(historyItem.numb2)"
        cell.numberLabels[2].text = "\(historyItem.numb3)"
        cell.numberLabels[3].text = "\(historyItem.numb4)"
 
        
        for i in 0...3 {
            if i < historyItem.exactly {
                cell.checkoutResultViews[i].backgroundColor = self.colors.exactly
            }
            else if i >= historyItem.exactly && i < historyItem.exactly + historyItem.exist {
                cell.checkoutResultViews[i].backgroundColor = self.colors.exist
            }
            else {
                cell.checkoutResultViews[i].backgroundColor = self.colors.absent
            }
        }
        
        return cell
    }
}

