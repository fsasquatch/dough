package dough.backend.sdl;

import dough.native.Native;

class SDLSystem implements SystemApi {
    public function new() {}

    public function createWindow(width:Int, height:Int, title:String, flags:Int):Int {
        return Native.createWindow(width, height, title, flags);
    }

    public function destroyWindow(window:Int) {
        Native.destroyWindow(window);
    }

    public function isWindowRunning(window:Int):Bool {
        return Native.isWindowRunning(window);
    }

    public function getWindowWidth(window:Int):Int {
        return Native.getWindowWidth(window);
    }

    public function getWindowHeight(window:Int):Int {
        return Native.getWindowHeight(window);
    }

    public function setWindowSize(window:Int, w:Int, h:Int):Bool {
        return Native.setWindowSize(window, w, h);
    }

    public function getWindowX(window:Int):Int {
        return Native.getWindowX(window);
    }

    public function getWindowY(window:Int):Int {
        return Native.getWindowY(window);
    }

    public function setWindowPosition(window:Int, w:Int, h:Int):Bool {
        return Native.setWindowPosition(window, w, h);
    }

    public function getCurrentDisplay(window:Int):Int {
        return Native.getCurrentDisplay(window);
    }

    public function setCurrentDisplay(window:Int, display:Int):Bool {
        return Native.setCurrentDisplay(window, display); 
    }

    public function getPrimaryDisplay():Int {
        return Native.getPrimaryDisplay();
    }

    public function isWindowFullscreen(window:Int):Bool {
        return Native.isWindowFullscreen(window);
    }

    public function toggleFullscreen(window:Int, borderless:Bool):Bool {
        return Native.toggleFullscreen(window, borderless);
    }

    public function isWindowMinimized(window:Int):Bool {
        //return Native.isWindowMinimized(window);
        return false;
    }

    public function minimizeWindow(window:Int):Bool {
        return Native.minimizeWindow(window);
    }

    public function isWindowMaximized(window:Int):Bool {
        return false;
    }

    public function maximizeWindow(window:Int):Bool {
        return Native.maximizeWindow(window);
    }

    public function raiseWindow(window:Int):Bool {
        return Native.raiseWindow(window);
    }

    public function pollWindowEvents():Bool {
        return Native.pollWindowEvents();
    }

    public function handleWindowEvents(window:Int){
        Native.handleWindowEvents(window);
    }

    public function showCursor() {
    }

    public function hideCursor() {
    }

    public function enableCursor() {
    }

    public function disableCursor() {
    }

    public function setClipboardText(text:String) {
    }

    public function getClipboardText():String {
        return "not implemented";
    }

    public function getFrameTime():Float {
        return -1;
    }

    public function getElapsedTime():Float {
        return -1;
    }
    
    public function loadBytes(file:String):haxe.io.Bytes {
        return null;
    }

    public function loadText(file:String):String {
        return null;
    }

    public function writeBytes(file:haxe.io.Bytes) {
    }

    public function writeText(file:String) {
    }

    public function listFileEntries(location:String):Array<String> {
        return null;
    }

    public function fileExists(file:String):Bool {
        return false;
    }

    public function isKeyDown(key:Int):Bool {
        return false;
    }

    public function isKeyJustDown(key:Int):Bool {
        return false;
    }

    public function isKeyReleased(key:Int):Bool {
        return false;
    }

    public function isGamepadAvailable(gamepad:Int):Bool {
        return false;
    } 

    public function getGamepadName(gamepad:Int):String {
        return "not implemented";
    }

    public function isGamepadButtonDown(gamepad:Int, button:Int):Bool {
        return false;
    }

    public function isGamepadButtonJustDown(gamepad:Int, button:Int):Bool {
        return false;
    }

    public function isGamepadButtonReleased(gamepad:Int, button:Int):Bool {
        return false;
    }

    public function getGamepadAxisCount(gamepad:Int):Int {
        return -1;
    }

    public function getGamepadAxisMovement(gamepad:Int, axis:Int):Float {
        return -1;
    }

    public function setGamepadVibration(gamepad:Int, leftMotor:Float, rightMotor:Float, durationSec:Float) {
    }

    public function isMouseButtonDown(button:Int):Bool {
        return false;
    }

    public function isMouseButtonJustDown(button:Int):Bool {
        return false;
    }

    public function isMouseButtonReleased(button:Int):Bool {
        return false;
    }

    public function getMousePositionX():Int {
        return -1;
    }

    public function getMousePositionY():Int {
        return -1;
    }

    public function setMousePosition(x:Int, y:Int) {
    }

    public function getMouseWheelMovement():Float {
        return -1;
    }

    public function setMouseCursor(cursor:Int) {
    }
}
