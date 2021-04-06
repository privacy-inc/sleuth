import XCTest
import Sleuth

final class EngineTests: XCTestCase {
    func testEmpty() {
        XCTAssertNil(Engine.ecosia.browse(""))
        XCTAssertNil(Engine.ecosia.browse(" "))
        XCTAssertNil(Engine.ecosia.browse("\n"))
    }
    
    func testSearch() {
        if case let .search(url) = Engine.ecosia.browse("hello world") {
            XCTAssertEqual("https://www.ecosia.org/search?q=hello%20world", url.absoluteString)
        } else {
            XCTFail()
        }
        
        if case let .search(url) = Engine.google.browse("hello world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%20world", url.absoluteString)
        } else {
            XCTFail()
        }
    }
    
    func testURL() {
        if case let .navigate(url) = Engine.ecosia.browse("https://github.com") {
            XCTAssertEqual("https://github.com", url.absoluteString)
        } else {
            XCTFail()
        }
    }
    
    func testPartialURL() {
        if case let .navigate(url) = Engine.ecosia.browse("github.com") {
            XCTAssertEqual("https://github.com", url.absoluteString)
        } else {
            XCTFail()
        }
    }
    
    func testDeeplinks() {
        if case let .navigate(url) = Engine.ecosia.browse("itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus") {
            XCTAssertEqual("itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus",
                           url.absoluteString)
        } else {
            XCTFail()
        }
    }
    
    func testAmpersand() {
        if case let .search(url) = Engine.google.browse("hello&world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%26world", url.absoluteString)
        } else {
            XCTFail()
        }
    }
    
    func testPlus() {
        if case let .search(url) = Engine.google.browse("hello+world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%2Bworld", url.absoluteString)
        } else {
            XCTFail()
        }
    }
    
    func testCaret() {
        if case let .search(url) = Engine.google.browse("hello^world") {
            XCTAssertEqual("https://www.google.com/search?q=hello%5Eworld", url.absoluteString)
        } else {
            XCTFail()
        }
    }
}
