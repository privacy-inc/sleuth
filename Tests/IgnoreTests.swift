import XCTest
@testable import Sleuth

final class IgnoreTests: XCTestCase {
    private var router: Router!
    private let list =  [
        "about:blank",
        "about:srcdoc",
        "adsadasdddsada",
        "https:///",
        "https://dfddasadas"
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
                if case .ignore = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
