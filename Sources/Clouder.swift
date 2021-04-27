import Foundation
import Combine
import Archivable

extension Clouder where C == Repository {
    public func browse(_ engine: Engine, _ url: String) -> Future<(Engine.Browse, Int)?, Never> {
        .init { promise in
            queue.async {
                guard let browse = engine.browse(url) else {
                    return promise(.success(nil))
                }
                var archive = archive.value
                let id = archive.counter
                archive.entries.append(.init(id: id, title: "", url: browse.url))
                archive.counter += 1
                save(&archive)
                promise(.success((browse, id)))
            }
        }
    }
    
    func url(_ string: String) {
        queue.async {
            var archive = archive.value
            archive.entries.append(.init(id: archive.counter, title: "", url: string))
            archive.counter += 1
            save(&archive)
        }
    }
}
