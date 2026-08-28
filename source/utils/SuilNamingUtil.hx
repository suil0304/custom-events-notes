package utils;

import flixel.FlxG;

using StringTools;

final class SuilNamingUtil {
    private static inline final ID_PREFIX = "suils";
    private static inline final TITLE_PREFIX = "[suil's]";

    /**
     * string to suil'd id.
     * @param str your own string.
     * @return String
     */
    public static function getSuildId(str:String):String {
        var idLike:String = getIdLikeString(str);

        if(idLike == ID_PREFIX) {
            throw "are you seriously?";
        }

        if(idLike.startsWith('${ID_PREFIX}-')) {
            FlxG.log.warn('Your id\'s prefix is already ${ID_PREFIX}');
            return idLike;
        }

        return '${ID_PREFIX}-${idLike}';
    }

    private static final INVALID_REGEX = ~/[\\s`~!@#$%^&*()_+=\[\]{};:'",.<>?\/|\\]/g;

    private static function getIdLikeString(str:String):String {
        var newStr:String = str.trim().toLowerCase();

        return INVALID_REGEX.replace(newStr, "-");
    }

    /**
     * string to suil'd title.
     * @param str your own string.
     * @return String
     */
    public static function getSuildTitle(str:String) {
        if(str == TITLE_PREFIX) {
            throw "are you seriously?";
        }

        if(str.startsWith('${TITLE_PREFIX} ')) {
            FlxG.log.warn('Your title\'s prefix is already ${TITLE_PREFIX}');
            return str;
        }

        return '${TITLE_PREFIX} ${str}';
    }
}
