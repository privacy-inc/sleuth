import XCTest
@testable import Sleuth

final class SettingsTests: XCTestCase {
    private var settings: Settings!
    
    override func setUp() {
        settings = .init()
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
        settings.dark = false
        XCTAssertFalse(settings.data.prototype(Settings.self).dark)
    }
    
    func testPopups() {
        settings.popups = true
        XCTAssertTrue(settings.data.prototype(Settings.self).popups)
    }
    
    func testAds() {
        settings.ads = true
        XCTAssertTrue(settings.data.prototype(Settings.self).ads)
    }
    
    func testScreen() {
        settings.screen = true
        XCTAssertTrue(settings.data.prototype(Settings.self).screen)
    }
    
    func testTrackers() {
        settings.trackers = true
        XCTAssertTrue(settings.data.prototype(Settings.self).trackers)
    }
    
    func testCookies() {
        settings.cookies = true
        XCTAssertTrue(settings.data.prototype(Settings.self).cookies)
    }
    
    func testHttp() {
        settings.http = true
        XCTAssertTrue(settings.data.prototype(Settings.self).http)
    }
    
    func testLocation() {
        settings.location = true
        XCTAssertTrue(settings.data.prototype(Settings.self).location)
    }
    
    func testRules() {
        settings.ads = true
        settings.cookies = true
        settings.http = true
        settings.screen = true
        XCTAssertEqual(Blocker.rules([]).count, settings.rules.count)
        
        settings.ads = false
        XCTAssertEqual(Blocker.rules([.ads]).count, settings.rules.count)
        
        settings.ads = true
        settings.cookies = false
        XCTAssertEqual(Blocker.rules([.cookies]).count, settings.rules.count)
        
        settings.cookies = true
        settings.http = false
        XCTAssertEqual(Blocker.rules([.http]).count, settings.rules.count)
        
        settings.http = true
        settings.screen = false
        XCTAssertEqual(Blocker.rules([.screen]).count, settings.rules.count)
    }
}
