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
            .adding(javascript)
            .adding(dark)
            .adding(popups)
            .adding(ads)
            .adding(screen)
            .adding(trackers)
            .adding(cookies)
            .adding(http)
            .adding(location)
    }
    
    public init(data: inout Data) {
        engine = .init(data: &data)
        javascript = data.bool()
        dark = data.bool()
        popups = data.bool()
        ads = data.bool()
        screen = data.bool()
        trackers = data.bool()
        cookies = data.bool()
        http = data.bool()
        location = data.bool()
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
    
    public var rules: String {
        var rules = Set<Blocker>()
        
        if !ads {
            rules.insert(.ads)
        }
        
        if !cookies {
            rules.insert(.cookies)
        }
        
        if !http {
            rules.insert(.http)
        }
        
        if !screen {
            rules.insert(.screen)
        }
        
        return Blocker.rules(rules)
    }
}
