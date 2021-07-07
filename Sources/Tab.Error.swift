import Foundation

extension Tab {
    public struct Error: Equatable {
        public let domain: String
        public let url: String
        public let description: String
        
        public init(url: String, description: String) {
            self.url = url
            self.description = description
            domain = Tld.deconstruct(url: url).domain
        }
    }
}
