import Foundation
import Archivable

extension Cloud where A == Archive {
    public func engine(_ engine: Engine) {
        mutating {
            $0.settings.engine = engine
        }
    }
    
    public func javascript(_ enabled: Bool) {
        mutating {
            $0.settings.javascript = enabled
        }
    }
    
    public func dark(_ force: Bool) {
        mutating {
            $0.settings.dark = force
        }
    }
    
    public func popups(_ allowed: Bool) {
        mutating {
            $0.settings.popups = allowed
        }
    }
    
    public func ads(_ allowed: Bool) {
        mutating {
            $0.settings.ads = allowed
        }
    }
    
    public func screen(_ allowed: Bool) {
        mutating {
            $0.settings.screen = allowed
        }
    }
    
    public func trackers(_ allowed: Bool) {
        mutating {
            $0.settings.trackers = allowed
        }
    }
    
    public func cookies(_ allowed: Bool) {
        mutating {
            $0.settings.cookies = allowed
        }
    }
    
    public func http(_ allowed: Bool) {
        mutating {
            $0.settings.http = allowed
        }
    }
    
    public func location(_ allowed: Bool) {
        mutating {
            $0.settings.location = allowed
        }
    }
}
