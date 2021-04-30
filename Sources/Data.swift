import Foundation

public extension Data {
    #if os(iOS) || os(macOS)
    
    var url: URL? {
        var stale = false
        return (try? URL(resolvingBookmarkData: self, options: .withSecurityScope, bookmarkDataIsStale: &stale))
            .flatMap {
                $0.startAccessingSecurityScopedResource() ? $0 : nil
            }
    }
    
    #else
    
    var url: URL? {
        nil
    }
    
    #endif
}
