package dough.system;

class Time {
    public static function frameTime():Float {
        return Application.instance.system.getFrameTime();
    }

    public static function fps():Int {
        return -1;
    }
}
