import XCTest
@testable import Sleuth

final class SettingsTests: XCTestCase {
    private var settings: Settings!
    
    override func setUp() {
        settings = .init()
    }
    
    func testInitial() {
        XCTAssertTrue(Router.secure === settings.router)
        XCTAssertEqual(.init(Blocker.allCases), settings.blocking)
    }
    
    func testEngine() {
        settings.engine = .ecosia
        XCTAssertEqual(.ecosia, settings.data.prototype(Settings.self).engine)
    }
    
    func testJavascript() {
        settings.javascript = false
        XCTAssertFalse(settings.data.prototype(Settings.self).javascript)
    }
    
    func testDark() {
        XCTAssertTrue(settings.data.prototype(Settings.self).blocking.contains(.antidark))
        settings.dark = false
        XCTAssertFalse(settings.blocking.contains(.antidark))
        XCTAssertFalse(settings.data.prototype(Settings.self).dark)
        XCTAssertFalse(settings.data.prototype(Settings.self).blocking.contains(.antidark))
    }
    
    func testPopups() {
        settings.popups = true
        XCTAssertTrue(settings.data.prototype(Settings.self).popups)
    }
    
    func testAds() {
        XCTAssertTrue(settings.data.prototype(Settings.self).blocking.contains(.ads))
        settings.ads = true
        XCTAssertFalse(settings.blocking.contains(.ads))
        XCTAssertFalse(settings.data.prototype(Settings.self).blocking.contains(.ads))
        XCTAssertTrue(settings.data.prototype(Settings.self).ads)
    }
    
    func testScreen() {
        XCTAssertTrue(settings.data.prototype(Settings.self).blocking.contains(.screen))
        settings.screen = true
        XCTAssertFalse(settings.blocking.contains(.screen))
        XCTAssertFalse(settings.data.prototype(Settings.self).blocking.contains(.screen))
        XCTAssertTrue(settings.data.prototype(Settings.self).screen)
    }
    
    func testTrackers() {
        XCTAssertTrue(Router.secure === settings.data.prototype(Settings.self).router)
        settings.trackers = true
        XCTAssertTrue(Router.regular === settings.router)
        XCTAssertTrue(settings.data.prototype(Settings.self).trackers)
        XCTAssertTrue(Router.regular === settings.data.prototype(Settings.self).router)
        
    }
    
    func testCookies() {
        XCTAssertTrue(settings.data.prototype(Settings.self).blocking.contains(.cookies))
        settings.cookies = true
        XCTAssertFalse(settings.blocking.contains(.cookies))
        XCTAssertFalse(settings.data.prototype(Settings.self).blocking.contains(.cookies))
        XCTAssertTrue(settings.data.prototype(Settings.self).cookies)
    }
    
    func testHttp() {
        XCTAssertTrue(settings.data.prototype(Settings.self).blocking.contains(.http))
        settings.http = true
        XCTAssertFalse(settings.blocking.contains(.http))
        XCTAssertFalse(settings.data.prototype(Settings.self).blocking.contains(.http))
        XCTAssertTrue(settings.data.prototype(Settings.self).http)
    }
    
    func testLocation() {
        settings.location = true
        XCTAssertTrue(settings.data.prototype(Settings.self).location)
    }
    
    func testRules() {
        settings.dark = false
        settings.ads = true
        settings.cookies = true
        settings.http = true
        settings.screen = true
        XCTAssertTrue(settings.blocking.isEmpty)
        
        settings.ads = false
        XCTAssertEqual([.ads], settings.blocking)
        
        settings.ads = true
        settings.cookies = false
        XCTAssertEqual([.cookies], settings.blocking)
        
        settings.cookies = true
        settings.http = false
        XCTAssertEqual([.http], settings.blocking)
        
        settings.http = true
        settings.screen = false
        XCTAssertEqual([.screen], settings.blocking)
    }
    
    func testScriptBegin() {
        XCTAssertEqual(Script.dark, settings.begin)
        settings.dark = false
        XCTAssertTrue(settings.begin.isEmpty)
    }
    
    func testScriptEnd() {
        XCTAssertEqual(Script.scroll, settings.end)
        settings.location = true
        XCTAssertEqual(Script.scroll + Script.location, settings.end)
        settings.location = false
        settings.screen = true
        XCTAssertTrue(settings.end.isEmpty)
    }
}
