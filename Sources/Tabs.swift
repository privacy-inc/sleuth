import Foundation
import Combine

public final class Tabs {
    public let tabs = CurrentValueSubject<[Page], Never>([])
    public let selected = CurrentValueSubject<Page?, Never>(nil)
    
    public init() { }
}
