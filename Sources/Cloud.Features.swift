import Foundation
import Archivable

extension Cloud where A == Archive {
    public func bookmark(_ id: Int) {
        mutating { archive in
            archive
                .browse
                .first {
                    $0.id == id
                }
                .map { browse in
                    archive.bookmarks.removeAll {
                        $0.access.string.lowercased() == browse.page.access.string.lowercased()
                    }
                    archive.bookmarks.append(browse.page)
                }
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
}
