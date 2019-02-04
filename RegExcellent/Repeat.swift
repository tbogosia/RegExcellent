
public struct Repeat: RegexElement {

    let element: RegexElement
    let repeatType: Repeater

    public init(_ repeatType: Repeater, _ element: RegexElement) {
        self.repeatType = repeatType
        self.element = element
    }

    public var regexStringValue: String {
        return "\(element.regexStringValue)\(repeatType.regexStringValue)"
    }

}

public enum Repeater: RegexElement {

    case zeroOrOne, zeroOrMore, oneOrMore
    case exactly(xTimes: Int)
    case atLeast(xTimes: Int)
    case minimallyAtLeast(xTimes: Int)
    case minimallyNumberBetween(min: Int, max: Int)
    case numberBetween(min: Int, max: Int)

    public var regexStringValue: String {
        switch self {
        case .zeroOrOne: return "?"
        case .zeroOrMore: return "*"
        case .oneOrMore: return "+"
        case let .exactly(numberOfMatches): return "{\(numberOfMatches)}"
        case let .atLeast(numberOfMatches): return "{\(numberOfMatches),}"
        case let .minimallyAtLeast(numberOfMatches): return "{\(numberOfMatches),}?"
        case let .numberBetween(min, max): return "{\(min),\(max)}"
        case let .minimallyNumberBetween(min, max): return "{\(min),\(max)}?u"
        }
    }

}

extension RegexElement {

    public func repeated(_ repeater: Repeater) -> Repeat {
        return Repeat(repeater, self)
    }

}
