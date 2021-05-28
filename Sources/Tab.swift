import Foundation
import Combine

public struct Tab {
    public let items = CurrentValueSubject<[Item], Never>([.init()])
    
    public init() { }
    
    public func new() -> UUID {
        items
            .value
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
                items.value.insert($0, at: 0)
                return $0.id
            } (Item())
    }
    
    public func browse(_ id: UUID, _ browse: Int) {
        items
            .value
            .mutate(id) {
                $0.with(state: .browse(browse))
            }
    }
    
    public func error(_ id: UUID, _ error: Error) {
        items
            .value
            .mutate(id) {
                switch $0.state {
                case let .browse(browse), let .error(browse, _):
                    return $0.with(state: .error(browse, error))
                default:
                    return nil
                }
            }
    }
    
    public func dismiss(_ id: UUID) {
        items
            .value
            .mutate(id) {
                switch $0.state {
                case let .error(browse, _):
                    return $0.with(state: .browse(browse))
                default:
                    return nil
                }
            }
    }
    
    public func clear(_ id: UUID) {
        items
            .value
            .mutate(id) {
                .init(id: $0.id)
            }
    }
    
    public func close(_ id: UUID) {
        var items = self.items.value
        items
            .remove {
                $0.id == id
            }
        if items.isEmpty {
            items = [.init()]
        }
        self.items.send(items)
    }
    
    public func closeAll() -> UUID {
        items.send([.init()])
        return items.value.first!.id
    }
    
    public func update(_ id: UUID, progress: Double) {
        items
            .value
            .mutate(id) {
                $0.with(progress: progress)
            }
    }
    
    public func update(_ id: UUID, loading: Bool) {
        items
            .value
            .mutate(id) {
                $0.with(loading: loading)
            }
    }
    
    public func update(_ id: UUID, forward: Bool) {
        items
            .value
            .mutate(id) {
                $0.with(forward: forward)
            }
    }
    
    public func update(_ id: UUID, back: Bool) {
        items
            .value
            .mutate(id) {
                $0.with(back: back)
            }
    }
    
    public func update(_ id: UUID, web: AnyObject?) {
        items
            .value
            .mutate(id) {
                $0.with(web: web)
            }
    }
    
    public func update(_ id: UUID, snapshot: AnyObject?) {
        items
            .value
            .mutate(id) {
                $0.with(snapshot: snapshot)
            }
    }
}
