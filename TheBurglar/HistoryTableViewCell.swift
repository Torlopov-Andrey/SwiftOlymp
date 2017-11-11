import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet private(set) var checkoutResultViews: [DesignableView]!
    @IBOutlet private(set) var numberLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
