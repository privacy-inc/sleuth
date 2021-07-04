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
    
    public func save(domain: String, url: String) -> Future<Data, Never> {
        .init { promise in
            
        }
    }
}


/*
 
 URLSession
     .shared
     .dataTaskPublisher(for: url)
     .map(\.data)
     .receive(on: DispatchQueue.main)
     .replaceError(with: .init())
     .sink {
         NSSavePanel.save(data: $0, name: url.lastPathComponent, type: nil)
     }
     .store(in: &subs)
 
 
 var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(file)
 var resources = URLResourceValues()
 resources.isExcludedFromBackup = true
 try? url.setResourceValues(resources)
 */
