import Foundation
import Archivable

public struct Tab {
    public internal(set) var items = [Item()]
    
    public init() { }
    
    public mutating func new() -> UUID {
        items
            .first {
                switch $0.state {
                case .new:
                    return true
                default:
                    return false
                }
            }
            .map(\.id)
            ?? {
                items.insert($0, at: 0)
                return $0.id
            } (Item())
    }
    
    public mutating func browse(_ id: UUID, _ browse: Int) {
        items
            .mutate {
                $0
                    .firstIndex {
                        $0.id == id
                    }
            } transform: {
                $0.with(state: .browse(browse))
            }
    }
    
    public mutating func error(_ id: UUID, _ error: WebError) {
        items
            .mutate {
                $0
                    .firstIndex {
                        $0.id == id
                    }
            } transform: {
                switch $0.state {
                case let .browse(browse), let .error(browse, _):
                    return $0.with(state: .error(browse, error))
                default:
                    return nil
                }
            }
    }
    
    public mutating func dismiss(_ id: UUID) {
        items
            .mutate {
                $0
                    .firstIndex {
                        $0.id == id
                    }
            } transform: {
                switch $0.state {
                case let .error(browse, _):
                    return $0.with(state: .browse(browse))
                default:
                    return nil
                }
            }
    }
    
    public func state(_ id: UUID) -> State {
        items
            .first {
                $0.id == id
            }
            .map(\.state)
            ?? .new
    }
    
    public mutating func close(_ id: UUID) {
        items
            .remove {
                $0.id == id
            }
        if items.isEmpty {
            items = [.init()]
        }
    }
    
    public mutating func closeAll() -> UUID {
        items = [.init()]
        return items.first!.id
    }
}
