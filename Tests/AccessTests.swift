import XCTest
@testable import Sleuth

final class AccessTests: XCTestCase {
    func testRemote() {
        XCTAssertEqual("https://www.aguacate.com", Page.Access(url: URL(string: "https://www.aguacate.com")!).url?.absoluteString)
        XCTAssertEqual("https://www.aguacate.com", Page.Access.remote(.init(value: "https://www.aguacate.com")).url?.absoluteString)
    }
    
    func testLocal() {
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString + "file.html", Page.Access(url: file).url?.absoluteString)
        
        if case let .local(local) = Page.Access(url: file) {
            XCTAssertEqual(URL(fileURLWithPath: NSTemporaryDirectory()).absoluteString.replacingOccurrences(of: "var/", with: "private/var/"), local.directory?.absoluteString)
        } else {
            XCTFail()
        }
    }
}
