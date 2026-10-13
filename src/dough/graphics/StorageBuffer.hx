package dough.graphics;

import haxe.io.Float32Array;

abstract StorageBuffer(Int) to Int {
    public inline function new(size:Int)  {
        this = Application.instance.gpu.createStorageBuffer(size);
    }

    public inline function load(data:Array<Float>, size:Int) {
        Application.instance.gpu.loadStorageBuffer(this, Float32Array.fromArray(data), size);
    }

    public inline function unload() {
        Application.instance.gpu.unloadStorageBuffer(this);
    }
}
