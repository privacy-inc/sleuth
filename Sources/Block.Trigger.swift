import Foundation

extension Block {
    struct Trigger: CustomStringConvertible, Hashable, Equatable {
        let domain: String
        
        init(whitelist: Whitelist) {
            domain = ".*" + whitelist.rawValue
        }
        
        init(end: Wildcard.End) {
            domain = ".*" + end.rawValue
        }
        
        init(https: Blacklist.Https) {
            domain = "https://" + https.rawValue
        }
        
        init(http: Blacklist.Http) {
            domain = "http://" + http.rawValue
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
