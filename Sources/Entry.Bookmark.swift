import Foundation
import Archivable

extension Entry {
    enum Bookmark: Equatable, Property {
        case
        remote(String),
        local(String, Data)
        
        var url: String {
            switch self {
            case let .remote(url), let .local(url, _):
                return url
            }
        }
        
        var data: Data {
            Data()
                .adding(UInt16(id))
        }
        
        init(data: inout Data) {
            self = .remote(.init(data.uInt16()), .init(url: "", title: ""))
        }
        
        init(url: String) {
            
        }
    }
}
