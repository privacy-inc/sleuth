import Foundation
import Archivable

extension Page {
    enum Access: Equatable, Property {
        case
        remote(String),
        local(String, Data)
        
        var string: String {
            switch self {
            case let .remote(string), let .local(string, _):
                return string
            }
        }
        
        var url: URL? {
            switch self {
            case let .remote(url):
                return .init(string: url)
            case let .local(_, bookmark):
                return bookmark.url
            }
        }
        
        var data: Data {
            Data()
                .adding(key.rawValue)
                .adding(value)
        }
        
        init(data: inout Data) {
            switch Key(rawValue: data.removeFirst())! {
            case .remote:
                self = .remote(data.string())
            case .local:
                self = .local(data.string(), data.unwrap())
            }
        }
        
        init(url: URL) {
            self = url.isFileURL
                ? .local(url.schemeless, url.deletingLastPathComponent().bookmark)
                : .remote(url.absoluteString)
        }
        
        private var value: Data {
            switch self {
            case let .remote(url):
                return Data()
                        .adding(url)
            case let .local(url, bookmark):
                return Data()
                        .adding(url)
                        .wrapping(bookmark)
            }
        }
    }
}
