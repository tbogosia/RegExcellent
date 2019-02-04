
//public struct Literal: RegexElement {
//
//    public let regexStringValue: String
//
//    public init(_ string: String) {
//        regexStringValue = string.regexEscaped
//    }
//
//}

extension String: RegexElement {

    public var regexStringValue: String {
        return regexEscaped
    }

    fileprivate var regexEscaped: String {
        let escapedCharacters: Set<Character> = Set(["\\","^",".","[","$","(",")","|","*","+","?","{"])
        let escapedString = map { character -> String in
            guard escapedCharacters.contains(character) else { return String(character) }
            return "\\\(character)"
            }.joined()
        return escapedString
    }

}
