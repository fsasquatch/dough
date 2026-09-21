package dough.system;

class Window {
    public var width(get, set):Int;
    public var height(get, set):Int;
    public var title:String;

    public var isRunning(get, set):Bool;

    public var currentDisplay(get, null):Int;
    
    public var x(get, set):Int;
    public var y(get, set):Int;

    public var borderless:Bool = true;
    public var fullscreen(get, set):Bool;
    public var resizable(get, set):Bool;

    public var minimized(get, set):Bool;
    public var maximized(get, set):Bool;
    public var focused(get, set):Bool;

    /*
        This is broken.
    */
    public var onResize:()->Void;

    var backendID:Int;

    public function new(width:Int, height:Int, title:String) {
        backendID = Application.instance.system.createWindow(width, height, title);
    }

    public function destroy() {
        Application.instance.system.destroyWindow(backendID);
    }

    function get_isRunning():Bool {
        return Application.instance.system.isWindowRunning(backendID);
    }

    function set_isRunning(value:Bool) {
        Application.instance.system.setWindowRunning(backendID, value);
        return isRunning;
    }

    public function handleEvents() {
        Application.instance.system.handleWindowEvents(backendID);
    }

    public function setWindowSize(width:Int, height:Int) {
        Application.instance.system.setWindowSize(backendID, width, height);
    }
 
    public function setCurrentDisplay(display:Int) {
        Application.instance.system.setCurrentDisplay(backendID, display);
    }

    public function setCurrentPosition(x:Int, y:Int) {
        Application.instance.system.setWindowPosition(backendID, x, y);
    }

    public function isFullscreen():Bool {
        return Application.instance.system.isWindowFullscreen(backendID);
    }

    public function toggleFullscreen() {
        Application.instance.system.toggleFullscreen(backendID, borderless);
    }

    public function isMinimized():Bool {
        return Application.instance.system.isWindowMinimized(backendID);
    }

    public function minimize() {
        Application.instance.system.minimizeWindow(backendID);
    }

    public function isMaximized():Bool {
        return Application.instance.system.isWindowMaximized(backendID);
    } 

    public function maximize() {
        Application.instance.system.maximizeWindow(backendID);
    }

    public function isFocused():Bool {
        return Application.instance.system.isWindowFocused(backendID);
    }

    public function focus() {
        Application.instance.system.focusWindow(backendID);
    }

    public function restore() {
        Application.instance.system.restoreWindow(backendID);
    }

    function get_width() {
        return Application.instance.system.getWindowWidth(backendID);
    }

    function set_width(v:Int){
        Application.instance.system.setWindowSize(backendID, v, height);
        return width;
    }

    function get_height() {
         return Application.instance.system.getWindowHeight(backendID);
    }

    function set_height(v:Int){
        Application.instance.system.setWindowSize(backendID, width, v);
        return height;
    }

    function get_currentDisplay() {
        return Application.instance.system.getCurrentDisplay(backendID);
    }

    function get_x() {
        return Application.instance.system.getWindowX(backendID);
    }
    
    function set_x(v:Int) {
        Application.instance.system.setWindowPosition(backendID, v, x);
        return x;
    }

    function get_y() {
        return Application.instance.system.getWindowY(backendID);
    }

    function set_y(v:Int) {
        Application.instance.system.setWindowPosition(backendID, x, v);
        return y;
    }

    function get_resizable() {
        return Application.instance.system.isWindowResizable(backendID);
    }

    function set_resizable(v:Bool) {
        Application.instance.system.setWindowResizable(backendID, v);
        return resizable;
    }

    function get_fullscreen() {
        return isFullscreen();
    }

    function set_fullscreen(v:Bool) {
        if(v == true && fullscreen == false) toggleFullscreen();
        if(v == true && fullscreen == true) return fullscreen;
        if(v == false && fullscreen == false) return fullscreen;
        if(v == false && fullscreen == true) toggleFullscreen();

        return fullscreen;
    }

    function get_minimized() {
        return isMinimized();
    }

    function set_minimized(v:Bool) { 
        if(v == true) minimize();
        if(v == false) restore();
        return minimized;
    }

    function get_maximized() {
        return isMaximized();
    }

    function set_maximized(v:Bool) {
        if(v == true) maximize();
        if(v == false) restore();
        return maximized;
    }

    function get_focused() {
        return isFocused();
    }

    function set_focused(v:Bool) {
        if(v == true) focus();
        if(v == false) return focused;
        return focused;
    }
}
