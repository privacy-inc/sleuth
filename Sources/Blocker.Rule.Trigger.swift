import Foundation

extension Blocker.Rule {
    enum Trigger {
        case
        all,
        sensitive,
        document,
        first,
        url(URL.White),
        domain(URL.White)
    }
}
