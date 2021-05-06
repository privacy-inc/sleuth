import XCTest
import Sleuth

final class BreakingTests: XCTestCase {
    private var router: Router!
    private let list =  [
        "https://consent.youtube.com/m?continue=https%3A%2F%2Fwww.youtube.com%2F&gl=DE&m=0&pc=yt&uxe=23983172&hl=en-GB&src=1"
    ]
    
    override func setUp() {
        router = .secure
    }
    
    func test() {
        list
            .map {
                ($0, router(URL(string: $0)!))
            }
            .forEach {
                if case .allow = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
