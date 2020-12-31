import Foundation
import Combine

public protocol Browser {
    var browse: PassthroughSubject<URL, Never> { get }
    var previous: PassthroughSubject<Void, Never> { get }
    var next: PassthroughSubject<Void, Never> { get }
    var reload: PassthroughSubject<Void, Never> { get }
    var stop: PassthroughSubject<Void, Never> { get }
    
    mutating func progress(_ value: Double)
    mutating func loading(_ value: Bool)
    mutating func title(_ value: String)
    mutating func url(_ value: URL)
    mutating func backwards(_ value: Bool)
    mutating func forwards(_ value: Bool)
    mutating func error(_ value: String?)
    mutating func popup(_ url: URL)
    mutating func external(_ url: URL)
    mutating func blocked(_ domain: String)
}
