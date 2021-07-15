import XCTest
@testable import Sleuth

final class BlockerTests: XCTestCase {
    func testAllCases() {
        XCTAssertTrue(Parser(content: Set(Blocker.allCases).rules)
                        .cookies)
        XCTAssertTrue(Parser(content: Set(Blocker.allCases).rules)
                        .http)
        XCTAssertEqual(1, Parser(content: Set(Blocker.allCases).rules)
                        .amount(url: "google.com"))
        XCTAssertTrue(Parser(content: Set(Blocker.allCases).rules)
                        .css(url: "google.com", selectors: ["#taw",
                                                            "#consent-bump",
                                                            ".P1Ycoe"]))
    }
    
    func testCookies() {
        XCTAssertTrue(Parser(content: Set([.cookies]).rules).cookies)
    }
    
    func testHttp() {
        XCTAssertTrue(Parser(content: Set([.http]).rules).http)
    }
    
    func testThird() {
        print(Set([Blocker.third]).rules)
        XCTAssertTrue(Parser(content: Set([Blocker.third]).rules).third)
    }
    
    func testAds() {
        XCTAssertTrue(Parser(content: Set([.ads]).rules)
                        .css(url: "ecosia.org", selectors: [".card-ad",
                                                            ".card-productads",
                                                            ".js-whitelist-notice",
                                                            ".callout-whitelist"]))
        
        XCTAssertTrue(Parser(content: Set([.ads]).rules)
                        .css(url: "google.com", selectors: ["#taw",
                                                            "#rhs",
                                                            "#tadsb",
                                                            ".commercial",
                                                            ".Rn1jbe",
                                                            ".kxhcC",
                                                            ".isv-r.PNCib.BC7Tfc",
                                                            ".isv-r.PNCib.o05QGe"]))
        
        XCTAssertTrue(Parser(content: Set([.ads]).rules)
                        .css(url: "youtube.com", selectors: [".ytd-search-pyv-renderer",
                                                             ".video-ads.ytp-ad-module"]))
    }
    
    func testScreen() {
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "google.com", selectors: ["#consent-bump",
                                                            "#lb",
                                                            ".hww53CMqxtL__mobile-promo",
                                                            "#Sx9Kwc",
                                                            "#xe7COe",
                                                            ".NIoIEf",
                                                            ".QzsnAe.crIj3e",
                                                            ".ml-promotion-container"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "youtube.com", selectors: ["#consent-bump",
                                                             ".opened",
                                                             ".ytd-popup-container",
                                                             ".upsell-dialog-lightbox",
                                                             ".consent-bump-lightbox",
                                                             "#lightbox",
                                                             ".ytd-consent-bump-v2-renderer"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "instagram.com", selectors: [".RnEpo.Yx5HN",
                                                               ".RnEpo._Yhr4",
                                                               ".R361B",
                                                               ".NXc7H.jLuN9.X6gVd",
                                                               ".f11OC"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "twitter.com", selectors: [
                                ".css-1dbjc4n.r-aqfbo4.r-1p0dtai.r-1d2f490.r-12vffkv.r-1xcajam.r-zchlnj"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "reuters.com", selectors: ["#onetrust-consent-sdk",
                                                             "#newReutersModal"]))
        
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "thelocal.de", selectors: ["#qc-cmp2-container",
                                                             ".tp-modal",
                                                             ".tp-backdrop"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "pinterest.com", selectors: [
                                ".Jea.LCN.Lej.PKX._he.dxm.fev.fte.gjz.jzS.ojN.p6V.qJc.zI7.iyn.Hsu",
                                ".QLY.Rym.ZZS._he.ojN.p6V.zI7.iyn.Hsu"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "bbc.com", selectors: [".fc-consent-root",
                                                         "#cookiePrompt",
                                                         ".ssrcss-u3tmht-ConsentBanner.exhqgzu6"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "reddit.com", selectors: ["._3q-XSJ2vokDQrvdG6mR__k",
                                                            ".EUCookieNotice",
                                                            ".XPromoPopup"]))
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "medium.com", selectors: [".lz.u.mb.ti.aj.tj.tk.tl.tm.tn.to.tp.tq.tr.ts.tt.tu.tv.tw.tx.ty.tz.ua.do.ub.uc.ud.ue.uf.ug.uh.ui.uj.uk.ul.um"]))
        
        XCTAssertTrue(Parser(content: Set([.screen]).rules)
                        .css(url: "bloomberg.com", selectors: ["#fortress-paywall-container-root",
                                                               ".leaderboard-wrapper",
                                                               ".overlay-container"]))
    }
    
    func testAntidark() {
        XCTAssertTrue(Parser(content: Set([.antidark]).rules)
                        .css(url: "google.com", selectors: [".P1Ycoe"]))
    }
}
