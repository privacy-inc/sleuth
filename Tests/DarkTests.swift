import XCTest
import Sleuth

final class DarkTests: XCTestCase {
    private var dictonary: [[String : [String : String]]]!
    
    override func setUp() {
        dictonary = (try! JSONSerialization.jsonObject(with: .init(Block.dark.utf8))) as? [[String : [String : String]]]
    }
    
    func testGoogle() {
        XCTAssertTrue(contains("css-display-none", ".P1Ycoe", ".*google.com"))
    }

    private func contains(_ type: String, _ selector: String?, _ filter: String) -> Bool {
        dictonary.contains { $0["action"]!["type"] == type
            && $0["trigger"]!["url-filter"] == filter
            && $0["action"]!["selector"] == selector }
    }
}
