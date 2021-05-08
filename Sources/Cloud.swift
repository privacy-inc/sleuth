import Foundation
import Combine
import Archivable

extension Cloud where A == Archive {
    public static let shared = Self(manifest: .init(
                                        file: "Privacy.archive",
                                        container: "iCloud.privacy",
                                        prefix: "privacy_",
                                        title: "Privacy"))
    
    public func entry(_ id: Int) -> Entry? {
        archive.value.entries.first {
            $0.id == id
        }
    }
    
    public func browse(_ search: String, completion: @escaping(Browse, Int) -> Void) {
        mutating {
            guard let browse = Defaults.engine.browse(search) else { return nil }
            return (browse, $0.add(browse))
        } completion: { (result: (Browse, Int)) in
            completion(result.0, result.1)
        }
    }
    
    public func browse(_ id: Int, _ search: String, completion: @escaping(Browse) -> Void) {
        mutating(transform: {
            guard let browse = Defaults.engine.browse(search) else { return nil }
            if let entry = $0.entries.remove(id: id)?.with(browse: browse) {
                $0.entries.append(entry)
            } else {
                $0.add(browse)
            }
            return browse
        }, completion: completion)
    }
    
    public func navigate(_ url: URL, completion: @escaping(Int) -> Void) {
        mutating(transform: {
            $0.add(url)
        }, completion: completion)
    }
    
    public func revisit(_ id: Int) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.revisit else { return }
            $0.entries.append(entry)
        }
    }
    
    public func update(_ id: Int, title: String) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.with(title: title.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            $0.entries.append(entry)
        }
    }
    
    public func update(_ id: Int, url: URL) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.with(url: url) else { return }
            $0.entries.append(entry)
        }
    }
    
    public func remove(_ id: Int) {
        mutating {
            $0.entries.remove(id: id)
        }
    }
    
    public func activity() {
        mutating {
            $0.activity.append(.init())
        }
    }
    
    public func block(_ issue: String) {
        mutating {
            $0.blocked[issue, default: []].append(.init())
        }
    }
    
    public func forget() {
        mutating {
            $0.entries = []
            $0.activity = []
            $0.blocked = [:]
        }
    }
}
