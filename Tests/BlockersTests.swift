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
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: ".hww53CMqxtL__mobile-promo"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: "#Sx9Kwc"))
    }
    
    func testYouTube() {
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: "#consent-bump"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".opened"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".ytd-popup-container"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".upsell-dialog-lightbox"))
        XCTAssertTrue(rules.remove(domain: "*youtube.com", selector: ".consent-bump-lightbox"))
    }
    
    func testInstagram() {
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".RnEpo.Yx5HN"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".RnEpo._Yhr4"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".R361B"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".NXc7H.jLuN9.X6gVd"))
        XCTAssertTrue(rules.remove(domain: "*instagram.com", selector: ".f11OC"))
    }
    
    func testReuters() {
        XCTAssertTrue(rules.remove(domain: "*reuters.com", selector: "#onetrust-consent-sdk"))
        XCTAssertTrue(rules.remove(domain: "*reuters.com", selector: "#newReutersModal"))
    }
    
    func testTwitter() {
        XCTAssertTrue(rules.remove(domain: "*twitter.com", selector: ".css-1dbjc4n.r-aqfbo4.r-1p0dtai.r-1d2f490.r-12vffkv.r-1xcajam.r-zchlnj"))
    }
    
    func testTheLocal() {
        XCTAssertTrue(rules.remove(domain: "*thelocal.de", selector: "#qc-cmp2-container"))
        XCTAssertTrue(rules.remove(domain: "*thelocal.de", selector: ".tp-modal"))
        XCTAssertTrue(rules.remove(domain: "*thelocal.de", selector: ".tp-backdrop"))
    }
    
    func testPinterest() {
        XCTAssertTrue(rules.remove(domain: "*pinterest.com", selector: ".Jea.LCN.Lej.PKX._he.dxm.fev.fte.gjz.jzS.ojN.p6V.qJc.zI7.iyn.Hsu"))
        XCTAssertTrue(rules.remove(domain: "*pinterest.com", selector: ".QLY.Rym.ZZS._he.ojN.p6V.zI7.iyn.Hsu"))
    }
}
