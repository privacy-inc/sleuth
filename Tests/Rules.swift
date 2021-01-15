import Foundation

final class Rules {
    private let dictionary: [[String : [String : Any]]]
    
    init(content: String) {
        dictionary = (try! JSONSerialization.jsonObject(with: .init(content.utf8))) as! [[String : [String : Any]]]
    }
    
    func block(domain: String, url: String = ".*") -> Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "block"
            && ($0["trigger"]!["url-filter"] as! String) == url
            && ($0["trigger"]!["if-domain"] as! [String]).first == domain
        }
    }
    
    func remove(domain: String, selector: String) -> Bool {
        dictionary.contains {
            ($0["action"]!["type"] as! String) == "css-display-none"
            && ($0["action"]!["selector"] as! String) == selector
            && ($0["trigger"]!["url-filter"] as! String) == ".*"
            && ($0["trigger"]!["if-domain"] as! [String]).first == domain
        }
    }
}
