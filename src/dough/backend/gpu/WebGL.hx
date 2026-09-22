package dough.backend.gpu;

import js.html.CanvasElement;
import js.Browser;
import js.html.Image;
import js.html.ImageData;
import js.lib.Uint8Array;
import haxe.io.UInt8Array;
import haxe.io.UInt16Array;
import js.html.webgl.GL2;
import haxe.io.Bytes;
import haxe.io.Float32Array;
import dough.graphics.*;
import js.html.webgl.WebGL2RenderingContext;
import dough.backend.system.WebSystem;

class WebGL implements GpuApi {
    var gl:WebGL2RenderingContext;

    public function new() {
        var canvas:CanvasElement = cast Browser.document.getElementById("webgl");
        gl = canvas.getContextWebGL2();
    }

    public function beginRender() {
    }

    public function endRender() {
    }

    public function setClearColor(c:Color) {
        gl.clearColor(c.rF, c.gF, c.bF, c.aF);
    }

    public function beginRenderPass(window:Int, id:Int) {
        gl.viewport(0, 0, WebSystem.glCanvas.width, WebSystem.glCanvas.height);
        gl.clear(GL2.COLOR_BUFFER_BIT);
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
        return ib;
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
        return null;
    }

    public function unloadShader(shader:BackendShader) {
        return null;
    }

    public function loadGraphicsPipeline(v:BackendShader, f:BackendShader, vs:VertexStructure):BackendGraphicsPipeline {
        return null;
    }

    public function unloadGraphicsPipeline(pipeline:BackendGraphicsPipeline) {
    }

    public function setGraphicsPipeline(pipeline:BackendGraphicsPipeline) {
        return null;
    }

    public function setVertexBuffer(buffer:BackendBufferObject) {
        return null;
    }

    public function setIndexBuffer(buffer:BackendBufferObject) {
        return null;
    }

    public function setVertexUniformData(slot:Int, data:haxe.io.Bytes, size:Int) {
        return null;
    }

    public function setFragmentUniformData(slot:Int, data:haxe.io.Bytes, size:Int) {
        return null;
    }

    public function setFragmentSampler(texture:BackendTexture, sampler:BackendSampler) {
        return null;
    }

    public function drawPrimitives(vertices:Int, instances:Int) {
        return null;
    }

    public function drawIndexedPrimitives(indices:Int, instances:Int) {
        return null;
    }
}
