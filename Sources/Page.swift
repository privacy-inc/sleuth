import Foundation
import Archivable

public struct Page: Hashable, Identifiable, Property {
    public var url: String
    public var title: String
    public let date: Date
    public let id: UUID
    
    public var data: Data {
        Data()
            .adding(id.uuidString)
            .adding(date.timestamp)
            .adding(url)
            .adding(title)
    }
    
    public init(data: inout Data) {
        id = UUID(uuidString: data.string())!
        date = .init(timestamp: data.uInt32())
        url = data.string()
        title = data.string()
    }
    
    public init(url: String) {
        self.url = url
        title = ""
        date = .init()
        id = .init()
    }
}
