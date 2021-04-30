import Foundation
import Combine

extension FileManager {
    static var pages: Future<[Legacy.Page], Never> {
        .init { result in
            queue.async {
                guard instance.fileExists(atPath: folder.path) else { return result(.success([])) }
                result(
                    .success(
                        (try? instance.contentsOfDirectory(at: folder, includingPropertiesForKeys: [], options: .skipsHiddenFiles))
                            .map {
                                $0.compactMap {
                                    try? JSONDecoder().decode(Legacy.Page.self, from: .init(contentsOf: $0))
                                }
                            }?.sorted { $0.date < $1.date } ?? []
                    )
                )
            }
        }
    }
    
    static func page(_ id: String) -> Future<Legacy.Page, Never> {
        .init { result in
            queue.async {
                (try? JSONDecoder().decode(Legacy.Page.self, from: .init(contentsOf: folder.appendingPathComponent(id))))
                    .map {
                        result(.success($0))
                    }
            }
        }
    }
    
    static func delete(_ page: Legacy.Page) {
        queue.async {
            try? instance.removeItem(at: folder.appendingPathComponent(page.id.uuidString))
        }
    }
    
    static func forget() {
        queue.async {
            try? instance.removeItem(at: folder)
        }
    }
    
    static func save(_ page: Legacy.Page) {
        queue.async {
            var url = folder
            if !instance.fileExists(atPath: url.path) {
                var resources = URLResourceValues()
                resources.isExcludedFromBackup = true
                try? url.setResourceValues(resources)
                try? instance.createDirectory(at: url, withIntermediateDirectories: true)
            }
            try? JSONEncoder().encode(page).write(to: url.appendingPathComponent(page.id.uuidString), options: .atomic)
        }
    }
    
    static let queue = DispatchQueue(label: "", qos: .utility)
    static let folder = root.appendingPathComponent("pages")
    private static let instance = `default`
    private static let root = instance.urls(for: .documentDirectory, in: .userDomainMask)[0]
}
