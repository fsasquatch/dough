package dough.native;

@:hlNative("dough")
extern class Native {
    public static function createWindow(width:Int, height:Int, title:String, flags:Int):Int;
    public static function destroyWindow(window:Int):Void;
    public static function isWindowRunning(window:Int):Bool;
    public static function getWindowWidth(window:Int):Int;
    public static function getWindowHeight(window:Int):Int;
    public static function setWindowSize(window:Int, w:Int, h:Int):Bool;
    public static function getWindowX(window:Int):Int;
    public static function getWindowY(window:Int):Int;
    public static function setWindowPosition(window:Int, w:Int, h:Int):Bool;
    public static function getCurrentDisplay(window:Int):Int;
    public static function setCurrentDisplay(window:Int, display:Int):Bool;
    public static function getPrimaryDisplay():Int;
    public static function isWindowFullscreen(window:Int):Bool;
    public static function toggleFullscreen(window:Int, borderless:Bool):Bool;
    public static function minimizeWindow(window:Int):Bool;
    public static function maximizeWindow(window:Int):Bool;
    public static function raiseWindow(window:Int):Bool;
    public static function pollWindowEvents():Bool;
    public static function handleWindowEvents(window:Int):Void;

    public static function beginCommandBuffer():Void;
    public static function endCommandBuffer():Void;

    public static function acquireSwapchainTexture(window:Int):Void;
    public static function beginRenderPass(renderPass:Int):Void;
    public static function endRenderPass(renderPass:Int):Void;
}
