import Foundation

public extension Legacy.Share {
    struct Page: Codable, Equatable {
        public let url: URL
        public let title: String
        public let subtitle: String
    }
}

