import Foundation

extension Blocker.Rule {
    enum Trigger {
        case
        all
        
        var content: String {
            switch self {
            case .all:
                return ".*"
            }
        }
    }
}
