import XCTest
@testable import Sleuth

final class FilteredTests: XCTestCase {
    func testBookmarks() {
        XCTAssertTrue([Page]().filter("").isEmpty)
        XCTAssertEqual(2, [Page
                            .init(title: "hello", access: .remote(.init(value: "www.hello.com"))),
                           .init(title: "hello2", access: .remote(.init(value: "www.hello2.com"))),
                           .init(title: "hello3", access: .remote(.init(value: "www.hello3.com")))].filter("").count)
    }
    
    func testBrowse() {
        XCTAssertTrue([Browse]().filter("").isEmpty)
        XCTAssertEqual(3, [Browse(id: 0, page: .init(title: "hello", access: .remote(.init(value: "www.hello.com")))),
                           Browse(id: 1, page: .init(title: "hello2", access: .remote(.init(value: "www.hello2.com")))),
                           Browse(id: 2, page: .init(title: "hello3", access: .remote(.init(value: "www.hello3.com")))),
                           Browse(id: 3, page: .init(title: "hello4", access: .remote(.init(value: "www.hello4.com"))))].filter("").count)
    }
    
    func testEmptyFilter() {
        let filtered = [Page
                            .init(title: "c", access: .remote(.init(value: "www.hello.com"))),
                           .init(title: "a", access: .remote(.init(value: "www.hello2.com"))),
                           .init(title: "b", access: .remote(.init(value: "www.hello3.com")))].filter("")
        XCTAssertEqual("c", filtered.first?.title)
        XCTAssertEqual("a", filtered.last?.title)
    }
    
    func testEmpty() {
        XCTAssertTrue([Page
                        .init(title: "hello", access: .remote(.init(value: "www.hello.com"))),
                       .init(title: "hello2", access: .remote(.init(value: "www.hello2.com"))),
                       .init(title: "hello3", access: .remote(.init(value: "www.hello3.com")))].filter("lol").isEmpty)
    }
    
    func testMatchURL() {
        let filtered = [Page
                            .init(title: "hello", access: .remote(.init(value: "www.hello.com/lol"))),
                           .init(title: "hello2", access: .remote(.init(value: "www.hello2.com"))),
                           .init(title: "hello3", access: .remote(.init(value: "www.hello3.com")))].filter("lol").first
        XCTAssertEqual("hello", filtered?.title)
        XCTAssertEqual("hello", filtered?.short)
    }
    
    func testMatchTitle() {
        let filtered = [Page
                            .init(title: "hellolol", access: .remote(.init(value: "www.hello.com"))),
                           .init(title: "hello2", access: .remote(.init(value: "www.hello2.com"))),
                           .init(title: "hello3", access: .remote(.init(value: "www.hello3.com")))].filter("hellolol").first
        XCTAssertEqual("hellolol", filtered?.title)
        XCTAssertEqual("hello", filtered?.short)
    }
    
    func testRemoveDuplicates() {
        XCTAssertEqual(1, [Page
                            .init(title: "hello", access: .remote(.init(value: "www.hello.com"))),
                           .init(title: "hello2", access: .remote(.init(value: "www.hello.com")))].filter("hello").count)
    }
    
    func testRemoveDuplicatesCase() {
        XCTAssertEqual(1, [Page
                            .init(title: "hello", access: .remote(.init(value: "www.hello.com/a"))),
                           .init(title: "hello2", access: .remote(.init(value: "www.hello.com/A")))].filter("hello").count)
    }
    
    func testRemoveDuplicatesCaseURL() {
        XCTAssertEqual(1, [Page
                            .init(title: "hello", access: .remote(.init(value: "https://www.google.com/search?q=weather%20berlin"))),
                           .init(title: "hello2", access: .remote(.init(value: "https://www.google.com/search?q=Weather%20Berlin")))].filter("weather").count)
    }
    
    func testSorted() {
        let filtered = [Page
                            .init(title: "b", access: .remote(.init(value: "www.a.com"))),
                           .init(title: "a", access: .remote(.init(value: "www.z.com")))].filter("com")
        XCTAssertEqual("a", filtered.first?.title)
        XCTAssertEqual("b", filtered.last?.title)
    }
    
    func testSplit() {
        XCTAssertEqual(2, [Page
                            .init(title: "abcdipsumfgh", access: .remote(.init(value: "www.hello.com"))),
                           .init(title: "poplorempush", access: .remote(.init(value: "www.world.com")))].filter("lorem total ipsum").count)
    }
    
    func testSplitBlank() {
        XCTAssertEqual(2, [Page
                            .init(title: "abcdipsumfgh", access: .remote(.init(value: "www.hello.com"))),
                           .init(title: "poplorempush", access: .remote(.init(value: "www.world.com"))),
                           .init(title: "toto  ", access: .remote(.init(value: "www.some.com")))].filter("lorem   ipsum").count)
    }
    
    func testSortByMatches() {
        let filtered = [Page
            .init(title: "x", access: .remote(.init(value: "www.hello.com"))),
         .init(title: "xyz", access: .remote(.init(value: "www.world.com"))),
         .init(title: "xy", access: .remote(.init(value: "www.some.com")))].filter("x y z")
        XCTAssertEqual(2, filtered.count)
        XCTAssertEqual("xyz", filtered.first?.title)
        XCTAssertEqual("xy", filtered.last?.title)
    }
}
