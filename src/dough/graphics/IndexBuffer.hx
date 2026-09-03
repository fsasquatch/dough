package dough.graphics;

import haxe.io.UInt16Array;

// TODO: Mutliple sizes (UInt32 etc.) 
class IndexBuffer {
    public var data:haxe.io.UInt16Array;
    
    public function new(data:Array<Int>) {
        this.data = UInt16Array.fromArray(data); 
    }

    public function upload() {
    }
}
