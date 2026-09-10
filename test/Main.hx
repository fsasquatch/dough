import haxe.io.UInt16Array;
import haxe.io.Float32Array;
import dough.native.Native;

function main() {
    var window = Native.createWindow(1280, 720, "hello world", 0);
    var window2 = Native.createWindow(800, 600, "another window?", 0);

    var vertexShader = Native.loadShaderFromFile("content/triangle.vert.spv", 0, 0, 0, 0, 0);
    var fragmentShader = Native.loadShaderFromFile("content/triangle.frag.spv", 1, 1, 0, 0, 0);

    var arr = [
        -0.5,  0.5, 0,   1, 1, 1, 1,    0, 0,
         0.5,  0.5, 0,   1, 1, 1, 1,    1, 0,
        -0.5, -0.5, 0,   1, 1, 1, 1,    0, 1,
         0.5, -0.5, 0,   1, 1, 1, 1,    1, 1,
    ];
    var vertices = Float32Array.fromArray(arr);
   
    var arr = [
        0, 1, 2,
        2, 1, 3
    ];
    var indices = UInt16Array.fromArray(arr);

    Native.beginCopyPass();
    var vertexBuffer = Native.loadVertexBuffer(vertices.getData().bytes, vertices.length * 4);
    var indexBuffer = Native.loadIndexBuffer(indices.getData().bytes, indices.length * 2);
    
    var texture = Native.loadTextureFromFile("content/image.png");
    
    Native.endCopyPass();
    var sampler = Native.loadSampler();

    Native.setVertexDataSize(9 * 4);
    Native.addVertexAttribute(1, 0, 0);
    Native.addVertexAttribute(3, 1, 3 * 4);
    Native.addVertexAttribute(0, 2, (3*4) + (4*4));
    var pipeline = Native.loadGraphicsPipeline(vertexShader, fragmentShader);
    Native.unloadShader(vertexShader);
    Native.unloadShader(fragmentShader);

    while(Native.isWindowRunning(window)) {
        while(Native.pollWindowEvents()) {
            Native.handleWindowEvents(window);
            Native.handleWindowEvents(window2);
        }

        Native.beginRender();

        Native.setClearColor(0, 0, 0, 0);
        Native.beginRenderPass(window, 0);
        Native.setGraphicsPipeline(pipeline);
        Native.setVertexBuffer(vertexBuffer);
        Native.setIndexBuffer(indexBuffer);
        Native.setFragmentSampler(texture, sampler);
        Native.drawIndexedPrimitives(6, 1);
        Native.endRenderPass(0);

        if(Native.isWindowRunning(window2)) {
            Native.setClearColor(0, 0.5, 0.5, 0);
            Native.beginRenderPass(window2, 0);
            Native.endRenderPass(0);
        }

        Native.endRender();

        if(!Native.isWindowRunning(window2)) Native.destroyWindow(window2);
    }

    Native.unloadBuffer(vertexBuffer);
    Native.unloadBuffer(indexBuffer);
    Native.unloadTexture(texture);
    Native.unloadSampler(sampler);
    Native.unloadGraphicsPipeline(pipeline);
    Native.destroyWindow(window);
}
