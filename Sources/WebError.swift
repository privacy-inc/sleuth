import Foundation

public struct WebError {
    public var domain: String {
        url.domain
    }
    
    public let url: String
    public let description: String
    
    public init(url: String, description: String) {
        self.url = url
        self.description = description
    }
}
