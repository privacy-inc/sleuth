import Foundation

extension Legacy.Share {
    struct Page: Codable, Equatable {
        let url: URL
        let title: String
        let subtitle: String
    }
}

