import Foundation

extension Array where Element == Browse {
    public func filter(_ string: String) -> [Filtered] {
        {
            {
                $0
                    .prefix(3)
                    .map(\.page)
                    .map(Filtered.init(page:))
            } (string
                .isEmpty
                ? $0
                : $0.filter {
                    $0.page.title.localizedCaseInsensitiveContains(string)
                        || $0.page.access.string.localizedCaseInsensitiveContains(string)
                })
        } (filter(\.page.access.isRemote))
    }
}
