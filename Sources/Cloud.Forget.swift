import Foundation
import Archivable

extension Cloud where A == Archive {
    public func forget() {
        mutating {
            $0.browse = []
            $0.activity = []
            $0.blocked = [:]
            $0.counter = 0
        }
    }
    
    public func forgetBrowse() {
        mutating {
            $0.browse = []
            $0.counter = 0
        }
    }
    
    public func forgetActivity() {
        mutating {
            $0.activity = []
        }
    }
    
    public func forgetBlocked() {
        mutating {
            $0.blocked = [:]
        }
    }
}
