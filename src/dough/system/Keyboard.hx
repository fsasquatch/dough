package dough.system;

class Keyboard {
    public static function isKeyDown(key:Keys) {
        Application.instance.system.isKeyDown(key);
    }

    public static function isKeyJustDown(key:Keys) {
        Application.instance.system.isKeyJustDown(key);
    }

    public static function isKeyReleased(key:Keys) {
        Application.instance.system.isKeyReleased(key);
    }
}
