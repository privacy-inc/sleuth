import Foundation
import Combine

public final class Tab {
    public let items = CurrentValueSubject<[Item], Never>([])
    public let selected = CurrentValueSubject<Item, Never>(.init())
    
    public init() {
        items.value.append(selected.value)
    }
    
    public func new() {
        selected.value = .init()
        items.value.append(selected.value)
    }
    
    public func open(_ url: URL) {
        if selected.value.page.value == nil {
            selected.value.page.value = .init(url: url)
        }
        selected.value.browse.send(url)
    }
    
    public func close(_ item: Item) {
        items.value.removeAll { $0 === item }
        if selected.value == item {
            if let last = items.value.last {
                selected.value = last
            } else {
                new()
            }
        }
    }
}
