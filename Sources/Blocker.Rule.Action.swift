import Foundation

extension Blocker.Rule {
    enum Action {
        case
        block,
        cookies,
        http,
        css,
        selector([String])
    }
}
