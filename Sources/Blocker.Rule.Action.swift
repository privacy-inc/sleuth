import Foundation

extension Blocker.Rule {
    enum Action {
        case
        block,
        cookies,
        http,
        css([String])
        
        var content: String {
            switch self {
            case .block:
                return "block"
            case .cookies:
                return "block-cookies"
            case .http:
                return "make-https"
            case let .css(css):
                return css
                    .joined(separator: ",")
            }
        }
    }
}
