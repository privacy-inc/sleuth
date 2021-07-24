import XCTest
@testable import Sleuth

final class ScriptTests: XCTestCase {
    private var settings: Settings!
    
    override func setUp() {
        settings = .init()
    }
    
    func testBegin() {
        XCTAssertEqual(Script.dark + Script.favicon, settings.start)
        settings.dark = false
        XCTAssertEqual(Script.favicon, settings.start)
    }
    
    func testEnd() {
        XCTAssertEqual(Script.scroll, settings.end)
        settings.location = true
        XCTAssertEqual(Script.scroll + Script.location, settings.end)
        settings.timers = false
        XCTAssertEqual(Script.scroll + Script.location + Script.timers, settings.end)
        settings.location = false
        XCTAssertEqual(Script.scroll + Script.timers, settings.end)
        settings.location = false
        settings.timers = true
        settings.screen = true
        XCTAssertTrue(settings.end.isEmpty)
    }
}
