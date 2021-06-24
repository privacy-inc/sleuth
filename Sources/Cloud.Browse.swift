import Foundation
import Archivable

extension Cloud where A == Archive {
    public func browse(_ search: String, browse: Int?, completion: @escaping (Int, Page.Access) -> Void) {
        mutating {
            $0.browse(search, browse: browse)
        } completion: {
            completion($0.browse, $0.access)
        }
    }
    
    public func navigate(_ url: URL, completion: @escaping (Int, Page.Access) -> Void) {
        mutating {
            let access = Page.Access(url: url)
            return ($0.add(access), access)
        } completion: { (browse: Int, access: Page.Access) in
            completion(browse, access)
        }
    }
    
    public func revisit(_ browse: Int) {
        mutating {
            guard let browse = $0.browses.remove(where: { $0.id == browse })?.revisit else { return }
            $0.browses.insert(browse, at: 0)
        }
    }
    
    public func update(_ browse: Int, title: String) {
        mutating {
            guard let page = $0.browses.remove(where: { $0.id == browse })?
                    .with(title: title.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            $0.browses.insert(page, at: 0)
        }
    }
    
    public func update(_ browse: Int, url: URL) {
        mutating {
            guard let page = $0.browses.remove(where: { $0.id == browse })?
                    .with(access: .init(url: url)) else { return }
            $0.browses.insert(page, at: 0)
        }
    }
    
    public func open(_ bookmark: Int, completion: @escaping (Int) -> Void) {
        mutating(transform: { archive in
            guard bookmark < archive.bookmarks.count else { return nil }
            return archive.add(archive.bookmarks[bookmark].access)
        }, completion: completion)
    }
}
