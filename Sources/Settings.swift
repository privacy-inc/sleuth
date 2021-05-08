import Foundation
import Archivable

public struct Settings: Property {
    public internal(set) var engine: Engine
    public internal(set) var javascript: Bool
    public internal(set) var dark: Bool
    public internal(set) var popups: Bool
    public internal(set) var ads: Bool
    public internal(set) var screen: Bool
    public internal(set) var trackers: Bool
    public internal(set) var cookies: Bool
    public internal(set) var http: Bool
    public internal(set) var location: Bool
    
    public var data: Data {
        Data()
            .adding(engine.data)
    }
    
    public init(data: inout Data) {
        engine = .init(data: &data)
        javascript = true
        dark = true
        popups = false
        ads = false
        screen = false
        trackers = false
        cookies = false
        http = false
        location = false
    }
    
    init() {
        engine = .google
        javascript = true
        dark = true
        popups = false
        ads = false
        screen = false
        trackers = false
        cookies = false
        http = false
        location = false
    }
}
