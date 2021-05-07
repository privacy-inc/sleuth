import XCTest
@testable import Sleuth

final class BlockerTests: XCTestCase {
    func testAllCases() {
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases)))
                        .cookies)
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases)))
                        .http)
        XCTAssertEqual(1, Parser(content: Blocker.rules(.init(Blocker.allCases)))
                        .amount(url: "google.com"))
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases)))
                        .css(url: "google.com", selectors: ["#taw",
                                                            "#consent-bump"]))
    }
    
    func testCookies() {
        XCTAssertTrue(Parser(content: Blocker.rules([.cookies])).cookies)
    }
    
    func testHttp() {
        XCTAssertTrue(Parser(content: Blocker.rules([.http])).http)
    }
    
    func testAds() {
        XCTAssertTrue(Parser(content: Blocker.rules([.ads]))
                        .css(url: "ecosia.org", selectors: [".card-ad",
                                                            ".card-productads"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.ads]))
                        .css(url: "google.com", selectors: ["#taw",
                                                            "#rhs",
                                                            "#tadsb",
                                                            ".commercial",
                                                            ".Rn1jbe",
                                                            ".kxhcC",
                                                            ".isv-r.PNCib.BC7Tfc",
                                                            ".isv-r.PNCib.o05QGe"]))
    }
    
    func testPopups() {
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "google.com", selectors: ["#consent-bump",
                                                            "#lb",
                                                            ".hww53CMqxtL__mobile-promo",
                                                            "#Sx9Kwc"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "youtube.com", selectors: ["#consent-bump",
                                                             ".opened",
                                                             ".ytd-popup-container",
                                                             ".upsell-dialog-lightbox",
                                                             ".consent-bump-lightbox"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "instagram.com", selectors: [".RnEpo.Yx5HN",
                                                               ".RnEpo._Yhr4",
                                                               ".R361B",
                                                               ".NXc7H.jLuN9.X6gVd",
                                                               ".f11OC"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "reuters.com", selectors: ["#onetrust-consent-sdk",
                                                             "#newReutersModal"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "twitter.com", selectors: [
                                ".css-1dbjc4n.r-aqfbo4.r-1p0dtai.r-1d2f490.r-12vffkv.r-1xcajam.r-zchlnj"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "thelocal.de", selectors: ["#qc-cmp2-container",
                                                             ".tp-modal",
                                                             ".tp-backdrop"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "pinterest.com", selectors: [
                                ".Jea.LCN.Lej.PKX._he.dxm.fev.fte.gjz.jzS.ojN.p6V.qJc.zI7.iyn.Hsu",
                                ".QLY.Rym.ZZS._he.ojN.p6V.zI7.iyn.Hsu"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "bbc.com", selectors: [".fc-consent-root",
                                                         "#cookiePrompt",
                                                         ".ssrcss-u3tmht-ConsentBanner.exhqgzu6"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.popups]))
                        .css(url: "reddit.com", selectors: ["._3q-XSJ2vokDQrvdG6mR__k",
                                                            ".EUCookieNotice",
                                                            ".XPromoPopup"]))
    }
}
