import Foundation
import Archivable

public struct Page: Equatable, Property {
    static let blank = Page(access: .remote("about:blank"))
    
    public let title: String
    let access: Access
    
    public var string: String {
        access.string
    }
    
    public var domain: String {
        access.string.domain
    }
    
    public var url: URL? {
        access.url
    }
    
    public var data: Data {
        Data()
            .adding(title)
            .adding(access.data)
    }
    
    public init(data: inout Data) {
        title = data.string()
        access = .init(data: &data)
    }
    
    init(title: String = "", access: Access) {
        self.title = title
        self.access = access
    }
    
    func with(title: String) -> Self {
        .init(title: title, access: access)
    }
    
    func with(access: Access) -> Self {
        .init(title: title, access: access)
    }
}