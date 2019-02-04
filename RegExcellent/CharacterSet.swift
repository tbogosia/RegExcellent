
public protocol CharacterClassElement {

    var characterClassStringValue: String { get }

}

public struct CharacterClass: RegexElement {

    public let regexStringValue: String

    public init(_ options: [CharacterClassElement], negated: Bool = false) {
        // TODO: add support for ^ (i.e. add character as second to last character) and ] (must be first character)
        let negationValue = negated ? "^" : ""
        let optionValues = options.map { $0.characterClassStringValue }
        regexStringValue = "[\(negationValue)\(optionValues.joined())]"
    }

}

extension String: CharacterClassElement {

    public var characterClassStringValue: String {
        guard count == 1 else {
            assertionFailure("Bad character set element input \(self), expected a single character")
            return ""
        }

        return String(self)
    }

}
