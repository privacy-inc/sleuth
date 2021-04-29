import Foundation
import Combine
import Archivable

extension Clouder where C == Repository {
    public func browse(_ engine: Engine, _ url: String) -> Future<(Engine.Browse, Int)?, Never> {
        .init { promise in
            mutating {
                guard let browse = engine.browse(url) else {
                    return promise(.success(nil))
                }
                let id = $0.counter
                $0.entries.append(.init(id: id, browse: browse))
                $0.counter += 1
                promise(.success((browse, id)))
            }
        }
    }
    
    public func navigate(_ url: URL) -> Future<Int, Never> {
        .init { promise in
            mutating {
                let id = $0.counter
                $0.entries.append(.init(id: id, url: url))
                $0.counter += 1
                promise(.success(id))
            }
        }
    }
    
    @discardableResult public func revisit(_ id: Int) -> Future<Entry?, Never> {
        .init { promise in
            mutating {
                guard let entry = $0.entries.remove(id: id)?.revisit else {
                    return promise(.success(nil))
                }
                $0.entries.append(entry)
                promise(.success(entry))
            }
        }
    }
}
