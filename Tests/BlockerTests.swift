import XCTest
import Sleuth

final class BlockerTests: XCTestCase {
    func testAllCases() {
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases))).cookies)
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases))).http)
    }
    
    func testCookies() {
        XCTAssertTrue(Parser(content: Blocker.rules([.cookies])).cookies)
    }
    
    func testHttp() {
        XCTAssertTrue(Parser(content: Blocker.rules([.http])).http)
    }
}
