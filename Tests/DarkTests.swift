import XCTest
import Sleuth

final class DarkTests: XCTestCase {
    private var rules: Blocker.Parser!
    
    override func setUp() {
        rules = .init(content: Block.dark)
    }
    
    func testGoogle() {
        XCTAssertTrue(rules.displayNone(domain: "*google.com", selector: ".P1Ycoe"))
    }
}
