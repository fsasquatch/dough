package dough.system;

// TODO: Mouse pos delta
class Mouse {
    public static function isButtonDown(button:MouseButtons) {
        Application.instance.system.isMouseButtonDown(button);
    }

    public static function isButtonJustDown(button:MouseButtons) {
        Application.instance.system.isMouseButtonJustDown(button);
    }

    public static function isButtonReleased(button:MouseButtons) {
        Application.instance.system.isMouseButtonReleased(button);
    }

    public static function getPositionX():Float {
        return Application.instance.system.getMousePositionX();
    }

    public static function getPositionY():Float {
        return Application.instance.system.getMousePositionY();
    }

    public static function getWheelMovementX():Float {
        return Application.instance.system.getMouseWheelMovementX();
    }

    public static function getWheelMovementY():Float {
        return Application.instance.system.getMouseWheelMovementY();
    }
}
