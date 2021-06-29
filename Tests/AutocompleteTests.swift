import XCTest
@testable import Sleuth

final class AutocompleteTests: XCTestCase {
    private var archive: Archive!
    
    override func setUp() {
        archive = .new
    }
    
    func testURL() {
        archive.browses = [
            .init(id: 0, page: .init(title: "AlGol", access: .init(url: URL(string: "www.hello.com")!)), date: Calendar.current.date(byAdding: .day, value: -1, to: .init())!)]
        XCTAssertEqual("AlGol", archive.browses.filter("HeLlo").first?.title)
    }
}
