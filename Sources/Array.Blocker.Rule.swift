import Foundation

extension Array where Element == Blocker.Rule {
    var content: String {
        reduce(into: "[") {
            $0 += $0.count > 1 ? "," : ""
            $0 += "{" + $1.action.content + "," + $1.trigger.content + "}"
        } + "]"
    }
}
