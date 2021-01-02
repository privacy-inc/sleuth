import Foundation

public enum Scheme: String {
    case
    https,
    http,
    data,
    file,
    privacy,
    privacy_id,
    privacy_search
    
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
