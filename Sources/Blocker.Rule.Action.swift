import Foundation

extension Blocker.Rule {
    enum Action {
        case
        cookies,
        http,
        css(Set<String>)
    }
}
