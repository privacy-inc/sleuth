import Foundation
import Archivable
import Sleuth

extension Settings {
    struct V1: Property {
        let engine: Engine
        let javascript: Bool
        let popups: Bool
        let location: Bool
        let dark: Bool
        let ads: Bool
        let screen: Bool
        let cookies: Bool
        let http: Bool
        let trackers: Bool
        
        var data: Data {
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
        
        init(data: inout Data) {
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
        
        init(engine: Engine = .ecosia) {
            self.engine = engine
            javascript = false
            dark = false
            popups = true
            ads = true
            screen = true
            trackers = true
            cookies = true
            http = true
            location = true
        }
    }
}
