package dough.system;

class Keyboard {
    public static function isKeyDown(key:Keys):Bool {
        return Application.instance.system.isKeyDown(key);
    }

    public static function isKeyJustDown(key:Keys):Bool {
        return Application.instance.system.isKeyJustDown(key);
    }

    public static function isKeyReleased(key:Keys):Bool {
        return Application.instance.system.isKeyReleased(key);
    }
}
