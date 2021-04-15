import XCTest
import Sleuth

final class AllowTests: XCTestCase {
    private let list = [
        "https://www.ecosia.org",
        "https://www.theguardian.com/email/form/footer/today-uk",
        "https://uk.reuters.com/",
        "https://www-nytimes-com.cdn.ampproject.org/v/s/www.nytimes.com/wirecutter/reviews/best-standing-desk/amp/?0p19G=0232&amp_js_v=0.1&usqp=mq331AQHKAFQCrABIA%3D%3D#origin=https%3A%2F%2Fwww.google.com&prerenderSize=1&visibilityState=prerender&paddingTop=32&p2r=0&csi=1&aoh=16025117842518&viewerUrl=https%3A%2F%2Fwww.google.com%2Famp%2Fs%2Fwww.nytimes.com%2Fwirecutter%2Freviews%2Fbest-standing-desk%2Famp%2F%253f0p19G%3D0232&history=1&storage=1&cid=1&cap=navigateTo%2Ccid%2CfullReplaceHistory%2Cfragment%2CreplaceUrl%2CiframeScroll",
        "data:text/html;charset=utf-8;base64,PGltZyBzcmM9Imh0dHBzOi8vd3d3LmJldDM2NS5jb20vZmF2aWNvbi5pY28iPg==",
        "file:///Users/some/Downloads/index.html",
        "https://consent.yahoo.com/v2/collectConsent?sessionId=3_cc-session_d5551c9f-5d07-4428-b0f9-6e92b1c3ca4e"
    ]
    
    func testAllow() {
        list
            .map {
                ($0, Shield.policy(for: URL(string: $0)!, shield: true))
            }
            .forEach {
                if case .allow = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
