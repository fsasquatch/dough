package dough.graphics;

import haxe.io.Bytes;
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

    static inline function get_bytes():Bytes {
#if js
        return Bytes.ofData(mat.getData().buffer);
#else
        return mat.getData().bytes;
#end
    }

    static var mat = new Float32Array(16);
    public static extern inline overload function setVertexUniform(slot:Int, matrix:Matrix4x4) {
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
        Application.instance.gpu.setVertexUniformData(slot, get_bytes(), 16 * 4);   
    }

    public static inline function matricesToData(matrices:Array<Matrix4x4>):Bytes {
        var mat = new Float32Array(16 * matrices.length);
        for(i in 0...matrices.length) {
            var matrix = matrices[i];
            var a = i * 16;
            mat[a + 0] = matrix.m0;
            mat[a + 1] = matrix.m1;
            mat[a + 2] = matrix.m2;
            mat[a + 3] = matrix.m3;
            mat[a+  4] = matrix.m4;
            mat[a + 5] = matrix.m5;
            mat[a+ 6] = matrix.m6;
            mat[a + 7] = matrix.m7;
            mat[a+ 8] = matrix.m8;
            mat[a+ 9] = matrix.m9;
            mat[a+ 10] = matrix.m10;
            mat[a+ 11] = matrix.m11;
            mat[a+ 12] = matrix.m12;
            mat[a+ 13] = matrix.m13;
            mat[a+ 14] = matrix.m14;
            mat[a+ 15] = matrix.m15;
        }
        return mat.getData().bytes;
    }

    public static extern inline overload function setVertexUniform(slot:Int, bytes:Bytes, size:Int) {
        Application.instance.gpu.setVertexUniformData(slot, bytes, size);
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
