import Foundation

extension URL {
#if os(iOS) || os(macOS)
    var bookmark: Data {
        (try? bookmarkData(options: .withSecurityScope)) ?? .init()
    }
#else
    var bookmark: Data {
        .init()
    }
#endif
    
    var schemeless: String {
        scheme == nil ? absoluteString : .init(absoluteString.dropFirst(scheme!.count + 3))
    }
}
