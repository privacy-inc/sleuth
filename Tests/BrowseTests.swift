import XCTest
@testable import Sleuth

final class BrowseTests: XCTestCase {
    func testBrowseEmpty() {
        XCTAssertNil("".browse(engine: .ecosia) { $0 })
        XCTAssertNil(" ".browse(engine: .ecosia) { $0 })
        XCTAssertNil("\n".browse(engine: .ecosia) { $0 })
    }
    
    func testSearch() {
        XCTAssertEqual("https://www.ecosia.org/search?q=hello%20world", "hello world".browse(engine: .ecosia) { $0 })
        XCTAssertEqual("https://www.google.com/search?q=hello%20world", "hello world".browse(engine: .google) { $0 })
    }
    
    func testURL() {
        XCTAssertEqual("https://github.com", "https://github.com".browse(engine: .google) { $0 })
    }
    
    func testPartialURL() {
        XCTAssertEqual("https://github.com", "github.com".browse(engine: .google) { $0 })
    }
    
    func testDeeplinks() {
        XCTAssertEqual("itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus", "itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus".browse(engine: .google) { $0 })
    }
    
    func testAmpersand() {
        XCTAssertEqual("https://www.google.com/search?q=hello%26world", "hello&world".browse(engine: .google) { $0 })
    }
    
    func testPlus() {
        XCTAssertEqual("https://www.google.com/search?q=hello%2Bworld", "hello+world".browse(engine: .google) { $0 })
    }
    
    func testCaret() {
        XCTAssertEqual("https://www.google.com/search?q=hello%5Eworld", "hello^world".browse(engine: .google) { $0 })
    }
    
    func testSemiColon() {
        XCTAssertEqual("https://www.google.com/search?q=hello%3Aworld", "hello:world".browse(engine: .google) { $0 })
    }
    
    func testSemicolonWithURL() {
        XCTAssertEqual("https://www.google.com/search?q=wkwebview%20site%3A%20stackoverflow.com", "wkwebview site: stackoverflow.com".browse(engine: .google) { $0 })
    }
    
    func testAlmostURLButSearch() {
        XCTAssertEqual("https://www.google.com/search?q=facebook.com%20cezz", "facebook.com cezz".browse(engine: .google) { $0 })
    }
    
    func testURLWithSpace() {
        XCTAssertEqual("https://www.google.com/search?q=hello%20world", "https://www.google.com/search?q=hello world".browse(engine: .google) { $0 })
    }
    
    func testLocalPath() {
        XCTAssertEqual("https://www.google.com/search?q=/private/var/mobile/Containers/Data/Application/74C82CFA-C973-4CDD-ADDF-8DC95C6E3B11/tmp/image.png", "/private/var/mobile/Containers/Data/Application/74C82CFA-C973-4CDD-ADDF-8DC95C6E3B11/tmp/image.png".browse(engine: .google) { $0 })
    }
    
    func testHttp() {
        XCTAssertEqual("https://www.google.com/search?q=http", "http".browse(engine: .google) { $0 })
        XCTAssertEqual("https://www.google.com/search?q=https", "https".browse(engine: .google) { $0 })
        XCTAssertEqual("https://www.google.com/search?q=https%3A", "https:".browse(engine: .google) { $0 })
        XCTAssertEqual("https://www.google.com/search?q=https%3A/", "https:/".browse(engine: .google) { $0 })
        XCTAssertEqual("https://www.google.com/search?q=https%3A//", "https://".browse(engine: .google) { $0 })
    }
    
    func testDeeplink() {
        XCTAssertEqual("macappstores://apps.apple.com/us/app/avocado-kanban/id1549855022?app=mac-app&extRefUrl2=https%3A%2F%2Favoca-do.github.io", "macappstores://apps.apple.com/us/app/avocado-kanban/id1549855022?app=mac-app&extRefUrl2=https%3A%2F%2Favoca-do.github.io".browse(engine: .google) { $0 })
    }
}
