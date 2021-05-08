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
//        if case let .search(url) = Engine.ecosia.browse("hello world") {
//            XCTAssertEqual("https://www.ecosia.org/search?q=hello%20world", url)
//        } else {
//            XCTFail()
//        }
//
//        if case let .search(url) = Engine.google.browse("hello world") {
//            XCTAssertEqual("https://www.google.com/search?q=hello%20world", url)
//        } else {
//            XCTFail()
//        }
    }
    /*
    func testURL() {
        if case let .navigate(url) = Engine.ecosia.browse("https://github.com") {
            XCTAssertEqual("https://github.com", url)
        } else {
            XCTFail()
        }
    }
    
    func testPartialURL() {
        if case let .navigate(url) = Engine.ecosia.browse("github.com") {
            XCTAssertEqual("https://github.com", url)
        } else {
            XCTFail()
        }
    }
    
    func testDeeplinks() {
        if case let .navigate(url) = Engine.ecosia.browse("itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus") {
            XCTAssertEqual("itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus",
                           url)
        } else {
            XCTFail()
        }
    }
    
    func testAmpersand() {
        if case let .search(url) = Engine.google.browse("hello&world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%26world", url)
        } else {
            XCTFail()
        }
    }
    
    func testPlus() {
        if case let .search(url) = Engine.google.browse("hello+world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%2Bworld", url)
        } else {
            XCTFail()
        }
    }
    
    func testCaret() {
        if case let .search(url) = Engine.google.browse("hello^world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%5Eworld", url)
        } else {
            XCTFail()
        }
    }
    
    func testSemiColon() {
        if case let .search(url) = Engine.google.browse("hello:world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%3Aworld", url)
        } else {
            XCTFail()
        }
    }
    
    func testHttp() {
        if case let .search(url) = Engine.google.browse("http") {
            XCTAssertEqual("https://www.google.com/search?q=http", url)
        } else {
            XCTFail()
        }
        
        if case let .search(url) = Engine.google.browse("https") {
            XCTAssertEqual("https://www.google.com/search?q=https", url)
        } else {
            XCTFail()
        }
        
        if case let .search(url) = Engine.google.browse("https:") {
            XCTAssertEqual("https://www.google.com/search?q=https%3A", url)
        } else {
            XCTFail()
        }
        
        if case let .search(url) = Engine.google.browse("https:/") {
            XCTAssertEqual("https://www.google.com/search?q=https%3A/", url)
        } else {
            XCTFail()
        }
        
        if case let .search(url) = Engine.google.browse("https://") {
            XCTAssertEqual("https://www.google.com/search?q=https%3A//", url)
        } else {
            XCTFail()
        }
    }
    
    func testDeeplink() {
        if case let .navigate(url) = Engine.google.browse("macappstores://apps.apple.com/us/app/avocado-kanban/id1549855022?app=mac-app&extRefUrl2=https%3A%2F%2Favoca-do.github.io") {
            XCTAssertEqual("macappstores://apps.apple.com/us/app/avocado-kanban/id1549855022?app=mac-app&extRefUrl2=https%3A%2F%2Favoca-do.github.io", url)
        } else {
            XCTFail()
        }
    }
 */
}
