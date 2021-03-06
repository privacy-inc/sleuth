import XCTest
@testable import Sleuth

final class PageTests: XCTestCase {
    func testProperty() {
        let page = Page(title: "adsdasafas", access: .remote(.init(value: "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1")))
        XCTAssertEqual(page, page.data.prototype())
    }
    
    func testAccess() {
        XCTAssertEqual("https://www.aguacate.com", Page(access: .init(url: URL(string: "https://www.aguacate.com")!)).access.value)
    }
    
    func testShort() {
        XCTAssertEqual("aguacate", Page(title: "adsdasafas", access: .remote(.init(value: "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"))).access.short)
    }
    
    func testSecure() {
        if case let .remote(remote) = Page.Access(url: URL(string: "https://www.aguacate.com")!) {
            XCTAssertTrue(remote.secure)
        } else {
            XCTFail()
        }
        
        if case let .remote(remote) = Page.Access(url: URL(string: "http://www.aguacate.com")!) {
            XCTAssertFalse(remote.secure)
        } else {
            XCTFail()
        }
        
        if case let .remote(remote) = Page.Access(url: URL(string: "ftp://www.aguacate.com")!) {
            XCTAssertFalse(remote.secure)
        } else {
            XCTFail()
        }
    }
}
