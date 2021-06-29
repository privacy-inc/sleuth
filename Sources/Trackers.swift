import Foundation

public enum Trackers {
    case
    attempts,
    recent
    
    func sort(_ blocked: [String: [Date]]) -> [(key: String, value: [Date])] {
        switch self {
        case .attempts:
            return blocked
                .sorted {
                    $0.1.count == $1.1.count
                        ? $0.0.localizedCaseInsensitiveCompare($1.0) == .orderedAscending
                        : $0.1.count > $1.1.count
                }
        case .recent:
            return blocked
                .sorted {
                    guard
                        let left = $0.1.last,
                        let right = $1.1.last
                    else { return false }
                    return left > right
                }
        }
    }
}
