import XCTest
@testable import Sleuth

final class BookmarkTests: XCTestCase {
    func testRemote() {
        XCTAssertEqual("https://www.aguacate.com", Entry.Bookmark(url: URL(string: "https://www.aguacate.com")!).access?.absoluteString)
        XCTAssertEqual("https://www.aguacate.com", Entry.Bookmark.remote("https://www.aguacate.com").access?.absoluteString)
    }
    
    func testLocal() {
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString.replacingOccurrences(of: "var/", with: "private/var/"), Entry.Bookmark(url: file).access?.absoluteString)
    }
}
