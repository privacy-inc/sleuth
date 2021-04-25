import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public internal(set) var date: Date
    
    public var data: Data {
        Data()
    }
    
    public init(data: inout Data) {
        date = .init(timeIntervalSince1970: 0)
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
    }
}
