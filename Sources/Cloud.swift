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
    
    public func browse(_ search: String, completion: @escaping(Engine.Browse, Int) -> Void) {
        mutating {
            guard let browse = Defaults.engine.browse(search) else { return nil }
            return (browse, $0.add(browse))
        } completion: { (result: (Engine.Browse, Int)) in
            completion(result.0, result.1)
        }
    }
    
    public func browse(_ id: Int, _ search: String, completion: @escaping(Engine.Browse) -> Void) {
        mutating {
            guard let browse = Defaults.engine.browse(search) else { return nil }
            if let entry = $0.entries.remove(id: id)?.with(browse: browse) {
                $0.entries.append(entry)
            } else {
                $0.add(browse)
            }
            return browse
        } completion: {
            completion($0)
        }
    }
    
    public func navigate(_ url: URL, completion: @escaping(Int) -> Void) {
        mutating {
            $0.add(url)
        } completion: {
            completion($0)
        }
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
    
    public func validate(_ url: URL, with protection: Protection) -> Protection.Result {
        url.scheme.flatMap {
            Site.Ignore(rawValue: $0)
                .map { _ in
                    .ignore
                } ?? Scheme(rawValue: $0)
                    .map { _ in
                        switch protection {
                        case .antitracker:
                            if let domain = url.host {
                                for site in Site.Domain.allCases {
                                    guard domain.hasSuffix(site.rawValue) else { continue }
                                    block(site.rawValue)
                                    return .block
                                }
                                
                                for site in Site.Partial.allCases {
                                    guard
                                        domain.hasSuffix(site.domain.rawValue),
                                        url.path.hasPrefix(site.rawValue)
                                    else { continue }
                                    block(site.url)
                                    return .block
                                }
                                
                                for item in domain.components(separatedBy: ".").dropLast() {
                                    guard Site.Component(rawValue: item) == nil else {
                                        block(domain)
                                        return .block
                                    }
                                    continue
                                }
                            }
                        default: break
                        }
                        return .allow
                    }
        } ?? .external
    }
    
    public func block(_ url: String) {
        mutating {
            $0.blocked[url, default: []].append(.init())
        }
    }
    
    public func forget() {
        mutating {
            $0.entries = []
            $0.activity = []
            $0.blocked = [:]
        }
    }
    
    public func migrate() {
        guard archive.value == .new else { return }
        
        var sub: AnyCancellable?
        sub = FileManager
            .pages
            .sink { pages in
                sub?.cancel()
                
                mutating { archive in
                    archive.entries = pages
                        .filter {
                            !$0.url.isFileURL
                        }
                        .enumerated()
                        .map {
                            .init(id: $0.0, title: $0.1.title, bookmark: .remote($0.1.url.absoluteString), date: $0.1.date)
                        }
                    archive.counter = archive.entries.count

                    archive.blocked = Legacy.Share.blocked.reduce(into: [:]) {
                        $0[$1, default: []].append(.init())
                    }
                    
                    archive.activity = Legacy.Share.chart
                    
                    if !pages.isEmpty {
                        FileManager.forget()
                    }
                    
                    if !Legacy.Share.blocked.isEmpty {
                        Legacy.Share.blocked = []
                    }
                    
                    if !Legacy.Share.chart.isEmpty {
                        Legacy.Share.chart = []
                    }
                    
                    if !Legacy.Share.history.isEmpty {
                        Legacy.Share.history = []
                    }
                }
            }
    }
}
