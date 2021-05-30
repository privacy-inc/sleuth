import Foundation

extension Array where Element == Browse {
    public func filter(_ string: String) -> [Filtered] {
        .init(Set(filter(\.page.access.isRemote)
                    .filter {
                        $0.page.title.localizedCaseInsensitiveContains(string)
                            || $0.page.access.string.localizedCaseInsensitiveContains(string)
                    }
                    .sorted {
                        $0.date < $1.date
                    }
                    .map(\.page)
                    .map(Filtered.init(page:)))
                .prefix(3))
    }
}
