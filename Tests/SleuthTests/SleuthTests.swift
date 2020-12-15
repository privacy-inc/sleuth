import XCTest
@testable import Sleuth

final class SleuthTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Sleuth().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
