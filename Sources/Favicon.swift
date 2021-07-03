import Foundation
import Combine

public struct Favicon {
    private let queue = DispatchQueue(label: "", qos: .utility)
    
    public func get(domain: String) -> Future<Data, Never> {
        .init { promise in
            queue
                .async {
                    
                }
        }
    }
}
