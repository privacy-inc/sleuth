import Foundation

extension Blocker.Rule {
    enum Trigger {
        case
        url,
        domain([String])
    }
}
