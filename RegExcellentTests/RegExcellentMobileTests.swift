
import XCTest
import RegExcellent

class RegExcellentMobileTests: XCTestCase {

    func testExampBasicCharacterClass() {
        let regex = Regex(
            oneOf("a","e")
        )
        XCTAssertEqual(regex.expression, "[ae]")
    }

    func testExampBasicCharacterClassRange() {
        let regex = Regex(
            oneOf(
                CharacterRange.allNumbers,
                CharacterRange.from("a", to: "f"),
                CharacterRange.from("A", to: "F")
            )
        )
        XCTAssertEqual(regex.expression, "[0-9a-fA-F]")
    }

    func testExampAdvancedCharacterClassRange() {
        let regex = Regex(
            oneOf(
                CharacterRange.allNumbers,
                CharacterRange.from("a", to: "f"),
                "x",
                CharacterRange.from("A", to: "F"),
                "X"
            )
        )
        XCTAssertEqual(regex.expression, "[0-9a-fxA-FX]")
    }

    func testCharacterClassInLiteral() {
        let regex = Regex(
            "gr", oneOf("a","e"), "y"
        )
        XCTAssertEqual(regex.expression, "gr[ae]y")
    }

    func testCharacterClassWithRepeater() {
        let regex = Regex(
            oneOf(CharacterRange.allNumbers).repeated(.oneOrMore)
        )
        XCTAssertEqual(regex.expression, "[0-9]+")
    }

    func testCharacterClassWithSpaceAndNumber() {
        let regex = Regex(
            oneOf(Shorthand.whitespace, Shorthand.digit)
        )
        XCTAssertEqual(regex.expression, "[\\s\\d]")
    }

    func testCharacterClassNotWhitespace() {
        let regex = Regex(
            noneOf(Shorthand.whitespace)
        )
        XCTAssertEqual(regex.expression, "[^\\s]")
    }

    func testDigit() {
        let regex = Regex(
            StartAnchor(
                EndAnchor(
                    Shorthand.digit.repeated(.oneOrMore)
                )
            )
        )
        XCTAssertEqual(regex.expression, "^\\d+$")
    }

    func testLeadingWhitespace() {
        let regex = Regex(
            StartAnchor(
                Shorthand.whitespace.repeated(.oneOrMore)
            )
        )
        XCTAssertEqual(regex.expression, "^\\s+")
    }

    func testTrailingWhitespace() {
        let regex = Regex(
            EndAnchor(
                Shorthand.whitespace.repeated(.oneOrMore)
            )
        )
        XCTAssertEqual(regex.expression, "\\s+$")
    }

    func testWordBoundedAlternatingGrouping() {
        let regex = Regex(
            Shorthand.wordBoundary,
            Group(Alternatives("cat", "dog")),
            Shorthand.wordBoundary
        )
        XCTAssertEqual(regex.expression, "\\b(cat|dog)\\b")
    }

    func testGetSetValueExample() {
        let regex = Regex(
            Shorthand.wordBoundary,
            Group(
                Alternatives(
                    Regex("Get",Group("Value", repeater: .zeroOrOne)),
                    Regex("Set",Group("Value", repeater: .zeroOrOne))
                )
            ),
            Shorthand.wordBoundary
        )
        XCTAssertEqual(regex.expression, "\\b(Get(Value)?|Set(Value)?)\\b")
    }

    func testReferencingGroup1() {
        let regex = Regex(
            Group(oneOf(CharacterRange.from("a", to: "c"))),
            "x",
            Backreference(1),
            "x",
            Backreference(1)
        )
        XCTAssertEqual(regex.expression, "([a-c])x\\1x\\1")
    }

    func testAtMentionRegexCreation() {
        let regex = Regex(
            Shorthand.notWordBoundary,
            "@",
            oneOf(Shorthand.wordCharacter).repeated(.zeroOrMore)
        )
        XCTAssertEqual(regex.expression, "\\B@[\\w]*")
    }

    func testWhitespaceLookup() {
        let regex = Regex(
            StartAnchor(oneOf(" ", "\t").repeated(.oneOrMore))
        )
        XCTAssertEqual(regex.expression, "^[ \t]+")
    }

    func testWhitespaceLookupEitherEnd() {
        let regex = Regex(
            Alternatives(
                StartAnchor(oneOf(" ", "\t").repeated(.oneOrMore)),
                EndAnchor(oneOf(" ", "\t").repeated(.oneOrMore))
            )
        )
        XCTAssertEqual(regex.expression, "^[ \t]+|[ \t]+$")
    }

    func testUsernameMatch() {
        let regex = Regex(
            StartAnchor(EndAnchor(
                oneOf(
                    CharacterRange.allLowercaseLetters,
                    CharacterRange.allNumbers,
                    "_", "-"
                ).repeated(.numberBetween(min: 3, max: 16))
            ))
        )
        XCTAssertEqual(regex.expression, "^[a-z0-9_-]{3,16}$")
    }

    func testGeneration() {
        let regex = try! Regex(
            StartAnchor(
                EndAnchor(
                    Shorthand.digit.repeated(.oneOrMore)
                )
            )
        ).generate()
        XCTAssertEqual(regex.firstMatch(in: "1234", options: [], range: NSMakeRange(0, 4))?.range.location, 0)
    }

}
