import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public var date: Date
    public internal(set) var entries: [Entry]
    public internal(set) var activity: [Date]
    public internal(set) var blocked: [String: Date]
    var counter = 0
    
    public var data: Data {
        Data()
            .adding(UInt16(counter))
            .adding(date)
            .adding(UInt16(entries.count))
            .adding(entries.flatMap(\.data))
            .adding(UInt32(activity.count))
            .adding(activity.flatMap(\.data))
    }
    
    public init(data: inout Data) {
        counter = .init(data.uInt16())
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
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.date.timestamp == rhs.date.timestamp &&
            lhs.entries == rhs.entries &&
            lhs.activity == rhs.activity &&
            lhs.blocked == rhs.blocked
    }
}
