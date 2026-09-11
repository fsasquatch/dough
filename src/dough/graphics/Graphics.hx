package dough.graphics;

import dough.system.Window;

class Graphics {
    public static inline function setClearColor(color:Color) {
        Application.instance.gpu.setClearColor(color);
    }

    static var currentRenderPass = -1;
    public static inline function begin(id:Int, window:Window = null) {
        currentRenderPass = id;
        
        if(window == null) Application.instance.gpu.beginRenderPass(@:privateAccess Application.instance.mainWindow.backendID, currentRenderPass);
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
