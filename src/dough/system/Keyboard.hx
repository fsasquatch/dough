package dough.system;

class Keyboard {
    public static function isDown(key:Keys):Bool {
        return Application.instance.system.isKeyDown(key);
    }

    public static function isJustDown(key:Keys):Bool {
        return Application.instance.system.isKeyJustDown(key);
    }

    public static function isReleased(key:Keys):Bool {
        return Application.instance.system.isKeyReleased(key);
    }
}
