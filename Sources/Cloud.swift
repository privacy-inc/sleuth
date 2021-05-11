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
            guard let page = $0.history.remove(id: id)?.revisit else { return }
            $0.history.append(page)
        }
    }
    
    public func update(_ id: Int, title: String) {
        mutating {
            guard let page = $0.history.remove(id: id)?.with(title: title.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            $0.history.append(page)
        }
    }
    
    public func update(_ id: Int, url: URL) {
        mutating {
            guard let page = $0.history.remove(id: id)?.with(access: .init(url: url)) else { return }
            $0.history.append(page)
        }
    }
    
    public func bookmark(_ id: Int) {
        mutating { archive in
            archive
                .history
                .first {
                    $0.id == id
                }
                .map { history in
                    archive.bookmarks.removeAll {
                        $0.subtitle == history.subtitle
                    }
                    archive.bookmarks.append(history.page)
                }
        }
    }
    
    public func remove(_ id: Int) {
        mutating {
            $0.history.remove(id: id)
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
            $0.history = []
            $0.activity = []
            $0.blocked = [:]
            $0.counter = 0
        }
    }
    
    public func engine(_ engine: Engine) {
        mutating {
            $0.settings.engine = engine
        }
    }
    
    public func javascript(_ enabled: Bool) {
        mutating {
            $0.settings.javascript = enabled
        }
    }
    
    public func dark(_ force: Bool) {
        mutating {
            $0.settings.dark = force
        }
    }
    
    public func popups(_ allowed: Bool) {
        mutating {
            $0.settings.popups = allowed
        }
    }
    
    public func ads(_ allowed: Bool) {
        mutating {
            $0.settings.ads = allowed
        }
    }
    
    public func screen(_ allowed: Bool) {
        mutating {
            $0.settings.screen = allowed
        }
    }
    
    public func trackers(_ allowed: Bool) {
        mutating {
            $0.settings.trackers = allowed
        }
    }
    
    public func cookies(_ allowed: Bool) {
        mutating {
            $0.settings.cookies = allowed
        }
    }
    
    public func http(_ allowed: Bool) {
        mutating {
            $0.settings.http = allowed
        }
    }
    
    public func location(_ allowed: Bool) {
        mutating {
            $0.settings.location = allowed
        }
    }
}
