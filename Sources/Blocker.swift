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
            return [.cookies]
        case .http:
            return [.http]
        case .ads:
            return []
        case .popups:
            return []
        case .antidark:
            return []
        }
    }
}
