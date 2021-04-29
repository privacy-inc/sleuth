import Foundation

extension URL {
    var bookmark: Data {
        (try? bookmarkData(options: .withSecurityScope)) ?? .init()
    }
    
    var schemeless: String {
        scheme == nil ? absoluteString : .init(absoluteString.dropFirst(scheme!.count + 3))
    }
}
