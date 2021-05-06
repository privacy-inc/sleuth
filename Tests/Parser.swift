import Foundation
import Sleuth

struct Parser {
    private let dictionary: [[String : [String : Any]]]
    
    init(blocker: Blocker) {
        dictionary = (try! JSONSerialization.jsonObject(with: .init(blocker.content.utf8))) as! [[String : [String : Any]]]
    }
    
    var cookies: Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "block-cookies"
            && ($0["trigger"]!["url-filter"] as! String) == ".*"
        }
    }
    
    var http: Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "make-https"
            && ($0["trigger"]!["url-filter"] as! String) == ".*"
        }
    }
    
    func block(domain: String) -> Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "block"
                && ($0["trigger"]!["url-filter"] as! String) == ".*"
                && ($0["trigger"]!["if-domain"] as! [String]).first == domain
        }
    }
    
    func block(url: String, on domain: String) -> Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "block"
                && ($0["trigger"]!["url-filter"] as! String) == url
                && ($0["trigger"]!["if-domain"] as! [String]).first == domain
        }
    }
    
    func displayNone(domain: String, selector: String) -> Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "css-display-none"
                && ($0["action"]!["selector"] as! String).components(separatedBy: ", ")
                .contains(selector)
                && ($0["trigger"]!["url-filter"] as! String) == ".*"
                && ($0["trigger"]!["if-domain"] as! [String]).first == domain
        }
    }
}
