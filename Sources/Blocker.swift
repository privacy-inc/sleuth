import Foundation

public enum Blocker {
    case
    cookies,
    http,
    ads,
    popups,
    antidark
    
    public var content: String {
        rules.content
    }
    
    private var rules: [Rule] {
        switch self {
        case .cookies:
            return [.init(action: .cookies, trigger: .all)]
        case .http:
            return [.init(action: .http, trigger: .all)]
        case .ads:
            return []
        case .popups:
            return []
        case .antidark:
            return []
        }
    }
}
