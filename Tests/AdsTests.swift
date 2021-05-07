import XCTest
import Sleuth

final class AdsTests: XCTestCase {
    private var parser: Parser!
    
    override func setUp() {
        parser = .init(content: Blocker.rules([.ads]))
    }
    
    func testCss() {
        XCTAssertTrue(parser.css(url: "ecosia.org", selectors: [".card-ad",
                                                                   ".card-productads"]))
        
        XCTAssertTrue(parser.css(url: "google.com", selectors: ["#taw",
                                                                   "#rhs",
                                                                   "#tadsb",
                                                                   ".commercial",
                                                                   ".Rn1jbe",
                                                                   ".kxhcC",
                                                                   ".isv-r.PNCib.BC7Tfc",
                                                                   ".isv-r.PNCib.o05QGe"]))
    }
    /*
    func testGoogle() {
        
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
        XCTAssertTrue(rules.block(url: "google.com/pagead", on: "google.com"))
        XCTAssertTrue(rules.block(url: "google.com/recaptcha", on: "google.com"))
        XCTAssertTrue(rules.block(url: "google.com/swg", on: "google.com"))
        XCTAssertTrue(rules.block(url: "youtube.com/embed", on: "youtube.com"))
    }*/
}
