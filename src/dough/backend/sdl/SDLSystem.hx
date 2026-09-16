package dough.backend.sdl;

import dough.system.Keys;
import sys.FileSystem;
import sys.io.File;
import dough.native.Dough;

class SDLSystem implements SystemApi {
    var scancodeKeyMap:Map<Keys, Int> = [];

    public function new() {}

    public function createWindow(width:Int, height:Int, title:String):Int {
        #if debug
        return Dough.createWindow(width, height, title, true);
        #else
        return Dough.createWindow(width, height, title, false);
        #end
        setupKeys();
        return 0;
    }
    
    function setupKeys() {
        for(i in 4...39) scancodeKeyMap.set(i-3, i);
        scancodeKeyMap.set(40, ENTER);
        scancodeKeyMap.set(41, ESCAPE);
        scancodeKeyMap.set(42, BACKSPACE);
        scancodeKeyMap.set(43, TAB);
        scancodeKeyMap.set(44, SPACE);
        scancodeKeyMap.set(45, MINUS);
        scancodeKeyMap.set(46, EQUALS);
        scancodeKeyMap.set(47, LEFT_BRACKET);
        scancodeKeyMap.set(48, RIGHT_BRACKET);
        scancodeKeyMap.set(49, BACKSLASH);
        scancodeKeyMap.set(51, SEMICOLON);
        scancodeKeyMap.set(52, APOSTROPHE);
        scancodeKeyMap.set(53, GRAVE);
        scancodeKeyMap.set(54, COMMA);
        scancodeKeyMap.set(55, PERIOD);
        scancodeKeyMap.set(56, SLASH);
        scancodeKeyMap.set(58, F1);
        scancodeKeyMap.set(59, F2);
        scancodeKeyMap.set(60, F3);
        scancodeKeyMap.set(61, F4);
        scancodeKeyMap.set(62, F5);
        scancodeKeyMap.set(63, F6);
        scancodeKeyMap.set(64, F7);
        scancodeKeyMap.set(65, F8);
        scancodeKeyMap.set(66, F9);
        scancodeKeyMap.set(67, F10);
        scancodeKeyMap.set(68, F11);
        scancodeKeyMap.set(69, F12);
        scancodeKeyMap.set(79, RIGHT);
        scancodeKeyMap.set(80, LEFT);
        scancodeKeyMap.set(81, DOWN);
        scancodeKeyMap.set(82, UP);
        scancodeKeyMap.set(224, LEFT_CTRL);
        scancodeKeyMap.set(225, LEFT_SHIFT);
        scancodeKeyMap.set(226, LEFT_ALT);
        scancodeKeyMap.set(228, RIGHT_CTRL);
        scancodeKeyMap.set(229, RIGHT_SHIFT);
        scancodeKeyMap.set(230, RIGHT_ALT);
    }

    public function destroyWindow(window:Int) {
        Dough.destroyWindow(window);
    }

    public function isWindowRunning(window:Int):Bool {
        return Dough.isWindowRunning(window);
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
