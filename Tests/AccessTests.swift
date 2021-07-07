import XCTest
@testable import Sleuth

final class AccessTests: XCTestCase {
    func testRemote() {
        XCTAssertEqual("https://www.aguacate.com", Page.Access(url: URL(string: "https://www.aguacate.com")!).value)
        XCTAssertEqual("https://www.aguacate.com", Page.Access.remote(.init(value: "https://www.aguacate.com")).value)
        
        if case .remote = Page.Access(url: URL(string: "https://goprivacy.app")!) {

        } else {
            XCTFail()
        }
    }
    
    func testLocal() {
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString + "file.html", Page.Access(url: file).value)
        
        if case let .local(local) = Page.Access(url: file) {
            local
                .open {
                    XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString.replacingOccurrences(of: "var/", with: "private/var/"), $0.absoluteString)
                }
        } else {
            XCTFail()
        }
    }
    
    func testDeeplink() {
        if case let .deeplink(deeplink) = Page.Access(url: URL(string: "privacy://hello%20world")!) {
            XCTAssertEqual("privacy", deeplink.scheme)
        } else {
            XCTFail()
        }
    }
}
