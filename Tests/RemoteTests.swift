import XCTest
@testable import Sleuth

final class RemoteTests: XCTestCase {
    func testDomain() {
        XCTAssertEqual("https://", Page.Remote(value: "https://").domain)
        XCTAssertEqual("", Page.Remote(value: "").domain)
        XCTAssertEqual("wds", Page.Remote(value: "wds").domain)
        XCTAssertEqual("linkedin", Page.Remote(value: "https://www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a").domain)
        XCTAssertEqual("linkedin", Page.Remote(value: "www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a").domain)
        XCTAssertEqual("hello", Page.Remote(value: "www.hello.com").domain)
        XCTAssertEqual("hello", Page.Remote(value: "www.hello.com/lol").domain)
        XCTAssertEqual("world", Page.Remote(value: "www.hello.world.com/lol").domain)
        XCTAssertEqual("world", Page.Remote(value: "https://hello.world.com/lol").domain)
        XCTAssertEqual("bbc", Page.Remote(value: "https://bbc.co.uk").domain)
        XCTAssertEqual("privacy-inc", Page.Remote(value: "https://privacy-inc.github.io/about").domain)
    }
    
    func testSuffix() {
        XCTAssertEqual("", Page.Remote(value: "https://").suffix)
        XCTAssertEqual("", Page.Remote(value: "").suffix)
        XCTAssertEqual("", Page.Remote(value: "wds").suffix)
        XCTAssertEqual(".com", Page.Remote(value: "https://www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a").suffix)
        XCTAssertEqual(".com", Page.Remote(value: "www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a").suffix)
        XCTAssertEqual(".com", Page.Remote(value: "www.hello.com").suffix)
        XCTAssertEqual(".com", Page.Remote(value: "www.hello.com/lol").suffix)
        XCTAssertEqual(".com", Page.Remote(value: "www.hello.world.com/lol").suffix)
        XCTAssertEqual(".com", Page.Remote(value: "https://hello.world.com/lol").suffix)
        XCTAssertEqual(".co.uk", Page.Remote(value: "https://bbc.co.uk").suffix)
        XCTAssertEqual(".app", Page.Remote(value: "https://goprivacy.app").suffix)
        XCTAssertEqual(".github.io", Page.Remote(value: "https://privacy-inc.github.io/about").suffix)
    }
}
