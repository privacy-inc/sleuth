import Foundation
import Archivable

extension Cloud where A == Archive {
    public static var new: Self {
        .init(manifest: .init(
                file: file,
                container: "iCloud.privacy",
                prefix: "privacy_"))
    }
}

#if DEBUG
    private let file = "Privacy.debug.archive"
#else
    private let file = "Privacy.archive"
#endif
