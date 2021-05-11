import Foundation

public struct Tab {
    public internal(set) var items = [Item()]
    
    public mutating func new() -> Item {
        items
            .first {
                switch $0.state {
                case .new:
                    return true
                default:
                    return false
                }
            }
            ?? {
                items.append($0)
                return $0
            } (Item())
    }
}
