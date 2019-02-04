
public protocol Alternatable: RegexElement {}

public struct Alternatives: RegexElement {

    let alternatives: [RegexElement]

    public init(_ alternatives: RegexElement...) {
        self.alternatives = alternatives
    }

    public var regexStringValue: String {
        return alternatives.map { $0.regexStringValue }.joined(separator: "|")
    }

}
