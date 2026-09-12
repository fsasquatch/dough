package dough.graphics;

import dough.backend.BackendGraphicsPipeline;

// TODO: More detailed pipeline creation
class GraphicsPipeline {
    public var vertexShader:Shader;
    public var fragmentShader:Shader;
    public var inputStructure:VertexStructure;
    
    var backendObj:BackendGraphicsPipeline;

    public function new(vs:Shader, fs:Shader, input:VertexStructure) {
        vertexShader = vs;
        fragmentShader = fs;
        inputStructure = input;
    }

    public function load() {
        backendObj = Application.instance.gpu.loadGraphicsPipeline(vertexShader, fragmentShader, inputStructure);
    }

    public function set() {
        Application.instance.gpu.setGraphicsPipeline(backendObj);
    }

    public function unload() {
        Application.instance.gpu.unloadGraphicsPipeline(backendObj);
    }
}
