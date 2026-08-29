package events.change_character;

// suil
import events.EventHandlerOwner;
import events.change_character.ChangeCharacterHandler;
import data.CharacterPosition;

// funkin
import funkin.data.song.SongData.SongEventData;
import funkin.data.event.SongEventSchema;
import funkin.modding.module.ModuleHandler;

class ChangeCharacter extends EventHandlerOwner<ChangeCharacterData, ChangeCharacterHandler> {
    public function new(?id:String) {
        super(id == null ? SuilNamingUtil.getSuildId("change-character") : id);

        handler = cast ModuleHandler.getModule(SuilNamingUtil.getSuildId("change-character-handler"));
    }

    public override function handleEvent(data:SongEventData) {
        handler.handleEvent(EventUtil.getAutoSchemaEventProperties(data, getEventSchema()));
    }

    public override function getEventSchema():Null<SongEventSchema> {
        return new SongEventSchema([
            {
                title: "Character Position",
                name: "charPos",
                type: ENUM,
                keys: [
                    "Boyfriend" => CharacterPosition.BF,
                    "Daddy" => CharacterPosition.DAD,
                    "Girlfriend" => CharacterPosition.GF
                ],
                defaultValue: CharacterPosition.BF
            },
            {
                title: "New Character ID",
                name: "newCharId",
                type: ENUM,
                keys: handler.charIds,
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
                        name: "xOffset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    },
                    {
                        title: "Y Offset",
                        name: "yOffset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    },
                    {
                        title: "Camera X Offset",
                        name: "xCameraOffset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    },
                    {
                        title: "Camera Y Offset",
                        name: "yCameraOffset",
                        type: FLOAT,
                        step: 0.01,
                        defaultValue: 0.0
                    }
                ]
            }
        ]);
    }

    public override function getTitle():String {
        return SuilNamingUtil.getSuildTitle("Change Character");
    }
}
