package dough.graphics;

import dough.backend.BackendTexture;

class Texture {
    public var width:Int;
    public var height:Int;
    public var format:Int;

    var backendObj:BackendTexture;

    public function new(file:String) {
        backendObj = Application.instance.gpu.loadTextureFromFile(file);
    }

    public function unload() {
        Application.instance.gpu.unloadTexture(backendObj);
    }
}
