import Foundation

extension Legacy {
    struct Page: Codable, Identifiable, Hashable {
        var url: URL
        var date: Date
        var title: String
        let id: UUID
        
        var shared: Legacy.Share.Page {
            .init(url: URL(string: Scheme.privacy_id.url + id.uuidString)!,
                  title: title,
                  subtitle: url.absoluteString
                    .replacingOccurrences(of: "https://", with: "")
                    .replacingOccurrences(of: "http://", with: "")
                    .replacingOccurrences(of: "www.", with: ""))
        }
        
        init(url: URL) {
            id = .init()
            date = .init()
            title = ""
            self.url = url
        }
        
        func hash(into: inout Hasher) {
            into.combine(id)
            into.combine(url)
            into.combine(title)
            into.combine(date)
        }
        
        static func == (lhs: Page, rhs: Page) -> Bool {
            lhs.id == rhs.id
                && lhs.url == rhs.url
                && lhs.title == rhs.title
                && lhs.date == rhs.date
        }
    }
}
