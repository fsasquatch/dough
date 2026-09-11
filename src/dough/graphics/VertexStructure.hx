package dough.graphics;

enum abstract VSElement(Int) to Int {
    var Float2 = 0;
    var Float3 = 1;
    var Float4 = 2;
}

class VertexStructure {
    public var elements:Map<String, {e:VSElement, l:Int, o:Int}>;
    public var size:Int;

    var counter = 0;

    var bytesSizes:Map<VSElement, Int> = [
        Float2 => 2 * 4,
        Float3 => 3 * 4,
        Float4 => 4 * 4
    ];

    public function new() {
        elements = new Map();
    }

    public function add(name:String, type:VSElement) {
        this.elements.set(name, {e:type, l: counter, o:size});
        size += bytesSizes[type];
        counter++;
    }

    public function remove(name:String) { 
        size -= bytesSizes[elements[name].e];
        this.elements.remove(name);
    }
}
