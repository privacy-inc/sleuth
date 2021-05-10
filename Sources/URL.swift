import Foundation

extension URL {
    static let blank = URL(string: "about:blank")!
    
#if os(macOS)

    var bookmark: Data {
        (try? bookmarkData(options: .withSecurityScope)) ?? .init()
    }

#elseif os(iOS)
    
    var bookmark: Data {
        _ = startAccessingSecurityScopedResource()
        let data = (try? bookmarkData()) ?? .init()
        stopAccessingSecurityScopedResource()
        return data
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
