import Foundation

extension Ads {
    enum Wildcard: String, CaseIterable {
        case
        googlesyndication = ".*googlesyndication.com",
        adsystem = ".*adsystem.com",
        doubleclick = ".*doubleclick.net"
    }
}
