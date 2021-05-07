import Foundation

extension Array where Element == Blocker.Rule {
    var content: String {
        "[" + map {
            """
{
    "action": {
        \($0.action.content)
    },
    "trigger": {
        \($0.trigger.content)
    }
}
"""
        }
        .joined(separator: ",") + "]"
    }
}

private extension Blocker.Rule.Action {
    var content: String {
        switch self {
        case .cookies:
            return """
"type": "block-cookies"
"""
        case .http:
            return """
"type": "make-https"
"""
        case let .css(css):
            return """
"type": "css-display-none",
"selector": "\(css.joined(separator: ", "))"
"""
        }
    }
}

private extension Blocker.Rule.Trigger {
    var content: String {
        switch self {
        case .all:
            return """
"url-filter": ".*"
"""
        case let .url(url):
            return """
"url-filter": "^https?://+([^:/]+\\\\.)?\(url.rawValue)\\\\.\(url.tld)[:/]",
"url-filter-is-case-sensitive": true,
"if-domain": ["*\(url.rawValue).\(url.tld.rawValue)"],
"load-type": ["first-party"],
"resource-type": ["document"]
"""
        }
    }
}
