
public struct StartAnchor: RegexElement {

    let element: RegexElement?

    public init(_ element: RegexElement? = nil) {
        guard !(element is StartAnchor) else { fatalError("Cannot nest start anchor in start anchor") }
        self.element = element
    }

    public var regexStringValue: String {
        let elementString = element?.regexStringValue ?? ""
        return "^\(elementString)"
    }

}
