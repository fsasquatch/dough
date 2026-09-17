package dough.native;

import hl.Bytes;

typedef NativeBuffer = hl.Abstract<"sdl_gpubuffer">;
typedef NativeTexture = hl.Abstract<"sdl_gputexture">;
typedef NativeSampler = hl.Abstract<"sdl_gpusampler">;
typedef NativeShader = hl.Abstract<"sdl_gpushader">;
typedef NativeGraphicsPipeline = hl.Abstract<"sdl_gpugraphicspipeline">;

@:hlNative("dough")
extern class Dough {
    static function createWindow(width:Int, height:Int, title:String, debug:Bool):Int;
    static function destroyWindow(window:Int):Void;
    static function isWindowRunning(window:Int):Bool;
    static function getWindowWidth(window:Int):Int;
    static function getWindowHeight(window:Int):Int;
    static function setWindowSize(window:Int, w:Int, h:Int):Bool;
    static function getWindowX(window:Int):Int;
    static function getWindowY(window:Int):Int;
    static function setWindowPosition(window:Int, w:Int, h:Int):Bool;
    static function getCurrentDisplay(window:Int):Int;
    static function setCurrentDisplay(window:Int, display:Int):Bool;
    static function getPrimaryDisplay():Int;
    static function isWindowFullscreen(window:Int):Bool;
    static function toggleFullscreen(window:Int, borderless:Bool):Bool;
    static function isWindowMinimized(window:Int):Bool;
    static function minimizeWindow(window:Int):Bool;
    static function isWindowMaximized(window:Int):Bool;
    static function maximizeWindow(window:Int):Bool;
    static function restoreWindow(window:Int):Bool;
    static function raiseWindow(window:Int):Bool;
    static function isWindowResizable(window:Int):Bool;
    static function setWindowResizable(window:Int, resizable:Bool):Bool;
    static function wasWindowResized(window:Int):Bool;
    static function isWindowFocused(window:Int):Bool;
    static function focusWindow(window:Int):Bool;
    static function pollWindowEvents():Bool;
    static function handleWindowEvents(window:Int):Void;

    static function isCursorShown():Bool;
    static function showCursor():Void;
    static function hideCursor():Void;
    static function lockCursor(window:Int):Void;
    static function unlockCursor(window:Int):Void;

    static function setClipboardText(text:String):Void;
    @:noCompletion @:native("get_clipboard_text") static function _getClipboardText():Bytes;
    static inline function getClipboardText():String {
        return @:privateAccess String.fromUTF8(_getClipboardText());
    }

    static function getFrameTime():Float;
    static function getElapsedTime():Float;

    static function isKeyDown(key:Int):Bool;
    static function isKeyJustDown(key:Int):Bool;
    static function isKeyReleased(key:Int):Bool;

    // Gamepads

    static function isMouseButtonDown(button:Int):Bool;
    static function isMouseButtonJustDown(button:Int):Bool;
    static function isMouseButtonReleased(button:Int):Bool; 

    static function getMousePositionX():Int;
    static function getMousePositionY():Int;
    static function setMousePosition(window:Int, x:Int, y:Int):Void;
    static function getMouseWheelMovementX():Single;
    static function getMouseWheelMovementY():Single;
    static function setMouseCursor(cursor:Int):Void;

    static function beginRender():Void;
    static function endRender():Void;
    static function setClearColor(r:Single, g:Single, b:Single, a:Single):Void;
    static function beginRenderPass(window:Int, renderPass:Int):Void;
    static function endRenderPass(renderPass:Int):Void;

    static function beginCopyPass():Void;
    static function endCopyPass():Void;

    static function loadVertexBuffer(data:hl.Bytes, size:Int):NativeBuffer;
    static function loadIndexBuffer(data:hl.Bytes, size:Int):NativeBuffer;
    static function unloadBuffer(buffer:NativeBuffer):Void; 

    static function loadTextureFromBytes(data:hl.Bytes, width:Int, height:Int, format:Int):NativeTexture;
    static function loadTextureFromFile(file:String):NativeTexture;
    static function unloadTexture(texture:NativeTexture):Void;

    static function loadSampler():NativeSampler;
    static function unloadSampler(sampler:NativeSampler):Void;

    static function loadShaderFromBytes(data:hl.Bytes, size:Int, stage:Int, samplerCount:Int, uniformBufferCount:Int, storageBufferCount:Int, storageTextureCount:Int):NativeShader;
    static function loadShaderFromFile(file:String, stage:Int, samplerCount:Int, uniformBufferCount:Int, storageBufferCount:Int, storageTextureCount:Int):NativeShader;
    static function unloadShader(shader:NativeShader):Void;

    static function setVertexDataSize(size:Int):Void;
    static function addVertexAttribute(elementFormat:Int, location:Int, offset:Int):Void;
    static function loadGraphicsPipeline(vertex:NativeShader, fragment:NativeShader):NativeGraphicsPipeline;
    static function unloadGraphicsPipeline(pipeline:NativeGraphicsPipeline):Void;

    static function setGraphicsPipeline(pipeline:NativeGraphicsPipeline):Void;

    static function setVertexBuffer(buffer:NativeBuffer):Void;
    static function setIndexBuffer(buffer:NativeBuffer):Void;

    static function setVertexUniformData(slot:Int, data:hl.Bytes, size:Int):Void;
    static function setFragmentUniformData(slot:Int, data:hl.Bytes, size:Int):Void;
    static function setFragmentSampler(texture:NativeTexture, sampler:NativeSampler):Void;

    static function drawPrimitives(vertices:Int, instances:Int):Void;
    static function drawIndexedPrimitives(indices:Int, instances:Int):Void;
}
