import XCTest
import Sleuth

final class AdsTests: XCTestCase {
    private var rules: Rules!
    
    override func setUp() {
        rules = .init(content: Block.ads)
    }
    
    func testEcosia() {
        XCTAssertTrue(contains("css-display-none", ".card-ad", ".*ecosia.org"))
        XCTAssertTrue(contains("css-display-none", ".card-productads", ".*ecosia.org"))
    }
    
    func testGoogle() {
        XCTAssertTrue(contains("css-display-none", "#taw", ".*google.com"))
        XCTAssertTrue(contains("css-display-none", "#rhs", ".*google.com"))
        XCTAssertTrue(contains("css-display-none", ".commercial", ".*google.com"))
        XCTAssertTrue(contains("css-display-none", "#tadsb", ".*google.com"))
        XCTAssertTrue(contains("css-display-none", ".Rn1jbe", ".*google.com"))
        XCTAssertTrue(contains("css-display-none", ".kxhcC", ".*google.com"))
    }
    
    func testBlock() {
        XCTAssertTrue(rules.block(domain: "https://ads.pubmatic.com"))
        XCTAssertTrue(rules.block(domain: ".*googlesyndication.com"))
        XCTAssertTrue(rules.block(domain: "https://www.dianomi.com"))
        XCTAssertTrue(rules.block(domain: "https://vars.hotjar.com"))
        XCTAssertTrue(rules.block(domain: "https://contextual.media.net"))
        XCTAssertTrue(rules.block(domain: "https://imasdk.googleapis.com"))
        XCTAssertTrue(rules.block(domain: "https://platform.twitter.com"))
        XCTAssertTrue(rules.block(domain: "https://mafo.adalliance.io"))
        XCTAssertTrue(rules.block(domain: "https://ad.yieldlab.net"))
        XCTAssertTrue(rules.block(domain: "https://static.emsservice.de"))
        XCTAssertTrue(rules.block(domain: "https://cdn.flashtalking.com"))
        XCTAssertTrue(rules.block(domain: "https://gum.criteo.com"))
        XCTAssertTrue(rules.block(domain: "https://imagesrv.adition.com"))
        XCTAssertTrue(rules.block(domain: "https://us-u.openx.net"))
        XCTAssertTrue(rules.block(domain: "https://www.google.com/pagead/"))
        XCTAssertTrue(rules.block(domain: "https://www.google.com/recaptcha/"))
        XCTAssertTrue(rules.block(domain: "https://interactive.guim.co.uk"))
        XCTAssertTrue(rules.block(domain: "https://js-sec.indexww.com"))
        XCTAssertTrue(rules.block(domain: "https://elb.the-ozone-project.com"))
        XCTAssertTrue(rules.block(domain: "https://www.googleadservices.com"))
        XCTAssertTrue(rules.block(domain: ".*doubleclick.net"))
        XCTAssertTrue(rules.block(domain: "https://s7.addthis.com"))
        XCTAssertTrue(rules.block(domain: "https://widgets.sparwelt.click"))
        XCTAssertTrue(rules.block(domain: "https://adstax-match.adrtx.net"))
        XCTAssertTrue(rules.block(domain: "https://aax-eu.amazon-adsystem.com"))
        XCTAssertTrue(rules.block(domain: "https://datawrapper.dwcdn.net"))
        XCTAssertTrue(rules.block(domain: "https://secure-assets.rubiconproject.com"))
        XCTAssertTrue(rules.block(domain: "https://eus.rubiconproject.com"))
        XCTAssertTrue(rules.block(domain: "https://ams.creativecdn.com"))
        XCTAssertTrue(rules.block(domain: "https://www.youtube.com/embed"))
        XCTAssertTrue(rules.block(domain: "https://www.medtargetsystem.com"))
        XCTAssertTrue(rules.block(domain: "https://tr.snapchat.com"))
        XCTAssertTrue(rules.block(domain: "https://platform.linkedin.com"))
        XCTAssertTrue(rules.block(domain: "https://www.google-analytics.com"))
        XCTAssertTrue(rules.block(domain: "https://accounts.google.com"))
        XCTAssertTrue(rules.block(domain: "https://ufpcdn.com"))
        XCTAssertTrue(rules.block(domain: "https://onclickgenius.com"))
        XCTAssertTrue(rules.block(domain: "https://app.appsflyer.com"))
        XCTAssertTrue(rules.block(domain: "https://onmarshtompor.com"))
        XCTAssertTrue(rules.block(domain: "https://rakamu.com"))
        XCTAssertTrue(rules.block(domain: "https://bongacams.com"))
        XCTAssertTrue(rules.block(domain: "https://bngpt.com"))
        XCTAssertTrue(rules.block(domain: "https://user-shield.com"))
        XCTAssertTrue(rules.block(domain: "https://c.adsco.re"))
        XCTAssertTrue(rules.block(domain: "https://www.bet365.com"))
        XCTAssertTrue(rules.block(domain: "https://caradstag.casa"))
        XCTAssertTrue(rules.block(domain: "https://monkposseacre.casa"))
        XCTAssertTrue(rules.block(domain: "http://apostropheemailcompetence.com"))
        XCTAssertTrue(rules.block(domain: "https://fgfgnbmeieorr910.com"))
        XCTAssertTrue(rules.block(domain: "https://www.dexpredict.com"))
        XCTAssertTrue(rules.block(domain: "https://hornsgrid.com"))
        XCTAssertTrue(rules.block(domain: "https://zap.buzz"))
        XCTAssertTrue(rules.block(domain: "https://consent.google.com"))
    }
    
    private func contains(_ type: String, _ selector: String?, _ filter: String) -> Bool {
        dictonary.contains { $0["action"]!["type"] == type
            && $0["trigger"]!["url-filter"] == filter
            && $0["action"]!["selector"] == selector }
    }
}
