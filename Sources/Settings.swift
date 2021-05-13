import Foundation
import Archivable

public struct Settings: Equatable, Property {
    public internal(set) var engine: Engine
    public internal(set) var javascript: Bool
    public internal(set) var popups: Bool
    public internal(set) var location: Bool
    private(set) var router: Router
    private(set) var blocking: Set<Blocker>
    
    public internal(set) var dark: Bool {
        didSet {
            if dark {
                blocking.insert(.antidark)
            } else {
                blocking.remove(.antidark)
            }
        }
    }
    
    public internal(set) var ads: Bool {
        didSet {
            if ads {
                blocking.remove(.ads)
            } else {
                blocking.insert(.ads)
            }
        }
    }
    
    public internal(set) var screen: Bool {
        didSet {
            if screen {
                blocking.remove(.screen)
            } else {
                blocking.insert(.screen)
            }
        }
    }
    
    public internal(set) var cookies: Bool {
        didSet {
            if cookies {
                blocking.remove(.cookies)
            } else {
                blocking.insert(.cookies)
            }
        }
    }
    
    public internal(set) var http: Bool {
        didSet {
            if http {
                blocking.remove(.http)
            } else {
                blocking.insert(.http)
            }
        }
    }
    
    public internal(set) var trackers: Bool {
        didSet {
            router = trackers.router
        }
    }
    
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
        router = trackers.router
        blocking = []
        
        if dark {
            blocking.insert(.antidark)
        }
        
        if !ads {
            blocking.insert(.ads)
        }
        
        if !screen {
            blocking.insert(.screen)
        }
        
        if !cookies {
            blocking.insert(.cookies)
        }
        
        if !http {
            blocking.insert(.http)
        }
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
        router = .secure
        blocking = .init(Blocker.allCases)
    }
    
    public var rules: String {
        blocking.rules
    }
    
    public var start: String {
        dark ? Script.dark : ""
    }
    
    public var end: String {
        (screen ? "" : Script.scroll)
        + (location ? Script.location : "")
    }
    
    public static func == (lhs: Settings, rhs: Settings) -> Bool {
        lhs.engine == rhs.engine
            && lhs.javascript == rhs.javascript
            && lhs.dark == rhs.dark
            && lhs.popups == rhs.popups
            && lhs.ads == rhs.ads
            && lhs.screen == rhs.screen
            && lhs.trackers == rhs.trackers
            && lhs.cookies == rhs.cookies
            && lhs.http == rhs.http
            && lhs.location == rhs.location
    }
}

private extension Bool {
    var router: Router {
        self ? .regular : .secure
    }
}
