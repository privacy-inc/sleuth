import XCTest
import Sleuth
import Combine

final class AllowTests: XCTestCase {
    private var shield: Shield!
    private var subs = Set<AnyCancellable>()
    private let list = [
        "https://www.ecosia.org",
        "https://www.theguardian.com/email/form/footer/today-uk",
        "https://uk.reuters.com/",
        "https://www-nytimes-com.cdn.ampproject.org/v/s/www.nytimes.com/wirecutter/reviews/best-standing-desk/amp/?0p19G=0232&amp_js_v=0.1&usqp=mq331AQHKAFQCrABIA%3D%3D#origin=https%3A%2F%2Fwww.google.com&prerenderSize=1&visibilityState=prerender&paddingTop=32&p2r=0&csi=1&aoh=16025117842518&viewerUrl=https%3A%2F%2Fwww.google.com%2Famp%2Fs%2Fwww.nytimes.com%2Fwirecutter%2Freviews%2Fbest-standing-desk%2Famp%2F%253f0p19G%3D0232&history=1&storage=1&cid=1&cap=navigateTo%2Ccid%2CfullReplaceHistory%2Cfragment%2CreplaceUrl%2CiframeScroll",
        "data:text/html;charset=utf-8;base64,PGltZyBzcmM9Imh0dHBzOi8vd3d3LmJldDM2NS5jb20vZmF2aWNvbi5pY28iPg=="
    ]
    
    override func setUp() {
        shield = .init()
    }
    
    func test() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = list.count
        list.forEach { url in
            shield.policy(for: URL(string: url)!, shield: true).sink {
                if case .allow = $0 {
                    expect.fulfill()
                } else {
                    XCTFail(url)
                }
            }.store(in: &subs)
        }
        waitForExpectations(timeout: 1)
    }
}
