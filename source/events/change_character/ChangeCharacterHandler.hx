package events.change_character;

// suil
import interfaces.IEventHandleable;
import events.change_character.ChangeCharacterData;

// funkin
import funkin.play.character.BaseCharacter;
import funkin.play.PlayState;
import funkin.data.character.CharacterData.CharacterDataParser;
import funkin.modding.events.ScriptEvent;
import funkin.modding.module.Module;

// haxeflixel
import flixel.FlxG;

// haxe
import haxe.ds.StringMap;

class ChangeCharacterHandler extends Module implements IEventHandleable<ChangeCharacterData> {
    public function new() {
        super(SuilNamingUtil.getSuildId("change-character-handler"));
    }

    public function handleEvent(data:ChangeCharacterData) {
        var char:BaseCharacter = cast charCache.get(data.newCharId);
        PlayState.instance.currentStage.addCharacter(char, data.charPos);

        char.x += data.xOffset;
        char.y += data.yOffset;

        char.cameraFocusPoint.x += data.xCameraOffset;
        char.cameraFocusPoint.y += data.yCameraOffset;
    }

    public var charIds(default, null):StringMap<String>;
    override function onCreate(event:ScriptEvent) {
        if(charIds == null) {
            charIds = new StringMap();

            var ids:Array<String> = CharacterDataParser.listCharacterIds();

            for(id in ids) {
                charIds.set(id, id);
            }
        }

        charCache = new StringMap();

        super.onCreate(event);
    }

    // When song loading, this will cache change character events' new character;
    private var charCache:StringMap<BaseCharacter>;
    override function onSongLoaded(event:SongLoadScriptEvent) {
        var curEvents = PlayState.instance.currentChart.getEvents();

        for(eventData in curEvents) {
            if(eventData.eventKind != "change-character") {
                continue;
            }

            var newCharId:String = EventUtil.getAutoTypedEventProperty(eventData, "newCharId", ENUM, "bf");

            if(charCache.exists(newCharId)) {
                continue;
            }

            var charData = CharacterDataParser.fetchCharacterData(newCharId);
            if(charData == null) {
                FlxG.log.warn('${newCharId} is null');
                continue;
            }

            charCache.set(newCharId, CharacterDataParser.fetchCharacter(newCharId));
        }

        super.onSongLoaded(event);
    }

    override function onSongEnd(event:ScriptEvent) {
        for(char in charCache.iterator()) {
            char.destroy();
        }

        charCache.clear();

        super.onSongEnd(event);
    }

    override function onDestroy(event:ScriptEvent) {
        charIds.clear();
        charIds = null;

        charCache.clear();
        charCache = null;

        super.onDestroy(event);
    }
}
