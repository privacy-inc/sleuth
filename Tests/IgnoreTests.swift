import XCTest
import Archivable
import Sleuth

final class IgnoreTests: XCTestCase {
    private var cloud: Cloud<Archive>!
    private let list =  [
        "about:blank",
        "about:srcdoc",
        "adsadasdddsada"
    ]
    
    override func setUp() {
        cloud = .init(manifest: nil)
    }
    
    func test() {
        list
            .map {
                ($0, cloud.validate(URL(string: $0)!, with: .antitracker))
            }
            .forEach {
                if case .ignore = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
