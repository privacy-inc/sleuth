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
    
    func testEmpty() {
        XCTAssertTrue([Page
                        .init(title: "hello", access: .remote("www.hello.com")),
                       .init(title: "hello2", access: .remote("www.hello2.com")),
                       .init(title: "hello3", access: .remote("www.hello3.com"))].filter("lol").isEmpty)
    }
    
    func testMatchURL() {
        let filtered = [Page
                            .init(title: "hello", access: .remote("www.hello.com/lol")),
                           .init(title: "hello2", access: .remote("www.hello2.com")),
                           .init(title: "hello3", access: .remote("www.hello3.com"))].filter("lol").first
        XCTAssertEqual("hello", filtered?.title)
        XCTAssertEqual("hello.com", filtered?.domain)
    }
    
    func testMatchTitle() {
        let filtered = [Page
                            .init(title: "hellolol", access: .remote("www.hello.com")),
                           .init(title: "hello2", access: .remote("www.hello2.com")),
                           .init(title: "hello3", access: .remote("www.hello3.com"))].filter("hellolol").first
        XCTAssertEqual("hellolol", filtered?.title)
        XCTAssertEqual("hello.com", filtered?.domain)
    }
    
    func testRemoveDuplicates() {
        XCTAssertEqual(1, [Page
                            .init(title: "hello", access: .remote("www.hello.com")),
                           .init(title: "hello2", access: .remote("www.hello.com"))].filter("hello").count)
    }
    
    func testRemoveDuplicatesCase() {
        XCTAssertEqual(1, [Page
                            .init(title: "hello", access: .remote("www.hello.com/a")),
                           .init(title: "hello2", access: .remote("www.hello.com/A"))].filter("hello").count)
    }
    
    func testRemoveDuplicatesCaseURL() {
        XCTAssertEqual(1, [Page
                            .init(title: "hello", access: .remote("https://www.google.com/search?q=weather%20berlin")),
                           .init(title: "hello2", access: .remote("https://www.google.com/search?q=Weather%20Berlin"))].filter("weather").count)
    }
    
    func testSorted() {
        let filtered = [Page
                            .init(title: "b", access: .remote("www.a.com")),
                           .init(title: "a", access: .remote("www.z.com"))].filter("com")
        XCTAssertEqual("a", filtered.first?.title)
        XCTAssertEqual("b", filtered.last?.title)
    }
    
    func testSplit() {
        XCTAssertEqual(2, [Page
                            .init(title: "abcdipsumfgh", access: .remote("www.hello.com")),
                           .init(title: "poplorempush", access: .remote("www.world.com"))].filter("lorem total ipsum").count)
    }
}
