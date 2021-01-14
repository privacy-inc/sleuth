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
    privacy_forget = "privacy-forget",
    privacy_trackers = "privacy-trackers"
    
    public var url: String {
        rawValue + "://"
    }
    
    func schemeless(_ url: URL) -> String? {
        switch self {
        case .http, .https: return .init(url.absoluteString.dropFirst(self.url.count))
        default: return nil
        }
    }
}
