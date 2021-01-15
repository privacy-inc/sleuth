import Foundation

extension Block {
    struct Trigger: CustomStringConvertible, Hashable, Equatable {
        let url: String
        let domain: String
        
        init(site: Site.Allow) {
            url = ".*"
            domain = "*" + site.rawValue
        }
        
        init(site: Site.Partial) {
            url = site.url
            domain = site.domain.rawValue
        }
        
        init(site: Site.Domain) {
            url = ".*"
            domain = site.rawValue.components(separatedBy: ".").count > 2 ? "*" + site.rawValue : site.rawValue
        }
        
        var description: String {
            """
"trigger": {
    "url-filter": "\(url)",
    "if-domain": ["\(domain)"]
}
"""
        }
        
        func hash(into: inout Hasher) {
            into.combine(domain)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.domain == rhs.domain
        }
    }
}
