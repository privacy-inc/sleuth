import Foundation
import Combine

public final class Browser {
    public let page = CurrentValueSubject<Page?, Never>(nil)
    public let error = CurrentValueSubject<String?, Never>(nil)
    public let backwards = CurrentValueSubject<Bool, Never>(false)
    public let forwards = CurrentValueSubject<Bool, Never>(false)
    public let loading = CurrentValueSubject<Bool, Never>(false)
    public let progress = CurrentValueSubject<Double, Never>(0)
    public let browse = PassthroughSubject<URL, Never>()
    public let previous = PassthroughSubject<Void, Never>()
    public let next = PassthroughSubject<Void, Never>()
    public let reload = PassthroughSubject<Void, Never>()
    public let stop = PassthroughSubject<Void, Never>()
    private var subscription: AnyCancellable?
    
    public init() {
        subscription = page.debounce(for: .seconds(1), scheduler: DispatchQueue.main).sink {
            $0.map(FileManager.save)
        }
    }
}
