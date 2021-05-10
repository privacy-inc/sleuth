import XCTest
@testable import Sleuth

final class MigrationTests: XCTestCase {
    private var archive: Archive!
    
    override func setUp() {
        archive = .new
    }
    
    func testSettings() {
        let size = Settings().data.count
        archive.counter = 99
        let original: Data = archive
            .data
            .mutating {
                $0.decompress()
                return $0
            }
        let unmigrated = original
            .dropLast(size + 2)
            .compressed
        XCTAssertEqual(99, unmigrated.prototype(Archive.self).counter)
    }
    
    func testBookmarks() {
        archive.counter = 99
        let original: Data = archive
            .data
            .mutating {
                $0.decompress()
                return $0
            }
        let unmigrated = original
            .dropLast(2)
            .compressed
        XCTAssertEqual(99, unmigrated.prototype(Archive.self).counter)
    }
    
    func testHistory() {
        let date = Date()
        let migrated = Data()
            .adding(UInt16(34))
            .adding(date)
            .adding("hello world")
            .adding(Page.Access.init(url: URL(string: "https://www.aguacate.com")!).data)
            .prototype(History.self)
        XCTAssertEqual(34, migrated.id)
        XCTAssertEqual(date.timestamp, migrated.date.timestamp)
        XCTAssertEqual("hello world", migrated.title)
        XCTAssertEqual("https://www.aguacate.com", migrated.url.absoluteString)
    }
}
