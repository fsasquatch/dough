package dough.graphics;

import mathmath.linalg.Matrix4x4;
import haxe.io.Float32Array;
import dough.system.Window;

class Graphics {
    public static inline function setClearColor(color:Color) {
        Application.instance.gpu.setClearColor(color);
    }

    static var currentRenderPass = -1;
    public static inline function begin(id:Int, window:Window = null) {
        currentRenderPass = id;
        
        if(window == null) Application.instance.gpu.beginRenderPass(@:privateAccess Application.instance.windows[0].backendID, currentRenderPass);
        else Application.instance.gpu.beginRenderPass(@:privateAccess window.backendID, currentRenderPass);
    }

    public static inline function end() {
        Application.instance.gpu.endRenderPass(currentRenderPass);
        currentRenderPass = -1;
    }

    public static extern inline overload function set(pipeline:GraphicsPipeline) {
        Application.instance.gpu.setGraphicsPipeline(@:privateAccess pipeline.backendObj);
    }

    public static extern inline overload function set(vertexBuffer:VertexBuffer) {
        Application.instance.gpu.setVertexBuffer(vertexBuffer);
    }

    static var currentIndexBufferLength = -1;
    public static extern inline overload function set(i16buffer:I16Buffer) {
        Application.instance.gpu.setIndexBuffer(@:privateAccess i16buffer.backendObj);
        currentIndexBufferLength = i16buffer.length;
    }

    public static extern inline overload function set(texture:Texture, sampler:Sampler) {
        Application.instance.gpu.setFragmentSampler(@:privateAccess texture.backendObj, @:privateAccess sampler.backendObj); 
    }

    static var mat = new Float32Array(16);
    public static inline function setVertexUniform(slot:Int, matrix:Matrix4x4) {
        mat[0] = matrix.m0;
        mat[1] = matrix.m1;
        mat[2] = matrix.m2;
        mat[3] = matrix.m3;
        mat[4] = matrix.m4;
        mat[5] = matrix.m5;
        mat[6] = matrix.m6;
        mat[7] = matrix.m7;
        mat[8] = matrix.m8;
        mat[9] = matrix.m9;
        mat[10] = matrix.m10;
        mat[11] = matrix.m11;
        mat[12] = matrix.m12;
        mat[13] = matrix.m13;
        mat[14] = matrix.m14;
        mat[15] = matrix.m15;
        Application.instance.gpu.setVertexUniformData(slot, mat.getData().bytes, 16 * 4);   
    }

    public static inline function setFragmentUniform(slot:Int, data:haxe.io.Bytes) {
    }

    public static extern inline overload function draw(vertices:Int, instances:Int = 1) {
        Application.instance.gpu.drawPrimitives(vertices, instances);
    }

    public static extern inline overload function draw(instances:Int = 1) {
        if(currentIndexBufferLength == -1) {
            trace("No index buffer bound!");
            return;
        }
        
        Application.instance.gpu.drawIndexedPrimitives(currentIndexBufferLength, instances);
    }
}
