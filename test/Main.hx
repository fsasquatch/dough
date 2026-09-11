import dough.Application;
import dough.graphics.*;
import dough.graphics.VertexStructure;

var vertexBuffer:VertexBuffer;
var indexBuffer:I16Buffer;
var pipeline:GraphicsPipeline;
var texture:Texture;
var sampler:Sampler;

function main() {
    var app = new Application(1280, 720, "Game");
    app.onCreate =  () -> {
        var vsInfo:ShaderInformation = {
            samplers: 0,
            uniformBuffers: 0,
            storageBuffers: 0,
            storageTextures: 0
        };
        var vertexShader = new Shader("content/shader.vert.spv", Vertex, vsInfo);
        var fsInfo:ShaderInformation = {
            samplers: 1,
            uniformBuffers: 0,
            storageBuffers: 0,
            storageTextures: 0,
        };
        var fragmentShader = new Shader("content/shader.frag.spv", Fragment, fsInfo); 

        var vs = new VertexStructure();
        vs.add("position", VSElement.Float3);
        vs.add("color", VSElement.Float4);
        vs.add("uv", VSElement.Float2);

        pipeline = new GraphicsPipeline(vertexShader, fragmentShader, vs); 
        pipeline.load();

        vertexShader.unload();
        fragmentShader.unload();

        var vertices = [
            -0.5,  0.5, 0,   1, 1, 1, 1,    0, 0,
             0.5,  0.5, 0,   1, 1, 1, 1,    1, 0,
            -0.5, -0.5, 0,   1, 1, 1, 1,    0, 1,
             0.5, -0.5, 0,   1, 1, 1, 1,    1, 1,
        ];
        vertexBuffer = new VertexBuffer(vertices); 

        var indices = [
            0, 1, 2,
            2, 1, 3
        ];
        indexBuffer = new I16Buffer(indices); 

        texture = new Texture("content/image.png");
        sampler = new Sampler(); 
    };


    app.onDraw = () -> {
        Graphics.begin(0);
        Graphics.setClearColor(Color.RED);

        Graphics.set(pipeline);
        Graphics.set(vertexBuffer);
        Graphics.set(indexBuffer);
        Graphics.set(texture, sampler);
        Graphics.draw();

        Graphics.end();
    }

    app.onDestroy = () -> {
        vertexBuffer.unload();
        indexBuffer.unload();
        texture.unload();
        sampler.unload();
        pipeline.unload();
    }

    app.run();
}
