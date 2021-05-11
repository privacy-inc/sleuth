import Foundation

public struct Error {
    public let url: String
    public let description: String
    
    public init(url: String, description: String) {
        self.url = url
        self.description = description
    }
}
