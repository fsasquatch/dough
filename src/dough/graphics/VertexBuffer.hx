package dough.graphics;

import dough.backend.BackendBufferObject;
import haxe.io.Float32Array;

abstract VertexBuffer(BackendBufferObject) to BackendBufferObject {
    public inline function new(array:Array<Float>) {
        var buf = Float32Array.fromArray(array);
        this = Application.instance.gpu.loadVertexBuffer(buf, buf.length * 4); 
    }

    public inline function unload() {
        Application.instance.gpu.unloadBuffer(this);
    }
}
