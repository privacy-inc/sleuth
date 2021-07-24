import XCTest
@testable import Sleuth

final class MigrationTests: XCTestCase {
    func testSettingsWithoutTimers() {
        XCTAssertFalse((Settings().pre + [0]).prototype(Settings.self).third)
    }
}
