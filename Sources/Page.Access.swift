import Foundation
import Archivable

extension Page {
    public enum Access: Equatable, Property {
        case
        remote(String),
        local(String, Data)
        
        public var string: String {
            switch self {
            case let .remote(string), let .local(string, _):
                return string
            }
        }
        
        public var domain: String {
            string.domain
        }
        
        public var url: URL? {
            switch self {
            case let .remote(url), let .local(url, _):
                return .init(string: url)
            }
        }
        
        public var directory: URL? {
            switch self {
            case let .local(_, bookmark):
                return bookmark.url
            default:
                return nil
            }
        }
        
        public var data: Data {
            Data()
                .adding(key.rawValue)
                .adding(value)
        }
        
        public init(data: inout Data) {
            switch Key(rawValue: data.removeFirst())! {
            case .remote:
                self = .remote(data.string())
            case .local:
                self = .local(data.string(), data.unwrap())
            }
        }
        
        init(url: URL) {
            self = url.isFileURL
                ? .local(url.absoluteString, url.deletingLastPathComponent().bookmark)
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
