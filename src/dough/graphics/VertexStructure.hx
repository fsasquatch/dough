package dough.graphics;

// TODO: Maybe move these types somewhere else?
enum VSElement {
    Float2;
    Float3;
    Float4;
}

class VertexStructure {
    public var elements:Map<String, VSElement>;
    public var size:Int;

    var bytesSizes:Map<VSElement, Int> = [
        Float2 => 2 * 4,
        Float3 => 3 * 4,
        Float4 => 4 * 4
    ];

    public function new() {}

    public function add(name:String, type:VSElement) {
        this.elements.set(name, type);
        size += bytesSizes[type];
    }

    public function remove(name:String) { 
        size -= bytesSizes[elements[name]];
        this.elements.remove(name);
    }
}
