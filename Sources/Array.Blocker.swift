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
        .joined(separator: ", ") + "]"
    }
}

extension Array where Element == Blocker.Rule.Trigger {
    private var content: String {
        map {
            switch $0 {
            case .url:
                return """
"url-filter": ".*"
"""
            case let .domain(domain):
                return """
"if-domain": ["\(domain
                    .map {
                        "*" + $0
                    }
                    .joined(separator: ", "))"]
"""
            }
        }
        .joined(separator: ", ")
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
