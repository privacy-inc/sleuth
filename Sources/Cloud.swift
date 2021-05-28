import Foundation
import Archivable

extension Cloud where A == Archive {
    public static var new: Self {
        .init(manifest: .init(
                file: "Privacy.archive",
                container: "iCloud.privacy",
                prefix: "privacy_",
                title: "Privacy"))
    }
}
