package dough.system;

class Mouse {
    public static function isMouseButtonDown(button:MouseButtons) {
        Application.instance.system.isMouseButtonDown(button);
    }

    public static function isMouseButtonJustDown(button:MouseButtons) {
        Application.instance.system.isMouseButtonJustDown(button);
    }

    public static function isMouseButtonReleased(button:MouseButtons) {
        Application.instance.system.isMouseButtonReleased(button);
    }
}
