import XCTest
import Sleuth

final class BlockerTests: XCTestCase {
    func testCookies() {
        XCTAssertTrue(Parser(blocker: .cookies).cookies)
    }
    
    func testHttp() {
        XCTAssertTrue(Parser(blocker: .http).http)
    }
}
