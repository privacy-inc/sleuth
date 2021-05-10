import Foundation
import Combine
import Archivable

extension Cloud where A == Archive {
    public static let shared = Self(manifest: .init(
                                        file: "Privacy.archive",
                                        container: "iCloud.privacy",
                                        prefix: "privacy_",
                                        title: "Privacy"))
    
    public func browse(_ search: String, completion: @escaping(Int, Browse) -> Void) {
        mutating {
            $0.browse(search)
        } completion: {
            completion($0.0, $0.1)
        }
    }
    
    public func browse(_ id: Int, _ search: String, completion: @escaping(Browse) -> Void) {
        mutating(transform: {
            $0.browse(id, search)
        }, completion: completion)
    }
    
    public func navigate(_ url: URL, completion: @escaping(Int) -> Void) {
        mutating(transform: {
            $0.add(url)
        }, completion: completion)
    }
    
    public func revisit(_ id: Int) {
        mutating {
            guard let page = $0.pages.remove(id: id)?.revisit else { return }
            $0.pages.append(page)
        }
    }
    
    public func update(_ id: Int, title: String) {
        mutating {
            guard let page = $0.pages.remove(id: id)?.with(title: title.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            $0.pages.append(page)
        }
    }
    
    public func update(_ id: Int, url: URL) {
        mutating {
            guard let page = $0.pages.remove(id: id)?.with(url: url) else { return }
            $0.pages.append(page)
        }
    }
    
    public func remove(_ id: Int) {
        mutating {
            $0.pages.remove(id: id)
        }
    }
    
    public func activity() {
        mutating {
            $0.activity.append(.init())
        }
    }
    
    public func policy(_ url: URL) -> Policy {
        {
            switch $0 {
            case let .block(block):
                mutating {
                    $0.blocked[block, default: []].append(.init())
                }
            default:
                break
            }
            return $0
        } (archive.value.settings.router(url))
    }
    
    public func forget() {
        mutating {
            $0.pages = []
            $0.activity = []
            $0.blocked = [:]
            $0.counter = 0
        }
    }
}
