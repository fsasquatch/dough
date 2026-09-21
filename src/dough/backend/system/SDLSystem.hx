package dough.backend.system;

import dough.system.Keys;
import sys.FileSystem;
import sys.io.File;
import dough.native.Dough;

class SDLSystem implements SystemApi {
    var scancodeKeyMap:Map<Keys, Int> = [];

    public function new() {}

    public function createWindow(width:Int, height:Int, title:String):Int {
        setupKeys();
        #if debug
        return Dough.createWindow(width, height, title, true);
        #else
        return Dough.createWindow(width, height, title, false);
        #end
        return -1;
    }
    
    function setupKeys() {
        for(i in 4...39) scancodeKeyMap.set(i-3, i);
        scancodeKeyMap.set(ENTER, 40);
        scancodeKeyMap.set(ESCAPE, 41);
        scancodeKeyMap.set(BACKSPACE, 42);
        scancodeKeyMap.set(TAB, 43);
        scancodeKeyMap.set(SPACE, 44);
        scancodeKeyMap.set(MINUS, 45);
        scancodeKeyMap.set(EQUALS, 46);
        scancodeKeyMap.set(LEFT_BRACKET, 47);
        scancodeKeyMap.set(RIGHT_BRACKET, 48);
        scancodeKeyMap.set(BACKSLASH, 49);
        scancodeKeyMap.set(SEMICOLON, 51);
        scancodeKeyMap.set(APOSTROPHE, 52);
        scancodeKeyMap.set(GRAVE, 53);
        scancodeKeyMap.set(COMMA, 54);
        scancodeKeyMap.set(PERIOD, 55);
        scancodeKeyMap.set(SLASH, 56);
        scancodeKeyMap.set(F1, 58);
        scancodeKeyMap.set(F2, 59);
        scancodeKeyMap.set(F3, 60);
        scancodeKeyMap.set(F4, 61);
        scancodeKeyMap.set(F5, 62);
        scancodeKeyMap.set(F6, 63);
        scancodeKeyMap.set(F7, 64);
        scancodeKeyMap.set(F8, 65);
        scancodeKeyMap.set(F9, 66);
        scancodeKeyMap.set(F10, 67);
        scancodeKeyMap.set(F11, 68);
        scancodeKeyMap.set(F12, 69);
        scancodeKeyMap.set(RIGHT, 79);
        scancodeKeyMap.set(LEFT, 80);
        scancodeKeyMap.set(DOWN, 81);
        scancodeKeyMap.set(UP, 82);
        scancodeKeyMap.set(LEFT_CTRL, 224);
        scancodeKeyMap.set(LEFT_SHIFT, 225);
        scancodeKeyMap.set(LEFT_ALT, 226);
        scancodeKeyMap.set(RIGHT_CTRL, 228);
        scancodeKeyMap.set(RIGHT_SHIFT, 229);
        scancodeKeyMap.set(RIGHT_ALT, 230);
    }

    public function destroyWindow(window:Int) {
        Dough.destroyWindow(window);
    }

    public function isWindowRunning(window:Int):Bool {
        return Dough.isWindowRunning(window);
    }

    public function setWindowRunning(window:Int, running:Bool) {
        Dough.setWindowRunning(window, running);
    }

    public function getWindowWidth(window:Int):Int {
        return Dough.getWindowWidth(window);
    }

    public function getWindowHeight(window:Int):Int {
        return Dough.getWindowHeight(window);
    }

    public function setWindowSize(window:Int, w:Int, h:Int):Bool {
        return Dough.setWindowSize(window, w, h);
    }

    public function getWindowX(window:Int):Int {
        return Dough.getWindowX(window);
    }

    public function getWindowY(window:Int):Int {
        return Dough.getWindowY(window);
    }

    public function setWindowPosition(window:Int, w:Int, h:Int):Bool {
        return Dough.setWindowPosition(window, w, h);
    }

    public function getCurrentDisplay(window:Int):Int {
        return Dough.getCurrentDisplay(window);
    }

    public function setCurrentDisplay(window:Int, display:Int):Bool {
        return Dough.setCurrentDisplay(window, display); 
    }

    public function getPrimaryDisplay():Int {
        return Dough.getPrimaryDisplay();
    }

    public function isWindowFullscreen(window:Int):Bool {
        return Dough.isWindowFullscreen(window);
    }

