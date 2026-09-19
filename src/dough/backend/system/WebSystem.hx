package dough.backend.system;

import haxe.io.Bytes;
import js.html.XMLHttpRequest;
import js.Browser;
import js.html.webgl.WebGL2RenderingContext;
import js.html.CanvasElement;

class WebSystem implements SystemApi {
    public static var gl:WebGL2RenderingContext; 
    public static var glCanvas:CanvasElement;

    public function new() {}

    public function createWindow(width:Int, height:Int, title:String, flags:Int):Int { 
        glCanvas = cast Browser.document.getElementById("gl-canvas");
        gl = glCanvas.getContextWebGL2();

        glCanvas.width = width;
        glCanvas.height = height;
        Browser.document.title = title;

        return 0;
    }

    public function destroyWindow(window:Int) {
        // Why do I not use something like godot
    }

    public function isWindowRunning(window:Int):Bool {
        return false;
    }

    public function getWindowWidth(window:Int):Int {
        return glCanvas.width; 
    }

    public function getWindowHeight(window:Int):Int {
        return glCanvas.height;
    }

    public function setWindowSize(window:Int, w:Int, h:Int):Bool {
        glCanvas.width = w;
        glCanvas.height = h;

        return true;
    }

    public function getWindowX(window:Int):Int {
        return 0;
    }

    public function getWindowY(window:Int):Int {
        return 0;
    }

    public function setWindowPosition(window:Int, w:Int, h:Int):Bool {
        return false;
    }

    public function getCurrentDisplay(window:Int):Int {
        return 0;
    }

    public function setCurrentDisplay(window:Int, display:Int):Bool {
        return false;
    }

    public function getPrimaryDisplay():Int {
        return -1;
    }

    public function isWindowFullscreen(window:Int):Bool {
        return false;
    }

    public function toggleFullscreen(window:Int, borderless:Bool):Bool {
        return false;
    }

    public function isWindowMinimized(window:Int):Bool {
        //return Native.isWindowMinimized(window);
        return false;
    }

    public function minimizeWindow(window:Int):Bool {
        return false;
    }

    public function isWindowMaximized(window:Int):Bool {
        return false;
    }

    public function maximizeWindow(window:Int):Bool {
        return false;
    }

    public function raiseWindow(window:Int):Bool {
        return false;
    }

    public function pollWindowEvents():Bool {
        return false;
    }

    public function handleWindowEvents(window:Int){
        // handle stuff
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
