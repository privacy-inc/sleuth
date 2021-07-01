import Foundation

extension URL {
    public enum Scheme: String {
        case
        https,
        http,
        gmsg
        
        var policy: Policy {
            switch self {
            case .http, .https:
                return .allow
            case .gmsg:
                return .block("mobileads.google.com")
            }
        }
    }
}
