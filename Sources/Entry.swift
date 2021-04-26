import Foundation
import Archivable

public enum Entry: Equatable, Property {
    case
    remote(Int, Info),
    local(Int, Info, Bookmark)
    
    public var url: String {
        info.url
    }
    
    public var title: String {
        info.title
    }
    
    public var date: Date {
        info.date
    }
    
    private var info: Info {
        switch self {
        case let .local(_, info, _), let .remote(_, info):
            return info
        }
    }
    
    public var data: Data {
        .init()
    }
    
    public init(data: inout Data) {
        fatalError()
    }
    
    init(url: String) {
        fatalError()
    }
    
    func with(title: String) -> Self {
        self
    }
}
