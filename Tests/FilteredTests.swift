import XCTest
@testable import Sleuth

final class FilteredTests: XCTestCase {
    func testBookmarks() {
        XCTAssertTrue([Page]().filter("").isEmpty)
        XCTAssertEqual(2, [Page
                            .init(title: "hello", access: .remote("www.hello.com")),
                           .init(title: "hello2", access: .remote("www.hello2.com")),
                           .init(title: "hello3", access: .remote("www.hello3.com"))].filter("").count)
    }
    
    func testBrowse() {
        XCTAssertTrue([Browse]().filter("").isEmpty)
        XCTAssertEqual(3, [Browse(id: 0, page: .init(title: "hello", access: .remote("www.hello.com"))),
                           Browse(id: 1, page: .init(title: "hello2", access: .remote("www.hello2.com"))),
                           Browse(id: 2, page: .init(title: "hello3", access: .remote("www.hello3.com"))),
                           Browse(id: 3, page: .init(title: "hello4", access: .remote("www.hello4.com")))].filter("").count)
    }
}
