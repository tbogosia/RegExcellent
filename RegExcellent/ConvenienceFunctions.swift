
public func oneOf(_ options: CharacterClassElement...) -> CharacterClass {
    return CharacterClass(options)
}

public func noneOf(_ options: CharacterClassElement...) -> CharacterClass {
    return CharacterClass(options, negated: true)
}
