package events.change_character;

// funkin
import funkin.data.song.SongData.SongEventData;
import funkin.data.event.SongEventSchema;
import funkin.play.event.SongEvent;
import funkin.data.character.CharacterData.CharacterDataParser;

// haxe
import haxe.ds.StringMap;

class ChangeCharacter extends SongEvent {
    public function new(?id:String) {
        super(id == null ? SuilNamingUtil.getSuildId("change-character") : id);
    }

    public override function handleEvent(data:SongEventData) {
        super.handleEvent(data);
    }

    private static var charIds:Null<StringMap<String>> = null;
    public override function getEventSchema():Null<SongEventSchema> {
        if(charIds == null) {
            charIds = new StringMap();
            var ids:Array<String> = CharacterDataParser.listCharacterIds();

            for(id in ids) {
                charIds.set(id, id);
            }
        }

        return new SongEventSchema([
            {
                title: "Character Position",
                name: "char-pos",
                type: ENUM,
                keys: [
                    "Boyfriend" => "bf",
                    "Daddy" => "dad",
                    "Girlfriend" => "gf"
                ],
                defaultValue: "bf"
            },
            {
                title: "New Character ID",
                name: "new-char-id",
                type: ENUM,
                keys: charIds,
                defaultValue: "bf"
            },
            {
                title: "Offsets",
                name: "offsets",
                type: FRAME,
                collapsible: true,
                children: [
                    {
                        title: "X Offset",
                        name: "x-offset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    },
                    {
                        title: "Y Offset",
                        name: "Y-offset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    },
                    {
                        title: "Camera X Offset",
                        name: "camera-x-offset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    },
                    {
                        title: "Camera Y Offset",
                        name: "Camera Y-offset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    }
                ]
            },
            {
                title: "Advance",
                name: "advance",
                type: FRAME,
                collapsible: true,
                children: [
                    {
                        title: "Change Icon",
                        name: "change-icon",
                        type: BOOL,
                        defaultValue: true
                    },
                    {
                        title: "Anti-Aliasing",
                        name: "anti-aliasing",
                        type: BOOL,
                        defaultValue: true
                    }
                ]
            }
        ]);
    }

    public override function getTitle():String {
        return SuilNamingUtil.getSuildTitle("Change Character");
    }
}
