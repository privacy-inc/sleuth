import Foundation

extension Blocker.Rule {
    enum Trigger: Equatable {
        case
        all,
        url(URL.White)
    }
}
