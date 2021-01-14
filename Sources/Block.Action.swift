import Foundation

extension Block {
    enum Action: CustomStringConvertible, Hashable {
        case
        css(String),
        block
        
        var description: String {
            """
"action": {
\({
    switch self {
    case let .css(selector): return """
    "type": "css-display-none",
    "selector": "\(selector)"
"""
    case .block: return """
    "type": "block"
"""
    }
} () as String)
}
"""
        }
        
        func hash(into: inout Hasher) {
            into.combine(description)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.description == rhs.description
        }
    }
}
