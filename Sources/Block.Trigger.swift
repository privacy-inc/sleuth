import Foundation

extension Block {
    struct Trigger: CustomStringConvertible, Hashable, Equatable {
        let url: String
        let domain: String
        
        init(site: Sites, component: String = ".*") {
            url = component
            domain = "*" + site.rawValue
        }
        
        init(site: Sites.Blacklist) {
            url = ".*"
            domain = site.rawValue.components(separatedBy: ".").count > 1 ? "*" + site.rawValue : site.rawValue
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
