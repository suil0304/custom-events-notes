package utils;

import funkin.data.event.SongEventSchema;
import funkin.data.song.SongData.SongEventData;

final class EventUtil {
    public static function getAutoSchemaEventProperties(data:SongEventData, schema:SongEventSchema):Dynamic {
        return _getAutoSchemaEventPropertiesRecursive({}, data, schema);
    }

    private static function _getAutoSchemaEventPropertiesRecursive(properties:Dynamic, data:SongEventData, schema:SongEventSchema):Dynamic {
        for(field in schema.iterator()) {
            if(field.type == FRAME) {
                _getAutoSchemaEventPropertiesRecursive(properties, data, new SongEventSchema(field.children));
                continue;
            }

            Reflect.setField(properties, field.name, getAutoTypedEventProperty(data, field.name, field.type, field.defaultValue));
        }

        return properties;
    }

    public static function getAutoTypedEventProperty(data:SongEventData, name:String, type:SongEventFieldType, ?defaultValue:Dynamic):Null<Dynamic> {
        switch(type) {
            case FRAME: // actually, this is not data type.
                return defaultValue;

            case STRING, ENUM:
                return data.getString(name) ?? defaultValue;

            case BOOL:
                return data.getBool(name) ?? defaultValue;

            case INTEGER:
                return data.getInt(name) ?? defaultValue;

            case FLOAT:
                return data.getFloat(name) ?? defaultValue;
        }
    }
}
