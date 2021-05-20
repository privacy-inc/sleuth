import Foundation
import Archivable

public struct Tab {
    var items = [Item()]
    
    public init() { }
    
    public var ids: [UUID] {
        items.map(\.id)
    }
    
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
        mutate(id) {
            $0.with(state: .browse(browse))
        }
    }
    
    public mutating func error(_ id: UUID, _ error: WebError) {
        mutate(id) {
            switch $0.state {
            case let .browse(browse), let .error(browse, _):
                return $0.with(state: .error(browse, error))
            default:
                return nil
            }
        }
    }
    
    public mutating func dismiss(_ id: UUID) {
        mutate(id) {
            switch $0.state {
            case let .error(browse, _):
                return $0.with(state: .browse(browse))
            default:
                return nil
            }
        }
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
    
    public func state(_ id: UUID) -> State {
        self[id]?.state ?? .new
    }
    
    public subscript(progress id: UUID) -> Double {
        get {
            self[id]?.progress ?? 0
        }
        set {
            mutate(id) {
                $0.with(progress: newValue)
            }
        }
    }
    
    public subscript(loading id: UUID) -> Bool {
        get {
            self[id]?.loading ?? false
        }
        set {
            mutate(id) {
                $0.with(loading: newValue)
            }
        }
    }
    
    public subscript(forward id: UUID) -> Bool {
        get {
            self[id]?.forward ?? false
        }
        set {
            mutate(id) {
                $0.with(forward: newValue)
            }
        }
    }
    
    public subscript(back id: UUID) -> Bool {
        get {
            self[id]?.back ?? false
        }
        set {
            mutate(id) {
                $0.with(back: newValue)
            }
        }
    }
    
    public subscript(web id: UUID) -> AnyObject? {
        get {
            self[id]?.web
        }
        set {
            mutate(id) {
                $0.with(web: newValue)
            }
        }
    }
    
    public subscript(snapshot id: UUID) -> AnyObject? {
        get {
            self[id]?.snapshot
        }
        set {
            mutate(id) {
                $0.with(snapshot: newValue)
            }
        }
    }
    
    private subscript(_ id: UUID) -> Item? {
        items
            .first {
                $0.id == id
            }
    }
    
    private mutating func mutate(_ id: UUID, transform: (Item) -> Item?) {
        items
            .mutate(where: {
                $0
                    .firstIndex {
                        $0.id == id
                    }
            }, transform: transform)
    }
}
