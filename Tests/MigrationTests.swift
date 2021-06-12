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
    
    func testbrowse() {
        let date = Date()
        let migrated = Data()
            .adding(UInt16(34))
            .adding(date)
            .adding("hello world")
            .adding(Page.Access.init(url: URL(string: "https://www.aguacate.com")!).data)
            .prototype(Browse.self)
        XCTAssertEqual(34, migrated.id)
        XCTAssertEqual(date.timestamp, migrated.date.timestamp)
        XCTAssertEqual("hello world", migrated.page.title)
        XCTAssertEqual("https://www.aguacate.com", migrated.page.access.url?.absoluteString)
    }
    
    func testSettingsV1() {
        XCTAssertEqual(.ecosia, Settings.V1(engine: .ecosia).data.prototype(Settings.self).engine)
        XCTAssertEqual(.google, Settings.V1(engine: .google).data.prototype(Settings.self).engine)
        XCTAssertFalse(Settings.V1().data.prototype(Settings.self).javascript)
        XCTAssertFalse(Settings.V1().data.prototype(Settings.self).dark)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).popups)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).ads)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).screen)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).trackers)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).cookies)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).http)
        XCTAssertTrue(Settings.V1().data.prototype(Settings.self).location)
        
        XCTAssertFalse(Settings().data.prototype(Settings.self).location)
    }
}
