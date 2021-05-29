import Foundation
import Archivable

extension Array where Element == Tab.Item {
    public var ids: [UUID] {
        map(\.id)
    }
    
    public subscript(state id: UUID) -> Tab.State {
        self[id]?.state ?? .new
    }
    
    public subscript(progress id: UUID) -> Double {
        self[id]?.progress ?? 0
    }
    
    public subscript(loading id: UUID) -> Bool {
        self[id]?.loading ?? false
    }
    
    public subscript(forward id: UUID) -> Bool {
        self[id]?.forward ?? false
    }
    
    public subscript(back id: UUID) -> Bool {
        self[id]?.back ?? false
    }
    
    public subscript(web id: UUID) -> AnyObject? {
        self[id]?.web
    }
    
    public subscript(snapshot id: UUID) -> AnyObject? {
        self[id]?.snapshot
    }
    
    mutating func mutate(_ id: UUID, transform: (Element) -> Element?) {
        mutate(where: {
            $0
                .firstIndex {
                    $0.id == id
                }
        }, transform: transform)
    }
    
    subscript(_ id: UUID) -> Element? {
        first {
            $0.id == id
        }
    }
}
