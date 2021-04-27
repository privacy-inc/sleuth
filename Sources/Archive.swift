import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public internal(set) var date: Date
    public internal(set) var entries: [Entry]
    public internal(set) var activity: [Date]
    public internal(set) var blocked: [String: Date]
    
    public var data: Data {
        Data()
            .adding(date)
            .adding(UInt16(entries.count))
            .adding(entries.flatMap(\.data))
            .adding(UInt32(activity.count))
            .adding(activity.flatMap(\.data))
    }
    
    public init(data: inout Data) {
        date = .init(timestamp: data.uInt32())
        entries = (0 ..< .init(data.uInt16())).map { _ in
            .init(data: &data)
        }
        activity = (0 ..< .init(data.uInt32())).map { _ in
            .init(timestamp: data.uInt32())
        }
        blocked = [:]
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
        entries = .init()
        activity = []
        blocked = [:]
    }
}
