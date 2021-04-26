import Foundation
import Archivable

extension Entry {
    public struct Info: Equatable, Property {
        let url: String
        let title: String
        let date: Date
        
        public var data: Data {
            Data()
                .adding(date)
                .adding(url)
                .adding(title)
        }
        
        public init(data: inout Data) {
            date = data.date()
            url = data.string()
            title = data.string()
        }
        
        init(url: String, title: String) {
            self.url = url
            self.title = title
            date = .init()
        }
    }
}
