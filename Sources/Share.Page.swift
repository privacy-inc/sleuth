import Foundation

public extension Share {
    struct Page: Codable, Equatable {
        public let url: URL
        public let title: String
        public let subtitle: String
    }
}

