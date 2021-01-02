import Foundation

public enum Scheme: String {
    case
    https,
    http,
    data,
    file,
    privacy,
    privacy_id = "privacy-id",
    privacy_search = "privacy-search",
    privacy_forget = "privacy-forget"
    
    public var url: String {
        rawValue + "://"
    }
    
    func web(_ url: URL) -> String? {
        switch self {
        case .http, .https: return .init(url.absoluteString.dropFirst(self.url.count))
        default: return nil
        }
    }
}
