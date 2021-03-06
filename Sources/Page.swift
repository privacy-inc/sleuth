import Foundation
import Archivable

public struct Page: Hashable, Property {
    static let blank = Page(access: .remote(.init(value: "about:blank")))
    public let title: String
    public let access: Access
    
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
    
    func matches(_ strings: [String]) -> Int {
        strings
            .filter {
                title.localizedCaseInsensitiveContains($0)
                    || access.value.localizedCaseInsensitiveContains($0)
            }
            .count
    }
}
