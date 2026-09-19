package dough.backend.gpu;

import js.html.Image;
import js.html.ImageData;
import js.lib.Uint8Array;
import haxe.io.UInt8Array;
import haxe.io.UInt16Array;
import Main.vertexBuffer;
import js.html.webgl.GL2;
import haxe.io.Bytes;
import haxe.io.Float32Array;
import dough.graphics.*;
import js.html.webgl.WebGL2RenderingContext;

class WebGL implements GpuApi {
    var gl:WebGL2RenderingContext;

    public function new() {
        gl = WebSystem.gl;
    }

    public function beginRender() {
        gl.viewport(0, 0, WebSystem.glCanvas.width, WebSystem.glCanvas.height);
    }

    public function endRender() {
    }

    public function setClearColor(c:Color) {
        gl.clearColor(c.rF, c.gF, c.bF, c.aF);
        gl.clear(GL2.COLOR_BUFFER_BIT);
    }

    public function beginRenderPass(window:Int, id:Int) {
    }

    public function endRenderPass(id:Int) {
    }

    public function beginCopyPass() {
    }

    public function endCopyPass() {
    }

    public function loadVertexBuffer(data:Float32Array, size:Int):BackendBufferObject {
        var vb = gl.createBuffer();
        gl.bindBuffer(GL2.ARRAY_BUFFER, vb);
        gl.bufferData(GL2.ARRAY_BUFFER, data.getData(), GL2.STATIC_DRAW);   
        return vb;
    }

    public function loadIndexBuffer(data:UInt16Array, size:Int):BackendBufferObject {
        var ib = gl.createBuffer();
        gl.bindBuffer(GL2.ARRAY_BUFFER, ib);
        gl.bufferData(GL2.ARRAY_BUFFER, data.getData(), GL2.STATIC_DRAW); 
    }

    public function unloadBuffer(buffer:BackendBufferObject) {
        gl.deleteBuffer(buffer);
    }

    // TODO: need to wait until resources load
    public function loadTextureFromFile(file:String):BackendTexture {
        var t = gl.createTexture();

        var level = 0;
        var internalFormat = GL2.RGBA;
        var width = 1;
        var height = 1;
        var border = 0;
        var srcFormat = GL2.RGBA;
        var srcType = GL2.UNSIGNED_BYTE;

        var image = new Image();
        image.onload = () -> {
            gl.bindTexture(GL2.TEXTURE_2D, t);
            gl.texImage2D(GL2.TEXTURE_2D, level, internalFormat, srcFormat, srcType, image);
            gl.generateMipmap(GL2.TEXTURE_2D);
        }
        image.src = file;

        return t;
    }

    public function loadTextureFromBytes(bytes:haxe.io.Bytes, width:Int, height:Int, format:Int):BackendTexture {
        return null;
    }

    public function unloadTexture(t:BackendTexture) {
        gl.deleteTexture(t);
    }

    public function loadSampler():BackendSampler {
        return null;
    }

    public function unloadSampler(sampler:BackendSampler) {
        return null;
    }

    public function loadShaderFromFile(file:String, type:Int, info:dough.graphics.ShaderInformation):BackendShader {
        return null;
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
