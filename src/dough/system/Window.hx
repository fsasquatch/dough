package dough.system;

class Window {
    public var width(get, set):Int;
    public var height(get, set):Int;
    public var title:String;

    //public var x(get, set):Int;
    //public var y(get, set):Int;

    // Window flags
    //public var decorations(get, null):Bool;
    //public var resizable(get, null):Bool;

    public var currentDisplay(get, null):Int;

    var backendID:Int;

    public function new(width:Int, height:Int, title:String) {
        backendID = Application.instance.system.createWindow(width, height, title, 0);
    }

    public function destroy() {
        Application.instance.system.destroyWindow(backendID);
    }

    public function isRunning():Bool {
        return Application.instance.system.isWindowRunning(backendID);
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
}
