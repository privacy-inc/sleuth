import Foundation
import Combine

public final class Favicon {
    public let icons = CurrentValueSubject<[String : Data], Never>([:])
    private var subs = Set<AnyCancellable>()
    private let queue = DispatchQueue(label: "", qos: .utility)
    
    private lazy var path: URL = {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("icons")
        
        if !FileManager.default.fileExists(atPath: url.path) {
            var resources = URLResourceValues()
            resources.isExcludedFromBackup = true
            try? url.setResourceValues(resources)
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        
        return url
    } ()
    
    public func load(domain: String) {
        
    }
    
    public func save(domain: String, url: String) {
        URL(string: url)
            .map {
                URLSession
                    .shared
                    .dataTaskPublisher(for: $0)
                    .map(\.data)
                    .receive(on: queue)
                    .replaceError(with: .init())
                    .filter {
                        !$0.isEmpty
                    }
                    .sink {
                        self.save(domain: domain, data: $0)
                    }
                    .store(in: &subs)
            }
    }
    
    func save(domain: String, data: Data) {
        try? data.write(to: path.appendingPathComponent(domain), options: .atomic)
        DispatchQueue
            .main
            .async {
                self.icons.value[domain] = data
            }
    }
}
