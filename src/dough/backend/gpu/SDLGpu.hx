package dough.backend.gpu;

import haxe.io.UInt16Array;
import haxe.io.Bytes;
import haxe.io.Float32Array;
import dough.graphics.*;
import dough.native.Dough;

class SDLGpu implements GpuApi {
    public function new() {}

    public function beginRender() {
        Dough.beginRender();
    }

    public function endRender() {
        Dough.endRender();
    }

    public function setClearColor(c:Color) {
        Dough.setClearColor(c.rF, c.gF, c.bF, c.aF);
    }

    public function beginRenderPass(window:Int, id:Int) {
        Dough.beginRenderPass(window, id);
    }

    public function endRenderPass(id:Int) {
        Dough.endRenderPass(id);
    }

    public function beginCopyPass() {
        Dough.beginCopyPass();
    }

    public function endCopyPass() {
        Dough.endCopyPass();
    }

    public function loadVertexBuffer(data:Float32Array, size:Int):BackendBufferObject {
        // length * 4 is because the data is stored as 32bit floats
        return Dough.loadVertexBuffer(data.getData().bytes, size * 4);
    }

    public function loadIndexBuffer(data:UInt16Array, size:Int):BackendBufferObject {
        return Dough.loadIndexBuffer(data.getData().bytes, size);
    }

    public function unloadBuffer(buffer:BackendBufferObject) {
        Dough.unloadBuffer(buffer);
    }

    public function loadTextureFromFile(file:String):BackendTexture {
        return Dough.loadTextureFromFile(file);
    }

    public function loadTextureFromBytes(bytes:haxe.io.Bytes, width:Int, height:Int, format:Int):BackendTexture {
        return Dough.loadTextureFromBytes(bytes, width, height, format);
    }

    public function unloadTexture(t:BackendTexture) {
        Dough.unloadTexture(t);
    }

    public function loadSampler():BackendSampler {
        return Dough.loadSampler();
    }

    public function unloadSampler(sampler:BackendSampler) {
        return Dough.unloadSampler(sampler);
    }

    public function loadShaderFromFile(file:String, type:Int, info:dough.graphics.ShaderInformation):BackendShader {
        return Dough.loadShaderFromFile(file, type, info.samplers, info.uniformBuffers, info.storageBuffers, info.storageTextures);
    }

    public function loadShaderFromBytes(data:haxe.io.Bytes, size:Int, type:Int, info:dough.graphics.ShaderInformation):BackendShader {
        return Dough.loadShaderFromBytes(data, size, type, info.samplers, info.uniformBuffers, info.storageBuffers, info.storageTextures);
    }

    public function unloadShader(shader:BackendShader) {
        Dough.unloadShader(shader);
    }

    public function loadGraphicsPipeline(v:BackendShader, f:BackendShader, vs:VertexStructure):BackendGraphicsPipeline {
        Dough.setVertexDataSize(vs.size);
        for(e in vs.elements) {
            Dough.addVertexAttribute(e.e, e.l, e.o);
        }
        return Dough.loadGraphicsPipeline(v, f);
    }

    public function unloadGraphicsPipeline(pipeline:BackendGraphicsPipeline) {
        Dough.unloadGraphicsPipeline(pipeline);
    }

    public function setGraphicsPipeline(pipeline:BackendGraphicsPipeline) {
        Dough.setGraphicsPipeline(pipeline);
    }

    public function setVertexBuffer(buffer:BackendBufferObject) {
        Dough.setVertexBuffer(buffer);
    }

    public function setIndexBuffer(buffer:BackendBufferObject) {
        Dough.setIndexBuffer(buffer);
    }

    public function setVertexUniformData(slot:Int, data:haxe.io.Bytes, size:Int) {
        Dough.setVertexUniformData(slot, data, size);
    }

    public function setFragmentUniformData(slot:Int, data:haxe.io.Bytes, size:Int) {
        Dough.setFragmentUniformData(slot, data, size);
    }

    public function setFragmentSampler(texture:BackendTexture, sampler:BackendSampler) {
        Dough.setFragmentSampler(texture, sampler);
    }

    public function drawPrimitives(vertices:Int, instances:Int) {
        Dough.drawPrimitives(vertices, instances);
    }

    public function drawIndexedPrimitives(indices:Int, instances:Int) {
        Dough.drawIndexedPrimitives(indices, instances);
    }
}
