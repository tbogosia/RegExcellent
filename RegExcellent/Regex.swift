
import Foundation

public struct Regex: RegexElement, CustomStringConvertible {

    public let expression: String

    public init(_ expressionElements: RegexElement...) {
        self.expression = expressionElements.map { $0.regexStringValue }.joined()
    }

    public var regexStringValue: String { return expression }

    public var description: String { return expression }

    public func generate(options: NSRegularExpression.Options = []) throws -> NSRegularExpression {
        return try NSRegularExpression(pattern: expression, options: options)
    }

}

public protocol RegexElement: CustomStringConvertible {

    var regexStringValue: String { get }

}

public extension RegexElement {

    public var description: String { return regexStringValue }

}
