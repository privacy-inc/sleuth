import XCTest
@testable import Sleuth

final class BrowseTests: XCTestCase {
    func testBrowseEmpty() {
        XCTAssertNil("".browse(engine: .ecosia) { url, _ in url })
        XCTAssertNil(" ".browse(engine: .ecosia) { url, _ in url })
        XCTAssertNil("\n".browse(engine: .ecosia) { url, _ in url })
    }
    
    func testSearch() {
        XCTAssertEqual("https://www.ecosia.org/search?q=hello%20world", "hello world".browse(engine: .ecosia) { url, _ in url })
        XCTAssertEqual("https://www.google.com/search?q=hello%20world", "hello world".browse(engine: .google) { url, _ in url })
    }
    
    func testURL() {
        XCTAssertEqual("https://github.com", "https://github.com".browse(engine: .google) { url, _ in url })
    }
    
    func testPartialURL() {
        XCTAssertEqual("https://github.com", "github.com".browse(engine: .google) { url, _ in url })
    }
    
    func testDeeplinks() {
        XCTAssertEqual("itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus", "itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus".browse(engine: .google) { url, _ in url })
    }
    
    func testAmpersand() {
        XCTAssertEqual("https://www.google.com/search?q=hello%26world", "hello&world".browse(engine: .google) { url, _ in url })
    }
    
    func testPlus() {
        XCTAssertEqual("https://www.google.com/search?q=hello%2Bworld", "hello+world".browse(engine: .google) { url, _ in url })
    }
    
    func testCaret() {
        XCTAssertEqual("https://www.google.com/search?q=hello%5Eworld", "hello^world".browse(engine: .google) { url, _ in url })
    }
    
    func testSemiColon() {
        XCTAssertEqual("https://www.google.com/search?q=hello%3Aworld", "hello:world".browse(engine: .google) { url, _ in url })
    }
    
    func testHttp() {
        XCTAssertEqual("https://www.google.com/search?q=http", "http".browse(engine: .google) { url, _ in url })
        XCTAssertEqual("https://www.google.com/search?q=https", "https".browse(engine: .google) { url, _ in url })
        XCTAssertEqual("https://www.google.com/search?q=https%3A", "https:".browse(engine: .google) { url, _ in url })
        XCTAssertEqual("https://www.google.com/search?q=https%3A/", "https:/".browse(engine: .google) { url, _ in url })
        XCTAssertEqual("https://www.google.com/search?q=https%3A//", "https://".browse(engine: .google) { url, _ in url })
    }
    
    func testDeeplink() {
        XCTAssertEqual("macappstores://apps.apple.com/us/app/avocado-kanban/id1549855022?app=mac-app&extRefUrl2=https%3A%2F%2Favoca-do.github.io", "macappstores://apps.apple.com/us/app/avocado-kanban/id1549855022?app=mac-app&extRefUrl2=https%3A%2F%2Favoca-do.github.io".browse(engine: .google) { url, _ in url })
    }
}
