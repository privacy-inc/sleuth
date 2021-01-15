import XCTest
import Sleuth

final class DarkTests: XCTestCase {
    private var rules: Rules!
    
    override func setUp() {
        rules = .init(content: Block.dark)
    }
    
    func testGoogle() {
        XCTAssertTrue(rules.remove(domain: "google.com", selector: ".P1Ycoe"))
    }
}
