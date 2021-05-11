import XCTest
@testable import Sleuth

final class AccessTests: XCTestCase {
    func testRemote() {
        XCTAssertEqual("https://www.aguacate.com", Page.Access(url: URL(string: "https://www.aguacate.com")!).url?.absoluteString)
        XCTAssertEqual("https://www.aguacate.com", Page.Access.remote("https://www.aguacate.com").url?.absoluteString)
    }
    
    func testLocal() {
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString.replacingOccurrences(of: "var/", with: "private/var/"), Page.Access(url: file).url?.absoluteString)
    }
}
