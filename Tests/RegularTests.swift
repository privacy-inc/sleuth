import XCTest
@testable import Sleuth

final class RegularTests: XCTestCase {
    private var router: Router!
    
    private let listA =  [
        "about:blank",
        "about:srcdoc"
    ]
    
    private let listB = [
        "https://www.ecosia.org",
        "https://www.theguardian.com/email/form/footer/today-uk",
        "https://sourcepoint.theguardian.com/index.html?message_id=343252&consentUUID=4debba32-1827-4286-b168-cd0a6068f5f5&requestUUID=0a3ee8d3-cc2e-43b1-99ba-ceb02302f3e5&preload_message=true)",
        "https://tags.crwdcntrl.net/lt/shared/1/lt.iframe.html",
    ]
    
    private let listC = [
        "some://www.ecosia.org",
        "apps://www.theguardian.com/email/form/footer/today-uk",
        "sms://uk.reuters.com/"
    ]
    
    override func setUp() {
        router = .regular
    }
    
    func testIgnore() {
        listA
            .map {
                ($0, router(URL(string: $0)!))
            }
            .forEach {
                if case .ignore = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
    
    func testAllow() {
        listB
            .map {
                ($0, router(URL(string: $0)!))
            }
            .forEach {
                if case .allow = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
    
    func testExternal() {
        listC
            .map {
                ($0, router(URL(string: $0)!))
            }
            .forEach {
                if case .external = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
