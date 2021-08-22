import Archivable

extension Cloud where A == Archive {
    public static var new: Self {
        .init(manifest: .init(
                file: "Privacy",
                container: "iCloud.privacy",
                prefix: "privacy_"))
    }
}
