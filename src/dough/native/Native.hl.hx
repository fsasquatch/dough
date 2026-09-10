package dough.native;

typedef NativeBuffer = hl.Abstract<"sdl_gpubuffer">;
typedef NativeTexture = hl.Abstract<"sdl_gputexture">;
typedef NativeSampler = hl.Abstract<"sdl_gpusampler">;
typedef NativeShader = hl.Abstract<"sdl_gpushader">;
typedef NativeGraphicsPipeline = hl.Abstract<"sdl_gpugraphicspipeline">;

@:hlNative("dough")
extern class Native {
    public static function createWindow(width:Int, height:Int, title:String, flags:Int):Int;
    public static function destroyWindow(window:Int):Void;
    public static function isWindowRunning(window:Int):Bool;
    public static function getWindowWidth(window:Int):Int;
    public static function getWindowHeight(window:Int):Int;
    public static function setWindowSize(window:Int, w:Int, h:Int):Bool;
    public static function getWindowX(window:Int):Int;
    public static function getWindowY(window:Int):Int;
    public static function setWindowPosition(window:Int, w:Int, h:Int):Bool;
    public static function getCurrentDisplay(window:Int):Int;
    public static function setCurrentDisplay(window:Int, display:Int):Bool;
    public static function getPrimaryDisplay():Int;
    public static function isWindowFullscreen(window:Int):Bool;
    public static function toggleFullscreen(window:Int, borderless:Bool):Bool;
    public static function minimizeWindow(window:Int):Bool;
    public static function maximizeWindow(window:Int):Bool;
    public static function raiseWindow(window:Int):Bool;
    public static function pollWindowEvents():Bool;
    public static function handleWindowEvents(window:Int):Void;

    public static function beginRender():Void;
    public static function endRender():Void;
    public static function setClearColor(r:Single, g:Single, b:Single, a:Single):Void;
    public static function beginRenderPass(window:Int, renderPass:Int):Void;
    public static function endRenderPass(renderPass:Int):Void;

    public static function beginCopyPass():Void;
    public static function endCopyPass():Void;

    public static function loadVertexBuffer(data:hl.Bytes, size:Int):NativeBuffer;
    public static function loadIndexBuffer(data:hl.Bytes, size:Int):NativeBuffer;
    public static function unloadBuffer(buffer:NativeBuffer):Void; 

    public static function loadTextureFromBytes(data:hl.Bytes, width:Int, height:Int, format:Int):NativeTexture;
    public static function loadTextureFromFile(file:String):NativeTexture;
    public static function unloadTexture(texture:NativeTexture):Void;

    public static function loadSampler():NativeSampler;
    public static function unloadSampler(sampler:NativeSampler):Void;

    public static function loadShaderFromBytes(data:hl.Bytes, size:Int, stage:Int, samplerCount:Int, uniformBufferCount:Int, storageBufferCount:Int, storageTextureCount:Int):NativeShader;
    public static function loadShaderFromFile(file:String, stage:Int, samplerCount:Int, uniformBufferCount:Int, storageBufferCount:Int, storageTextureCount:Int):NativeShader;
    public static function unloadShader(shader:NativeShader):Void;

    public static function setVertexDataSize(size:Int):Void;
    public static function addVertexAttribute(elementFormat:Int, location:Int, offset:Int):Void;
    public static function loadGraphicsPipeline(vertex:NativeShader, fragment:NativeShader):NativeGraphicsPipeline;
    public static function unloadGraphicsPipeline(pipeline:NativeGraphicsPipeline):Void;

    public static function setGraphicsPipeline(pipeline:NativeGraphicsPipeline):Void;

    public static function setVertexBuffer(buffer:NativeBuffer):Void;
    public static function setIndexBuffer(buffer:NativeBuffer):Void;

    public static function setVertexUniformData(slot:Int, data:hl.Bytes, size:Int):Void;
    public static function setFragmentUniformData(slot:Int, data:hl.Bytes, size:Int):Void;
    public static function setFragmentSampler(texture:NativeTexture, sampler:NativeSampler):Void;

    public static function drawPrimitives(vertices:Int, instances:Int):Void;
    public static function drawIndexedPrimitives(indices:Int, instances:Int):Void;
}
