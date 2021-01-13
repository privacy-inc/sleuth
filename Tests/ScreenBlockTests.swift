import XCTest
import Sleuth

final class ScreenBlockTests: XCTestCase {
    private var dictonary: [[String : [String : String]]]!
    
    override func setUp() {
        dictonary = (try! JSONSerialization.jsonObject(with: .init(Block.blockers.utf8))) as? [[String : [String : String]]]
    }
    
    func testGoogle() {
        XCTAssertTrue(contains("css-display-none", "#consent-bump", ".*google.com"))
    }
    
    func testYouTube() {
        XCTAssertTrue(contains("css-display-none", "#consent-bump", ".*youtube.com"))
        XCTAssertTrue(contains("css-display-none", ".opened", ".*youtube.com"))
        XCTAssertTrue(contains("css-display-none", ".ytd-popup-container", ".*youtube.com"))
        XCTAssertTrue(contains("css-display-none", ".upsell-dialog-lightbox", ".*youtube.com"))
        XCTAssertTrue(contains("css-display-none", ".consent-bump-lightbox", ".*youtube.com"))
    }

    private func contains(_ type: String, _ selector: String?, _ filter: String) -> Bool {
        dictonary.contains { $0["action"]!["type"] == type
            && $0["trigger"]!["url-filter"] == filter
            && $0["action"]!["selector"] == selector }
    }
}
