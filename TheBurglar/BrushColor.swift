import UIKit

enum BrushColor: Int {
    case red = 1, orange, yellow, green, lightBlue, blue, purple, black
    
    var color: (border:UIColor, fill:UIColor) {
        switch self {
        case .red:
            return (#colorLiteral(red: 0.3784659207, green: 0, blue: 0.03706488386, alpha: 1),#colorLiteral(red: 0.8196976781, green: 0, blue: 0.07052632421, alpha: 1))
        case .orange:
            return (#colorLiteral(red: 0.5308582187, green: 0.3362921774, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.6214974523, blue: 0, alpha: 1))
        case .yellow:
            return (#colorLiteral(red: 0.5685819983, green: 0.5256724954, blue: 0, alpha: 1),#colorLiteral(red: 0.9724317193, green: 0.9061997533, blue: 0, alpha: 1))
        case .green:
            return (#colorLiteral(red: 0.1040075794, green: 0.1965676546, blue: 0, alpha: 1),#colorLiteral(red: 0.2504917681, green: 0.4598714113, blue: 0, alpha: 1))
        case .lightBlue:
            return (#colorLiteral(red: 0, green: 0.4948033094, blue: 0.717314899, alpha: 1),#colorLiteral(red: 0.5684491992, green: 0.8715153337, blue: 1, alpha: 1))
        case .blue:
            return (#colorLiteral(red: 0, green: 0.2625751495, blue: 0.5813778639, alpha: 1),#colorLiteral(red: 0.2872819304, green: 0.5649781823, blue: 0.9019031525, alpha: 1))
        case .purple:
            return (#colorLiteral(red: 0.3482360244, green: 0, blue: 0.6596130729, alpha: 1),#colorLiteral(red: 0.5693742633, green: 0.04801632464, blue: 1, alpha: 1))
        case .black:
            return (#colorLiteral(red: 0.2853525145, green: 0.2853525145, blue: 0.2853525145, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        }
    }
}
