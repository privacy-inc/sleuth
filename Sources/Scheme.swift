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
    
    func web(_ url: URL) -> String? {
        switch self {
        case .http, .https: return .init(url.absoluteString.dropFirst(rawValue.count + 3))
        default: return nil
        }
    }
}
