import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public internal(set) var date: Date
    
    public var data: Data {
        Data()
            .adding(date.timestamp)
    }
    
    public init(data: inout Data) {
        date = .init(timestamp: data.uInt32())
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
    }
}
