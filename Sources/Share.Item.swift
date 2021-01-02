import Foundation

public extension Share {
    struct Item: Codable {
        public let url: URL
        public let title: String
        public let subtitle: String
    }
}

