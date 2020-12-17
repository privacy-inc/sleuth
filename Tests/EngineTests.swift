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
            XCTAssertEqual("http://github.com", url.absoluteString)
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
    
    func testDeeplinkValidation() {
        XCTAssertTrue(URL(string: "itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus")!.deeplink)
        XCTAssertFalse(URL(string: "github.com")!.deeplink)
        XCTAssertFalse(URL(string: "http://github.com")!.deeplink)
        XCTAssertFalse(URL(string: "https://github.com")!.deeplink)
    }
}
