import Foundation
import Combine

public protocol Browser {
    var progress: Double { get set }
    var loading: Bool { get set }
    var title: String { get set }
    var url: URL { get set }
    var backwards: Bool { get set }
    var forwards: Bool { get set }
    var error: String? { get set }
    var browse: PassthroughSubject<URL, Never> { get }
    var previous: PassthroughSubject<Void, Never> { get }
    var next: PassthroughSubject<Void, Never> { get }
    var reload: PassthroughSubject<Void, Never> { get }
    var stop: PassthroughSubject<Void, Never> { get }
    
    func popup(_ url: URL)
    func external(_ url: URL)
    func blocked(_ domain: String)
}
