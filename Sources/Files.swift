import Foundation
import Combine

public extension FileManager {
    static var pages: Future<Set<Page>, Never> {
        .init { result in
            queue.async {
                guard instance.fileExists(atPath: folder.path) else { return result(.success([])) }
                result(
                    .success(
                        .init((try? instance.contentsOfDirectory(at: folder, includingPropertiesForKeys: [], options: .skipsHiddenFiles))
                                .map {
                                    $0.compactMap {
                                        try? JSONDecoder().decode(Page.self, from: .init(contentsOf: $0))
                                    }
                                } ?? []
                        )
                    )
                )
            }
        }
    }
    
    static func page(_ id: String) -> Future<Page, Never> {
        .init { result in
            queue.async {
                (try? JSONDecoder().decode(Page.self, from: .init(contentsOf: folder.appendingPathComponent(id))))
                    .map {
                        result(.success($0))
                    }
            }
        }
    }
    
    static func save(_ page: Page) {
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
    
    static func delete(_ page: Page) {
        queue.async {
            try? instance.removeItem(at: folder.appendingPathComponent(page.id.uuidString))
        }
    }
    
    static func forget() {
        queue.async {
            try? instance.removeItem(at: folder)
        }
    }
    
    private static let queue = DispatchQueue(label: "", qos: .utility)
    private static let instance = `default`
    private static let root = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private static let folder = root.appendingPathComponent("pages")
}
