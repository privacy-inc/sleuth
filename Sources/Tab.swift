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
    
    public mutating func history(_ id: UUID, _ history: Int) {
        items.mutate {
            $0
                .firstIndex {
                    $0.id == id
                }
        } transform: {
            $0.with(state: .history(history))
        }
    }
    
    public mutating func error(_ id: UUID, _ error: Error) {
        items.mutate {
            $0
                .firstIndex {
                    $0.id == id
                }
        } transform: {
            switch $0.state {
            case let .history(history), let .error(history, _):
                return $0.with(state: .error(history, error))
            default:
                return nil
            }
        }
    }
    
    public mutating func dismiss(_ id: UUID) {
        items.mutate {
            $0
                .firstIndex {
                    $0.id == id
                }
        } transform: {
            switch $0.state {
            case let .error(history, _):
                return $0.with(state: .history(history))
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
}
