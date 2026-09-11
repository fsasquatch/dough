package dough.graphics;

import haxe.io.Bytes;
import dough.backend.BackendShader;

enum abstract ShaderType(Int) to Int {
    var Vertex = 0;
    var Fragment = 1;
    var Compute = 2;
}

// Whatis this AOsdnadgjl I'm dead
abstract Shader(BackendShader) to BackendShader {
    public extern inline overload function new(file:String, type:ShaderType, info:ShaderInformation) {
        this = Application.instance.gpu.loadShaderFromFile(file, type, info); 
    }

    public extern inline overload function new(data:Bytes, size:Int, type:ShaderType, info:ShaderInformation) {
        this = Application.instance.gpu.loadShaderFromBytes(data, size, type, info); 
    }

    public inline function unload() {
        Application.instance.gpu.unloadShader(this);
    }
}
