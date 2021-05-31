import XCTest
@testable import Sleuth

final class AutocompleteTests: XCTestCase {
    private var archive: Archive!
    
    override func setUp() {
        archive = .new
    }
    
    func testMostRecent() {
        archive.browse = [
            .init(id: 0, page: .init(title: "hello4", access: .init(url: URL(string: "about:blank")!)), date: Calendar.current.date(byAdding: .day, value: -1, to: .init())!),
            .init(id: 0, page: .init(title: "hello", access: .init(url: URL(string: "about:blank")!)), date: Calendar.current.date(byAdding: .day, value: -2, to: .init())!)]
        XCTAssertEqual("hello4", archive.browse.filter("hello").first?.title)
    }
    
    func testURL() {
        archive.browse = [
            .init(id: 0, page: .init(title: "AlGol", access: .init(url: URL(string: "www.hello.com")!)), date: Calendar.current.date(byAdding: .day, value: -1, to: .init())!)]
        XCTAssertEqual("AlGol", archive.browse.filter("HeLlo").first?.title)
    }
}
