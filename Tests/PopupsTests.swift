import XCTest
import Sleuth

final class PopupsTests: XCTestCase {
    private var rules: Blocker.Parser!
    
    override func setUp() {
        rules = .init(content: Block.blockers)
    }
    
    func testGoogle() {
        XCTAssertTrue(rules.displayNone(domain: "*google.com", selector: "#consent-bump"))
        XCTAssertTrue(rules.displayNone(domain: "*google.com", selector: "#lb"))
        XCTAssertTrue(rules.displayNone(domain: "*google.com", selector: ".hww53CMqxtL__mobile-promo"))
        XCTAssertTrue(rules.displayNone(domain: "*google.com", selector: "#Sx9Kwc"))
    }
    
    func testYouTube() {
        XCTAssertTrue(rules.displayNone(domain: "*youtube.com", selector: "#consent-bump"))
        XCTAssertTrue(rules.displayNone(domain: "*youtube.com", selector: ".opened"))
        XCTAssertTrue(rules.displayNone(domain: "*youtube.com", selector: ".ytd-popup-container"))
        XCTAssertTrue(rules.displayNone(domain: "*youtube.com", selector: ".upsell-dialog-lightbox"))
        XCTAssertTrue(rules.displayNone(domain: "*youtube.com", selector: ".consent-bump-lightbox"))
    }
    
    func testInstagram() {
        XCTAssertTrue(rules.displayNone(domain: "*instagram.com", selector: ".RnEpo.Yx5HN"))
        XCTAssertTrue(rules.displayNone(domain: "*instagram.com", selector: ".RnEpo._Yhr4"))
        XCTAssertTrue(rules.displayNone(domain: "*instagram.com", selector: ".R361B"))
        XCTAssertTrue(rules.displayNone(domain: "*instagram.com", selector: ".NXc7H.jLuN9.X6gVd"))
        XCTAssertTrue(rules.displayNone(domain: "*instagram.com", selector: ".f11OC"))
    }
    
    func testReuters() {
        XCTAssertTrue(rules.displayNone(domain: "*reuters.com", selector: "#onetrust-consent-sdk"))
        XCTAssertTrue(rules.displayNone(domain: "*reuters.com", selector: "#newReutersModal"))
    }
    
    func testTwitter() {
        XCTAssertTrue(rules.displayNone(domain: "*twitter.com", selector: ".css-1dbjc4n.r-aqfbo4.r-1p0dtai.r-1d2f490.r-12vffkv.r-1xcajam.r-zchlnj"))
    }
    
    func testTheLocal() {
        XCTAssertTrue(rules.displayNone(domain: "*thelocal.de", selector: "#qc-cmp2-container"))
        XCTAssertTrue(rules.displayNone(domain: "*thelocal.de", selector: ".tp-modal"))
        XCTAssertTrue(rules.displayNone(domain: "*thelocal.de", selector: ".tp-backdrop"))
    }
    
    func testPinterest() {
        XCTAssertTrue(rules.displayNone(domain: "*pinterest.com", selector: ".Jea.LCN.Lej.PKX._he.dxm.fev.fte.gjz.jzS.ojN.p6V.qJc.zI7.iyn.Hsu"))
        XCTAssertTrue(rules.displayNone(domain: "*pinterest.com", selector: ".QLY.Rym.ZZS._he.ojN.p6V.zI7.iyn.Hsu"))
    }
    
    func testBbc() {
        XCTAssertTrue(rules.displayNone(domain: "*bbc.com", selector: ".fc-consent-root"))
        XCTAssertTrue(rules.displayNone(domain: "*bbc.com", selector: "#cookiePrompt"))
        XCTAssertTrue(rules.displayNone(domain: "*bbc.com", selector: ".ssrcss-u3tmht-ConsentBanner.exhqgzu6"))
    }
    
    func testReddit() {
        XCTAssertTrue(rules.displayNone(domain: "*reddit.com", selector: "._3q-XSJ2vokDQrvdG6mR__k"))
        XCTAssertTrue(rules.displayNone(domain: "*reddit.com", selector: ".EUCookieNotice"))
        XCTAssertTrue(rules.displayNone(domain: "*reddit.com", selector: ".XPromoPopup"))
    }
}