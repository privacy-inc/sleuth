import Foundation

extension Array where Element == Blocker.Rule {
    var content: String {
        "[" + map {
            """

{
    "action": {
        \($0.actions.content)
    },
    "trigger": {
        \($0.triggers.content)
    }
}
"""
        }
        .joined(separator: ",") + "]"
    }
}

extension Array where Element == Blocker.Rule.Trigger {
    private var content: String {
        map {
            switch $0 {
            case .all:
                return """
"url-filter": ".*"
"""
            case .sensitive:
                return """
"url-filter-is-case-sensitive": true
"""
            case .document:
                return """
"resource-type": ["document"]
"""
            case .first:
                return """
"load-type": ["first-party"]
"""
            case let .url(url):
                return """
"url-filter": "^https?://\(url.prefix)\\\\.\(url.rawValue)\\\\.\(url.tld)[:/]"
"""
            case let .domain(domain):
                return """
"if-domain": ["\(domain.prefix).\(domain.rawValue).\(domain.tld.rawValue)"]
"""
            }
        }
        .joined(separator: """
,
        
""")
    }
}

extension Array where Element == Blocker.Rule.Action {
    private var content: String {
        map {
            switch $0 {
            case .block:
                return """
"type": "block"
"""
            case .cookies:
                return """
"type": "block-cookies"
"""
            case .http:
                return """
"type": "make-https"
"""
            case .css:
                return """
"type": "css-display-none"
"""
            case let .selector(selector):
                return """
"selector": "\(selector
                .joined(separator: ", "))"
"""
            }
        }
        .joined(separator: ", ")
    }
}
