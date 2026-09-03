package dough.graphics;

import haxe.io.Float32Array;

class VertexBuffer {
    public var data:haxe.io.Float32Array;
    public var structure:VertexStructure;

    public function new(data:Array<Float>, structure:VertexStructure) {
        this.data = Float32Array.fromArray(data);
        this.structure = structure;
    }

    public function upload() {
    }
}
