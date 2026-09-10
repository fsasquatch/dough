package dough.backend;

import dough.graphics.*;

interface GpuApi {
    public function beginRender():Void;
    public function endRender():Void;
    public function setClearColor(c:Color):Void;
    public function beginRenderPass(window:Int, id:Int):Void;
    public function endRenderPass(id:Int):Void;
    // TODO: Render targets

    // upload multiple resources (vertex buffers, textures) at once
    // calling load functions here should avoid it creating its own copy pass
    // only for the SDL backend
    public function beginCopyPass():Void;
    public function endCopyPass():Void;

    // loads a vertex buffer to the gpu
    public function loadVertexBuffer(vertexBuffer:VertexBuffer):BackendBufferObject;
    public function loadIndexBuffer(indexBuffer:IndexBuffer):BackendBufferObject;
    public function unloadBuffer(buffer:BackendBufferObject):Void;

    public function loadTextureFromFile(file:String):BackendTexture;
    // TODO: Enum for all the texture formats
    public function loadTextureFromBytes(bytes:haxe.io.Bytes, width:Int, height:Int, format:Int):BackendTexture;
    public function unloadTexture(texture:BackendTexture):Void;

    // TODO: setup proper sampler configuration
    // refer https://github.com/TheSpydog/SDL_gpu_examples/blob/main/Examples/TexturedQuad.c
    public function loadSampler():BackendSampler;
    public function unloadSampler(sampler:BackendSampler):Void;

    public function loadShader(file:String, type:Int):BackendShader;
    public function unloadShader(shader:BackendShader):Void;

    // TODO: pipeline configuration for depth texture
    public function loadGraphicsPipeline(vertexShader:BackendShader, fragementShader:BackendShader, inputStructure:VertexStructure):BackendGraphicsPipeline;
    public function unloadGraphicsPipeline(pipeline:BackendGraphicsPipeline):Void;
    public function setGraphicsPipeline(pipeline:BackendGraphicsPipeline):Void;

    public function setVertexBuffer(buffer:BackendBufferObject):Void;
    public function setIndexBuffer(buffer:BackendBufferObject):Void;
    
    public function setVertexUniformData(slot:Int, data:haxe.io.Bytes, size:Int):Void;
    public function setFragmentUniformData(slot:Int, data:haxe.io.Bytes, size:Int):Void; 
    public function setFragmentSampler(slot:Int, texture:BackendTexture, sampler:BackendSampler):Void;

    public function drawPrimitives():Void;
    public function drawIndexedPrimitives():Void;
}
