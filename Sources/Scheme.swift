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
    
    static let joiner = "://"
    
    public var url: String {
        rawValue + Self.joiner
    }
}
