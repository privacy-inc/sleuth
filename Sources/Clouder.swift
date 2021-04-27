import Foundation
import Archivable

extension Clouder where C == Repository {
    public func url(_ string: String) {
        queue.async {
            var archive = archive.value
            archive.entries.append(.init(id: archive.counter, title: "", url: string))
            archive.counter += 1
            save(&archive)
        }
    }
}
