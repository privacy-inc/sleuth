import Foundation
import Archivable

extension Cloud where A == Archive {
    public static let shared = Self(manifest: .init(
                                        file: "Privacy.archive",
                                        container: "iCloud.privacy",
                                        prefix: "privacy_",
                                        title: "Privacy"))
    
    public func browse(_ search: String, id: Int?, completion: @escaping (Int) -> Void) {
        mutating {
            $0.browse(search, id: id)
        } completion: {
            completion($0)
        }
    }
    
    public func navigate(_ url: URL, completion: @escaping (Int) -> Void) {
        mutating(transform: {
            $0.add(.init(url: url))
        }, completion: completion)
    }
    
    public func revisit(_ id: Int) {
        mutating {
            guard let page = $0.browse.remove(where: { $0.id == id })?.revisit else { return }
            $0.browse.insert(page, at: 0)
        }
    }
    
    public func update(_ id: Int, title: String) {
        mutating {
            guard let page = $0.browse.remove(where: { $0.id == id })?
                    .with(title: title.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            $0.browse.insert(page, at: 0)
        }
    }
    
    public func update(_ id: Int, url: URL) {
        mutating {
            guard let page = $0.browse.remove(where: { $0.id == id })?
                    .with(access: .init(url: url)) else { return }
            $0.browse.insert(page, at: 0)
        }
    }
    
    public func bookmark(_ id: Int) {
        mutating { archive in
            archive
                .browse
                .first {
                    $0.id == id
                }
                .map { browse in
                    archive.bookmarks.removeAll {
                        $0.string == browse.page.string
                    }
                    archive.bookmarks.append(browse.page)
                }
        }
    }
    
    public func open(_ bookmark: Int) {
        mutating {
            guard bookmark < $0.bookmarks.count else { return }
            $0.add($0.bookmarks[bookmark].access)
        }
    }
    
    public func remove(_ id: Int) {
        mutating {
            $0.browse.remove { $0.id == id }
        }
    }
    
    public func activity() {
        mutating {
            let now = Date()
            let last = $0.activity.last ?? .distantPast
            if last < Calendar.current.date(byAdding: .minute, value: -1, to: now)! {
                $0.activity.append(now)
            }
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
            $0.browse = []
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
