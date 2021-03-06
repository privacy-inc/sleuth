import Foundation
import Archivable

extension Cloud where A == Archive {
    public func bookmark(_ browse: Int) {
        mutating { archive in
            archive
                .browses
                .first {
                    $0.id == browse
                }
                .map { browse in
                    archive.bookmarks.removeAll {
                        $0.access.value.lowercased() == browse.page.access.value.lowercased()
                    }
                    archive.bookmarks.append(browse.page)
                }
        }
    }
    
    public func remove(bookmark: Int) {
        mutating {
            guard $0.bookmarks.count > bookmark else { return }
            $0.bookmarks.remove(at: bookmark)
        }
    }
    
    public func remove(browse: Int) {
        mutating {
            $0.browses.remove {
                $0.id == browse
            }
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
}
