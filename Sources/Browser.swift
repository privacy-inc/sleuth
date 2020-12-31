import Foundation
import Combine

public protocol Browser {
    var browse: PassthroughSubject<URL, Never> { get }
    var previous: PassthroughSubject<Void, Never> { get }
    var next: PassthroughSubject<Void, Never> { get }
    var reload: PassthroughSubject<Void, Never> { get }
    var stop: PassthroughSubject<Void, Never> { get }
    
    func progress(_ value: Double)
    func loading(_ value: Bool)
    func title(_ value: String)
    func url(_ value: URL)
    func backwards(_ value: Bool)
    func forwards(_ value: Bool)
    func error(_ value: String?)
    func popup(_ url: URL)
    func external(_ url: URL)
    func blocked(_ domain: String)
}
