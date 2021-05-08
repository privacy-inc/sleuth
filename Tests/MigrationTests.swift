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
            .dropLast(size)
            .compressed
        XCTAssertEqual(99, unmigrated.prototype(Archive.self).counter)
    }
}
