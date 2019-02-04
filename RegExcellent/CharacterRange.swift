
import Foundation

public enum CharacterRange: CharacterClassElement, RegexElement {

    case allUppercaseLetters
    case allLowercaseLetters
    case allNumbers
    case from(Character, to: Character)

    public var characterClassStringValue: String {
        switch self {
        case .allUppercaseLetters: return "A-Z"
        case .allLowercaseLetters: return "a-z"
        case .allNumbers: return "0-9"
        case let .from(start, end): return "\(start)-\(end)"
        }
    }

    public var regexStringValue: String { return characterClassStringValue }

}



public enum Shorthand: String, CharacterClassElement, RegexElement {

    case digit = "\\d" // [0-9]
    case wordCharacter = "\\w" // [A-Za-z0-9_]
    case whitespace = "\\s" // [ \t\r\n\f]
    case wordBoundary = "\\b" // the boundary on a word
    case notWordBoundary = "\\B" // the negation of a word boundary

    public var characterClassStringValue: String { return rawValue }
    public var regexStringValue: String { return rawValue }

}
