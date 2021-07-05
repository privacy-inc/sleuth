import Foundation



private let directory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
private let def = directory.appendingPathComponent("Sources/Tld.swift")
private let suffix = directory.appendingPathComponent("Sources/Tld.Suffix.swift")
private let dat = directory.appendingPathComponent("Tests/Tld.public_suffix_list.dat")

private var tlds = Set<String>()
private var chain = [String : [Any]]()




//private struct Parser {
//
//
//
//
//
//    init() {
//        dictionary = Translations.url.asLines.filter {
//            $0.hasPrefix("case")
//        }.reduce(into: [:]) {
//            let equals = $1.components(separatedBy: " = \"")
//            $0[.init(equals.first!.dropFirst(5))] = .init(equals.last!.dropLast())
//        }
//    }
//
//    func save() {
//        let result = dictionary.keys.sorted().reduce(into: header) {
//            $0 += prefix + $1 + " = \"" + dictionary[$1]! + "\"\n"
//        } + footer
//
//        try! Data(result.utf8).write(to: Translations.url, options: .atomic)
//
//        print("\(dictionary.count) String Keys sorted!")
//    }
//}
//


private let header = """
import Foundation

extension String {
    static func localized(_ forKey: Key) -> String {
        localized(forKey.rawValue)
    }
    
    static func localized(_ string: String) -> String {
        NSLocalizedString(string, comment: "")
    }
    
    enum Key: String {

"""

private let footer = """
    }
}

"""

private let prefix = "        case "
