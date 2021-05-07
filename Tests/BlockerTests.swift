import XCTest
import Sleuth

final class BlockerTests: XCTestCase {
    func testAllCases() {
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases))).cookies)
        XCTAssertTrue(Parser(content: Blocker.rules(.init(Blocker.allCases))).http)
    }
    
    func testCookies() {
        XCTAssertTrue(Parser(content: Blocker.rules([.cookies])).cookies)
    }
    
    func testHttp() {
        XCTAssertTrue(Parser(content: Blocker.rules([.http])).http)
    }
    
    func testAdds() {
        XCTAssertTrue(Parser(content: Blocker.rules([.ads]))
                        .css(url: "www.ecosia.org", selectors: [".card-ad",
                                                                ".card-productads"]))
        
        XCTAssertTrue(Parser(content: Blocker.rules([.ads]))
                        .css(url: "www.google.com", selectors: ["#taw",
                                                                "#rhs",
                                                                "#tadsb",
                                                                ".commercial",
                                                                ".Rn1jbe",
                                                                ".kxhcC",
                                                                ".isv-r.PNCib.BC7Tfc",
                                                                ".isv-r.PNCib.o05QGe"]))
    }
}
