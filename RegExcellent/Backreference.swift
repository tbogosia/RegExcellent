
public struct Backreference: RegexElement {

    public let referenceGroupNumber: Int

    public init(_ referenceGroupNumber: Int) {
        self.referenceGroupNumber = referenceGroupNumber
    }

    public var regexStringValue: String {
        return "\\\(referenceGroupNumber)"
    }

}
