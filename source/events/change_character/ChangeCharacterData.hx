package events.change_character;

import data.CharacterPosition;

// ChangeCharacter.getEventSchema
typedef ChangeCharacterData = {
    charPos:CharacterPosition,
    newCharId:String,
    xOffset:Float,
    yOffset:Float,
    xCameraOffset:Float,
    yCameraOffset:Float,
    changeIcon:Bool,
    antialiasing:Bool
}
