import Foundation
import Archivable

extension Cloud where A == Archive {
    public func browse(_ search: String, id: Int?, completion: @escaping (Int, Page.Access) -> Void) {
        mutating {
            $0.browse(search, id: id)
        } completion: {
            completion($0.id, $0.access)
        }
    }
    
    public func navigate(_ url: URL, completion: @escaping (Int, Page.Access) -> Void) {
        mutating {
            let access = Page.Access(url: url)
            return ($0.add(access), access)
        } completion: { (id: Int, access: Page.Access) in
            completion(id, access)
        }
    }
    
    public func revisit(_ id: Int, completion: @escaping (Page.Access) -> Void) {
        mutating(transform: {
            guard let browse = $0.browse.remove(where: { $0.id == id })?.revisit else { return nil }
            $0.browse.insert(browse, at: 0)
            return browse.page.access
        }, completion: completion)
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
    
    public func open(_ bookmark: Int, id: Int?, completion: @escaping (Int, Page.Access) -> Void) {
        mutating { archive in
            guard bookmark < archive.bookmarks.count else { return nil }
            return {
                (archive.update(id, $0) ?? archive.add($0), $0)
            } (archive.bookmarks[bookmark].access)
        } completion: {
            completion($0, $1)
        }
    }
}
