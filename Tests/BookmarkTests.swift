import XCTest
@testable import Sleuth

final class BookmarkTests: XCTestCase {
    func testRemote() {
        XCTAssertEqual("https://www.aguacate.com", Page.Bookmark(url: URL(string: "https://www.aguacate.com")!).access?.absoluteString)
        XCTAssertEqual("https://www.aguacate.com", Page.Bookmark.remote("https://www.aguacate.com").access?.absoluteString)
    }
    
    func testLocal() {
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString.replacingOccurrences(of: "var/", with: "private/var/"), Page.Bookmark(url: file).access?.absoluteString)
    }
}
