import Foundation

extension Ads {
    struct Trigger: CustomStringConvertible, Hashable, Equatable {
        let domain: String
        
        init(whitelist: Whitelist) {
            domain = "https" + whitelist.rawValue
        }
        
        var description: String {
            """
"trigger": {
"url-filter": "\(domain)"
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
