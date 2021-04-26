import Foundation
import Archivable

public enum Entry: Equatable, Property {
    case
    remote(Int, Info),
    local(Int, Info, Bookmark)
    
    public var id: Int {
        switch self {
        case let .local(id, _, _), let .remote(id, _):
            return id
        }
    }
    
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
        Data()
            .adding(UInt16(id))
    }
    
    public init(data: inout Data) {
        self = .remote(.init(data.uInt16()), .init(url: "", title: ""))
    }
    
    init(id: Int, url: String) {
        self = .remote(id, .init(url: "", title: ""))
    }
    
    func with(title: String) -> Self {
        self
    }
}
