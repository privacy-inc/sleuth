import XCTest
import Sleuth

final class BlockersTests: XCTestCase {
    private var rules: Rules!
    
    override func setUp() {
        rules = .init(content: Block.blockers)
    }
    
    func testGoogle() {
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: "#consent-bump"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: "#lb"))
    }
    
    func testYouTube() {
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: "#consent-bump"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".opened"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".ytd-popup-container"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".upsell-dialog-lightbox"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".consent-bump-lightbox"))
    }
    
    func testInstagram() {
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".RnEpo"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".Yx5HN"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: "._Yhr4"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".R361B"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".NXc7H"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".f11OC"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".X6gVd"))
    }
    
    func testTwitter() {
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".css-1dbjc4n"))
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".r-aqfbo4"))
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".r-1p0dtai"))
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".r-1d2f490"))
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".r-12vffkv"))
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".r-1xcajam"))
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".r-zchlnj"))
    }
}