    public function toggleFullscreen(window:Int, borderless:Bool):Bool {
        return Dough.toggleFullscreen(window, borderless);
    }

    public function isWindowMinimized(window:Int):Bool {
        return Dough.isWindowMinimized(window);
    }

    public function minimizeWindow(window:Int):Bool {
        return Dough.minimizeWindow(window);
    }

    public function isWindowMaximized(window:Int):Bool {
        return Dough.isWindowMaximized(window);
    }

    public function maximizeWindow(window:Int):Bool {
        return Dough.maximizeWindow(window);
    }

    public function restoreWindow(window:Int):Bool {
        return Dough.restoreWindow(window);
    }

    public function raiseWindow(window:Int):Bool {
        return Dough.raiseWindow(window);
    }

    public function isWindowResizable(window:Int):Bool {
        return Dough.isWindowResizable(window);
    }

    public function setWindowResizable(window:Int, resizable:Bool):Bool {
        return Dough.setWindowResizable(window, resizable);
    }

    public function wasWindowResized(window:Int):Bool {
        return Dough.wasWindowResized(window);
    }

    public function isWindowFocused(window:Int):Bool {
        return Dough.isWindowFocused(window);
    }

    public function focusWindow(window:Int):Bool {
        return Dough.focusWindow(window);
    }

    public function pollWindowEvents():Bool {
        return Dough.pollWindowEvents();
    }

    public function handleWindowEvents(window:Int){
        Dough.handleWindowEvents(window);
    }

    public function handleInputEvents() {
        Dough.handleInputEvents();
    }

    public function setFpsCap(fps:Int) {
        Dough.setFpsCap(fps);
    }

    public function enableFpsCap() {
        Dough.enableFpsCap();
    }

    public function disableFpsCap() {
        Dough.disableFpsCap();
    }

    public function isFpsCapped():Bool {
        return Dough.isFpsCapped();
    }

    public function showCursor() {
        Dough.showCursor();
    }

    public function hideCursor() {
        Dough.hideCursor();
    }

    public function lockCursor(window:Int) {
        Dough.lockCursor(window);
    }

    public function unlockCursor(window:Int) {
        Dough.unlockCursor(window);
    }

    public function setClipboardText(text:String) {
        Dough.setClipboardText(text);
    }

    public function getClipboardText():String {
        return Dough.getClipboardText();
    }

    public function getFrameTime():Float {
        return Dough.getFrameTime();
    }

    public function getElapsedTime():Float {
        return Dough.getElapsedTime();
    }
    
    public function loadBytes(file:String):haxe.io.Bytes {
        return File.getBytes(file);
    }

    public function loadText(file:String):String {
        return File.getContent(file);
    }

    public function writeBytes(file:String, content:haxe.io.Bytes) {
        File.saveBytes(file, content); 
    }

    public function writeText(file:String, content:String) {
        File.saveContent(file, content);
    }

    public function listFileEntries(location:String):Array<String> {
        return FileSystem.readDirectory(location);
    }

    public function fileExists(file:String):Bool {
        return FileSystem.exists(file);
    }

    public function isDirectory(entry:String):Bool {
        return FileSystem.isDirectory(entry);
    }

    public function isKeyDown(key:Int):Bool {
        return Dough.isKeyDown(scancodeKeyMap[key]);
    }

    public function isKeyJustDown(key:Int):Bool {
        return Dough.isKeyJustDown(scancodeKeyMap[key]);
    }

    public function isKeyReleased(key:Int):Bool {
        return Dough.isKeyReleased(scancodeKeyMap[key]);
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
        return Dough.isMouseButtonDown(button);
    }

    public function isMouseButtonJustDown(button:Int):Bool {
        return Dough.isMouseButtonJustDown(button);
    }

    public function isMouseButtonReleased(button:Int):Bool {
        return Dough.isMouseButtonReleased(button);
    }

    public function getMousePositionX():Int {
        return Dough.getMousePositionX();
    }

    public function getMousePositionY():Int {
        return Dough.getMousePositionY();
    }

    public function setMousePosition(window:Int, x:Int, y:Int) {
        return Dough.setMousePosition(window, x, y);
    }

    public function getMouseWheelMovementX():Float {
        return Dough.getMouseWheelMovementX();
    }

    public function getMouseWheelMovementY():Float {
        return Dough.getMouseWheelMovementY();
    }

    public function setMouseCursor(cursor:Int) {
        Dough.setMouseCursor(cursor);
    }
}
