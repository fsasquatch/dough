package dough.backend;

interface SystemApi {
    public function createWindow(width:Int, height:Int, title:String):Int;
    public function destroyWindow(window:Int):Void;
    public function isWindowRunning(window:Int):Bool;
    public function getWindowWidth(window:Int):Int;
    public function getWindowHeight(window:Int):Int;
    public function setWindowSize(window:Int, w:Int, h:Int):Bool;
    public function getWindowX(window:Int):Int;
    public function getWindowY(window:Int):Int;
    public function setWindowPosition(window:Int, w:Int, h:Int):Bool;
    public function getCurrentDisplay(window:Int):Int;
    public function setCurrentDisplay(window:Int, display:Int):Bool;
    public function getPrimaryDisplay():Int;
    public function isWindowFullscreen(window:Int):Bool;
    public function toggleFullscreen(window:Int, borderless:Bool):Bool;
    public function isWindowMinimized(window:Int):Bool;
    public function minimizeWindow(window:Int):Bool;
    public function isWindowMaximized(window:Int):Bool;
    public function maximizeWindow(window:Int):Bool;
    public function restoreWindow(window:Int):Bool;
    public function raiseWindow(window:Int):Bool;
    public function isWindowResizable(window:Int):Bool;
    public function setWindowResizable(window:Int, resizable:Bool):Bool;
    public function wasWindowResized(window:Int):Bool;
    public function isWindowFocused(window:Int):Bool;
    public function focusWindow(window:Int):Bool;
    public function pollWindowEvents():Bool;
    public function handleWindowEvents(window:Int):Void;

    public function showCursor():Void;
    public function hideCursor():Void;
    public function lockCursor(window:Int):Void;
    public function unlockCursor(window:Int):Void;

    public function setClipboardText(text:String):Void;
    public function getClipboardText():String;

    public function getFrameTime():Float;
    public function getElapsedTime():Float;
   
    public function loadBytes(file:String):haxe.io.Bytes;
    public function loadText(file:String):String;
    public function writeBytes(file:String, content:haxe.io.Bytes):Void;
    public function writeText(file:String, content:String):Void;

    public function listFileEntries(location:String):Array<String>;
    public function fileExists(file:String):Bool;
    public function isDirectory(entry:String):Bool;

    public function isKeyDown(key:Int):Bool;
    public function isKeyJustDown(key:Int):Bool;
    public function isKeyReleased(key:Int):Bool;

    public function isGamepadAvailable(gamepad:Int):Bool;
    public function getGamepadName(gamepad:Int):String;
    public function isGamepadButtonDown(gamepad:Int, button:Int):Bool;
    public function isGamepadButtonJustDown(gamepad:Int, button:Int):Bool;
    public function isGamepadButtonReleased(gamepad:Int, button:Int):Bool;
    public function getGamepadAxisCount(gamepad:Int):Int;
    public function getGamepadAxisMovement(gamepad:Int, axis:Int):Float;
    public function setGamepadVibration(gamepad:Int, leftMotor:Float, rightMotor:Float, durationSec:Float):Void;

    public function isMouseButtonDown(button:Int):Bool;
    public function isMouseButtonJustDown(button:Int):Bool;
    public function isMouseButtonReleased(button:Int):Bool;

    public function getMousePositionX():Int;
    public function getMousePositionY():Int;
    public function setMousePosition(window:Int, x:Int, y:Int):Void;
    public function getMouseWheelMovementX():Float;
    public function getMouseWheelMovementY():Float;
    public function setMouseCursor(cursor:Int):Void;
}
