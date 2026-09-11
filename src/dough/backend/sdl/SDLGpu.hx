package dough.backend.sdl;

import haxe.io.Bytes;
import haxe.io.Float32Array;
import dough.graphics.*;
import dough.native.Native;

class SDLGpu implements GpuApi {
    public function new() {}

    public function beginRender() {
        Native.beginRender();
    }

    public function endRender() {
        Native.endRender();
    }

    public function setClearColor(c:Color) {
        Native.setClearColor(c.rF, c.gF, c.bF, c.aF);
    }

    public function beginRenderPass(window:Int, id:Int) {
        Native.beginRenderPass(window, id);
    }

    public function endRenderPass(id:Int) {
        Native.endRenderPass(id);
    }

    public function beginCopyPass() {
        Native.beginCopyPass();
    }

    public function endCopyPass() {
        Native.endCopyPass();
    }

    public function loadVertexBuffer(data:Bytes, size:Int):BackendBufferObject {
        // length * 4 is because the data is stored as 32bit floats
        return Native.loadVertexBuffer(data, size * 4);
    }

    public function loadIndexBuffer(data:Bytes, size:Int):BackendBufferObject {
        return Native.loadIndexBuffer(data, size);
    }

    public function unloadBuffer(buffer:BackendBufferObject) {
        Native.unloadBuffer(buffer);
    }

    public function loadTextureFromFile(file:String):BackendTexture {
        return Native.loadTextureFromFile(file);
    }

    public function loadTextureFromBytes(bytes:haxe.io.Bytes, width:Int, height:Int, format:Int):BackendTexture {
        return Native.loadTextureFromBytes(bytes, width, height, format);
    }

    public function unloadTexture(t:BackendTexture) {
        Native.unloadTexture(t);
    }

    public function loadSampler():BackendSampler {
        return Native.loadSampler();
    }

    public function unloadSampler(sampler:BackendSampler) {
        return Native.unloadSampler(sampler);
    }

    public function loadShaderFromFile(file:String, type:Int, info:dough.graphics.ShaderInformation):BackendShader {
        return Native.loadShaderFromFile(file, type, info.samplers, info.uniformBuffers, info.storageBuffers, info.storageTextures);
    }

    public function loadShaderFromBytes(data:haxe.io.Bytes, size:Int, type:Int, info:dough.graphics.ShaderInformation):BackendShader {
        return Native.loadShaderFromBytes(data, size, type, info.samplers, info.uniformBuffers, info.storageBuffers, info.storageTextures);
    }

    public function unloadShader(shader:BackendShader) {
        Native.unloadShader(shader);
    }

    public function loadGraphicsPipeline(v:BackendShader, f:BackendShader, vs:VertexStructure):BackendGraphicsPipeline {
        Native.setVertexDataSize(vs.size);
        for(e in vs.elements) {
            Native.addVertexAttribute(e.e, e.l, e.o);
        }
        return Native.loadGraphicsPipeline(v, f);
    }

    public function unloadGraphicsPipeline(pipeline:BackendGraphicsPipeline) {
        Native.unloadGraphicsPipeline(pipeline);
    }

    public function setGraphicsPipeline(pipeline:BackendGraphicsPipeline) {
        Native.setGraphicsPipeline(pipeline);
    }

    public function setVertexBuffer(buffer:BackendBufferObject) {
        Native.setVertexBuffer(buffer);
    }

    public function setIndexBuffer(buffer:BackendBufferObject) {
        Native.setIndexBuffer(buffer);
    }

    public function setVertexUniformData(slot:Int, data:haxe.io.Bytes, size:Int) {
        Native.setVertexUniformData(slot, data, size);
    }

    public function setFragmentUniformData(slot:Int, data:haxe.io.Bytes, size:Int) {
        Native.setFragmentUniformData(slot, data, size);
    }

    public function setFragmentSampler(texture:BackendTexture, sampler:BackendSampler) {
        Native.setFragmentSampler(texture, sampler);
    }

    public function drawPrimitives(vertices:Int, instances:Int) {
        Native.drawPrimitives(vertices, instances);
    }

    public function drawIndexedPrimitives(indices:Int, instances:Int) {
        Native.drawIndexedPrimitives(indices, instances);
    }
}
