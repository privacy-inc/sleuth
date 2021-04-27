import Foundation
import Archivable

extension Entry {
    enum Bookmark: Equatable, Property {
        case
        remote(String),
        local(String, Data)
        
        var url: String {
            switch self {
            case let .remote(url), let .local(url, _):
                return url
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
        
        init(url: String) {
            self = .remote(url)
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
