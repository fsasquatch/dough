package dough.graphics;

import dough.backend.BackendBufferObject;
import haxe.io.UInt16Array;

// TODO: More formats
class I16Buffer { 
    public var length:Int;

    var backendObj:BackendBufferObject;

    public function new(data:Array<Int>) {
        var buf = UInt16Array.fromArray(data);
        length = buf.length;
        backendObj = Application.instance.gpu.loadIndexBuffer(buf.getData().bytes, buf.length * 2);
    }

    public function unload() {
        Application.instance.gpu.unloadBuffer(backendObj);
    }
}
