import XCTest
import Sleuth

final class AdsTests: XCTestCase {
    private var rules: Rules!
    
    override func setUp() {
        rules = .init(content: Block.ads)
    }
    
    func testEcosia() {
        XCTAssertTrue(rules.remove(domain: "*ecosia.org", selector: ".card-ad"))
        XCTAssertTrue(rules.remove(domain: "*ecosia.org", selector: ".card-productads"))
    }
    
    func testGoogle() {
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: "#taw"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: "#rhs"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: "#tadsb"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: ".commercial"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: ".Rn1jbe"))
        XCTAssertTrue(rules.remove(domain: "*google.com", selector: ".kxhcC"))
    }
    
    func testDomains() {
        XCTAssertTrue(rules.block(domain: "pubmatic.com"))
        XCTAssertTrue(rules.block(domain: "googlesyndication.com"))
        XCTAssertTrue(rules.block(domain: "dianomi.com"))
        XCTAssertTrue(rules.block(domain: "hotjar.com"))
        XCTAssertTrue(rules.block(domain: "media.net"))
        XCTAssertTrue(rules.block(domain: "googleapis.com"))
        XCTAssertTrue(rules.block(domain: "*platform.twitter.com"))
        XCTAssertTrue(rules.block(domain: "adalliance.io"))
        XCTAssertTrue(rules.block(domain: "yieldlab.net"))
        XCTAssertTrue(rules.block(domain: "emsservice.de"))
        XCTAssertTrue(rules.block(domain: "flashtalking.com"))
        XCTAssertTrue(rules.block(domain: "criteo.com"))
        XCTAssertTrue(rules.block(domain: "adition.com"))
        XCTAssertTrue(rules.block(domain: "openx.net"))
        XCTAssertTrue(rules.block(domain: "*guim.co.uk"))
        XCTAssertTrue(rules.block(domain: "indexww.com"))
        XCTAssertTrue(rules.block(domain: "the-ozone-project.com"))
        XCTAssertTrue(rules.block(domain: "googleadservices.com"))
        XCTAssertTrue(rules.block(domain: "doubleclick.net"))
        XCTAssertTrue(rules.block(domain: "addthis.com"))
        XCTAssertTrue(rules.block(domain: "sparwelt.click"))
        XCTAssertTrue(rules.block(domain: "adrtx.net"))
        XCTAssertTrue(rules.block(domain: "amazon-adsystem.com"))
        XCTAssertTrue(rules.block(domain: "dwcdn.net"))
        XCTAssertTrue(rules.block(domain: "rubiconproject.com"))
        XCTAssertTrue(rules.block(domain: "creativecdn.com"))
        XCTAssertTrue(rules.block(domain: "medtargetsystem.com"))
        XCTAssertTrue(rules.block(domain: "*tr.snapchat.com"))
        XCTAssertTrue(rules.block(domain: "*platform.linkedin.com"))
        XCTAssertTrue(rules.block(domain: "google-analytics.com"))
        XCTAssertTrue(rules.block(domain: "*accounts.google.com"))
        XCTAssertTrue(rules.block(domain: "ufpcdn.com"))
        XCTAssertTrue(rules.block(domain: "onclickgenius.com"))
        XCTAssertTrue(rules.block(domain: "appsflyer.com"))
        XCTAssertTrue(rules.block(domain: "onmarshtompor.com"))
        XCTAssertTrue(rules.block(domain: "rakamu.com"))
        XCTAssertTrue(rules.block(domain: "bongacams.com"))
        XCTAssertTrue(rules.block(domain: "bngpt.com"))
        XCTAssertTrue(rules.block(domain: "user-shield.com"))
        XCTAssertTrue(rules.block(domain: "adsco.re"))
        XCTAssertTrue(rules.block(domain: "bet365.com"))
        XCTAssertTrue(rules.block(domain: "caradstag.casa"))
        XCTAssertTrue(rules.block(domain: "monkposseacre.casa"))
        XCTAssertTrue(rules.block(domain: "apostropheemailcompetence.com"))
        XCTAssertTrue(rules.block(domain: "fgfgnbmeieorr910.com"))
        XCTAssertTrue(rules.block(domain: "dexpredict.com"))
        XCTAssertTrue(rules.block(domain: "hornsgrid.com"))
        XCTAssertTrue(rules.block(domain: "zap.buzz"))
        XCTAssertTrue(rules.block(domain: "*consent.google.com"))
        XCTAssertTrue(rules.block(domain: "adnxs.com"))
    }
    
    func testPartial() {
        XCTAssertTrue(rules.block(domain: "google.com", url: "google.com/pagead/"))
        XCTAssertTrue(rules.block(domain: "google.com", url: "google.com/recaptcha/"))
        XCTAssertTrue(rules.block(domain: "youtube.com", url: "youtube.com/embed/"))
    }
}
