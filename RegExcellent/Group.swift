
public protocol Groupable: RegexElement {}

public struct Group: RegexElement {

    let groupedElement: Groupable
    let repeater: Repeater?

    public init(_ groupedElement: Groupable, repeater: Repeater? = nil) {
        self.groupedElement = groupedElement
        self.repeater = repeater
    }

    public var regexStringValue: String {
        let repeaterString = repeater?.regexStringValue ?? ""
        return "(\(groupedElement.regexStringValue))\(repeaterString)"
    }

}

extension Alternatives: Groupable {}
extension String: Groupable {}
extension CharacterClass: Groupable {}
