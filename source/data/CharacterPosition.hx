package data;

import funkin.play.character.BaseCharacter.CharacterType;

enum abstract CharacterPosition(CharacterType) to CharacterType {
    var BF = CharacterType.BF;
    var DAD = CharacterType.DAD;
    var GF = CharacterType.GF;
    var OTHER = CharacterType.OTHER;

    @:from
    static function fromString(v:String):CharacterPosition {
        return switch(v) {
            case "bf": BF;
            case "dad": DAD;
            case "gf": GF;
            case "other": OTHER;
            default: throw 'Invalid character position: $v';
        }
    }

    @:to
    function toString():String {
        return switch(this) {
            case CharacterType.BF: "bf";
            case CharacterType.DAD: "dad";
            case CharacterType.GF: "gf";
            case CharacterType.OTHER: "other";
        };
    }
}
