import XCTest
import Archivable
import Sleuth

final class BreakingTests: XCTestCase {
    private var cloud: Cloud<Synch>.Stub!
    private let list =  [
        "https://consent.youtube.com/m?continue=https%3A%2F%2Fwww.youtube.com%2F&gl=DE&m=0&pc=yt&uxe=23983172&hl=en-GB&src=1"
    ]
    
    override func setUp() {
        cloud = .init()
        cloud.archive.value = .new
    }
    
    func test() {
        list
            .map {
                ($0, cloud.validate(URL(string: $0)!, with: .antitracker))
            }
            .forEach {
                if case .allow = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
