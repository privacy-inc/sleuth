import XCTest
import Combine
@testable import Sleuth

final class ArchiveTests: XCTestCase {
    private var archive: Archive!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        archive = .new
        Repository.override = .init()
    }
    
    func testDate() {
        let date0 = Date(timeIntervalSince1970: 0)
        archive = .new
        XCTAssertGreaterThanOrEqual(archive.data.mutating(transform: Archive.init(data:)).date.timestamp, date0.timestamp)
        let date1 = Date(timeIntervalSince1970: 1)
        archive.date = date1
        XCTAssertGreaterThanOrEqual(archive.data.mutating(transform: Archive.init(data:)).date.timestamp, date1.timestamp)
    }
}
