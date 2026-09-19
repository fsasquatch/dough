package dough.native;

@:include('dough_internal.h')
@:native('SDL_GPUBuffer')
extern class _NativeBuffer {
}
typedef NativeBuffer = cpp.RawPointer<_NativeBuffer>;

@:include('dough_internal.h')
@:native('SDL_GPUGraphicsPipeline')
extern class _NativeGraphicsPipeline {
}
typedef NativeGraphicsPipeline = cpp.RawPointer<_NativeGraphicsPipeline>;

@:include('dough_internal.h')
@:native('SDL_GPUShader')
extern class _NativeShader{
}
typedef NativeShader = cpp.RawPointer<_NativeShader>;

@:include('dough_internal.h')
@:native('SDL_GPUSampler')
extern class _NativeSampler {
}
typedef NativeSampler = cpp.RawPointer<_NativeSampler>;

@:include('dough_internal.h')
@:native('SDL_GPUTexture')
extern class _NativeTexture {
}
typedef NativeTexture = cpp.RawPointer<_NativeTexture>;

@:buildXml("<include name='${haxelib:dough}/build.xml' />")
@:include('dough.h')
extern class Dough {
    @:native("dh_create_window") static function createWindow(width:Int, height:Int, title:String, debug:Bool):Int;
    @:native("dh_destroy_window") static function destroyWindow(window:Int):Void;
    @:native("dh_is_window_running") static function isWindowRunning(window:Int):Bool;
    @:native("dh_get_window_width") static function getWindowWidth(window:Int):Int;
    @:native("dh_get_window_height") static function getWindowHeight(window:Int):Int;
    @:native("dh_set_window_size") static function setWindowSize(window:Int, w:Int, h:Int):Bool;
    @:native("dh_get_window_x") static function getWindowX(window:Int):Int;
    @:native("dh_get_window_y") static function getWindowY(window:Int):Int;
    @:native("dh_set_window_position") static function setWindowPosition(window:Int, w:Int, h:Int):Bool;
    @:native("dh_get_current_display") static function getCurrentDisplay(window:Int):Int;
    @:native("dh_set_current_display") static function setCurrentDisplay(window:Int, display:Int):Bool;
    @:native("dh_get_primary_display") static function getPrimaryDisplay():Int;
    @:native("dh_is_window_fullscreen") static function isWindowFullscreen(window:Int):Bool;
    @:native("dh_toggle_fullscreen") static function toggleFullscreen(window:Int, borderless:Bool):Bool;
    @:native("dh_is_window_minimized") static function isWindowMinimized(window:Int):Bool;
    @:native("dh_minimized_window") static function minimizeWindow(window:Int):Bool;
    @:native("dh_is_window_maximized") static function isWindowMaximized(window:Int):Bool;
    @:native("dh_maximize_window") static function maximizeWindow(window:Int):Bool;
    @:native("dh_restore_window") static function restoreWindow(window:Int):Bool;
    @:native("dh_raise_window") static function raiseWindow(window:Int):Bool;
    @:native("dh_is_window_resizable") static function isWindowResizable(window:Int):Bool;
    @:native("dh_set_window_resizable") static function setWindowResizable(window:Int, resizable:Bool):Bool;
    @:native("dh_was_window_resized") static function wasWindowResized(window:Int):Bool;
    @:native("dh_is_window_focused") static function isWindowFocused(window:Int):Bool;
    @:native("dh_focus_window") static function focusWindow(window:Int):Bool;
    @:native("dh_poll_window_events") static function pollWindowEvents():Bool;
    @:native("dh_handle_window_events") static function handleWindowEvents(window:Int):Void;

    @:native("dh_is_cursor_shown") static function isCursorShown():Bool;
    @:native("dh_show_cursor") static function showCursor():Void;
    @:native("dh_hide_cursor") static function hideCursor():Void;
    @:native("dh_lock_cursor") static function lockCursor(window:Int):Void;
    @:native("dh_unlock_cursor") static function unlockCursor(window:Int):Void;

    @:native("dh_set_clipboard_text") static function setClipboardText(text:String):Void;
    @:noCompletion @:native("dh_get_clipboard_text") static function _getClipboardText():VoidPointer; 
    extern static inline function getClipboardText():String {
        return @:privateAccess _getClipboardText().toBytes().toString();
    }

    @:native("dh_get_frame_time") static function getFrameTime():Float;
    @:native("dh_get_elapsed_time") static function getElapsedTime():Float;

    @:native("dh_is_key_down") static function isKeyDown(key:Int):Bool;
    @:native("dh_is_key_just_down") static function isKeyJustDown(key:Int):Bool;
    @:native("dh_is_key_released") static function isKeyReleased(key:Int):Bool;

    // Gamepads

    @:native("dh_is_mouse_button_down") static function isMouseButtonDown(button:Int):Bool;
    @:native("dh_is_mouse_button_just_down") static function isMouseButtonJustDown(button:Int):Bool;
    @:native("dh_is_mouse_button_released") static function isMouseButtonReleased(button:Int):Bool; 

    @:native("dh_get_mouse_position_x") static function getMousePositionX():Int;
    @:native("dh_get_mouse_position_y") static function getMousePositionY():Int;
    @:native("dh_set_mouse_position") static function setMousePosition(window:Int, x:Int, y:Int):Void;
    @:native("dh_get_mouse_wheel_movement_x") static function getMouseWheelMovementX():Single;
    @:native("dh_get_mouse_wheel_movement_y") static function getMouseWheelMovementY():Single;
    @:native("dh_set_mouse_cursor") static function setMouseCursor(cursor:Int):Void;

    @:native("dh_begin_render") static function beginRender():Void;
    @:native("dh_end_render") static function endRender():Void;
    @:native("dh_set_clear_color") static function setClearColor(r:Single, g:Single, b:Single, a:Single):Void;
    @:native("dh_begin_render_pass") static function beginRenderPass(window:Int, renderPass:Int):Void;
    @:native("dh_end_render_pass") static function endRenderPass(renderPass:Int):Void;

    @:native("dh_begin_copy_pass") static function beginCopyPass():Void;
    @:native("dh_end_copy_pass") static function endCopyPass():Void;

    @:native("dh_load_vertex_buffer") static function loadVertexBuffer(data:VoidPointer, size:Int):NativeBuffer;
    @:native("dh_load_index_buffer") static function loadIndexBuffer(data:VoidPointer, size:Int):NativeBuffer;
    @:native("dh_unload_buffer") static function unloadBuffer(buffer:NativeBuffer):Void; 

    @:native("dh_load_texture_from_bytes") static function loadTextureFromBytes(data:VoidPointer, width:Int, height:Int, format:Int):NativeTexture;
    @:native("dh_load_texture_from_file") static function loadTextureFromFile(file:String):NativeTexture;
    @:native("dh_unload_texture") static function unloadTexture(texture:NativeTexture):Void;

    @:native("dh_load_sampler") static function loadSampler():NativeSampler;
    @:native("dh_unload_sampler") static function unloadSampler(sampler:NativeSampler):Void;

    @:native("dh_load_shader_from_bytes") static function loadShaderFromBytes(data:VoidPointer, size:Int, stage:Int, samplerCount:Int, uniformBufferCount:Int, storageBufferCount:Int, storageTextureCount:Int):NativeShader;
    @:native("dh_load_shader_from_file") static function loadShaderFromFile(file:String, stage:Int, samplerCount:Int, uniformBufferCount:Int, storageBufferCount:Int, storageTextureCount:Int):NativeShader;
    @:native("dh_unload_shader") static function unloadShader(shader:NativeShader):Void;

    @:native("dh_set_vertex_data_size") static function setVertexDataSize(size:Int):Void;
    @:native("dh_add_vertex_attribute") static function addVertexAttribute(elementFormat:Int, location:Int, offset:Int):Void;
    @:native("dh_load_graphics_pipeline") static function loadGraphicsPipeline(vertex:NativeShader, fragment:NativeShader):NativeGraphicsPipeline;
    @:native("dh_unload_graphics_pipeline") static function unloadGraphicsPipeline(pipeline:NativeGraphicsPipeline):Void;

    @:native("dh_set_graphics_pipeline") static function setGraphicsPipeline(pipeline:NativeGraphicsPipeline):Void;

    @:native("dh_set_vertex_buffer") static function setVertexBuffer(buffer:NativeBuffer):Void;
    @:native("dh_set_index_buffer") static function setIndexBuffer(buffer:NativeBuffer):Void;

    @:native("dh_set_vertex_uniform_data") static function setVertexUniformData(slot:Int, data:VoidPointer, size:Int):Void;
    @:native("dh_set_fragment_uniform_data") static function setFragmentUniformData(slot:Int, data:VoidPointer, size:Int):Void;
    @:native("dh_set_fragment_sampler") static function setFragmentSampler(texture:NativeTexture, sampler:NativeSampler):Void;

    @:native("dh_draw_primitives") static function drawPrimitives(vertices:Int, instances:Int):Void;
    @:native("dh_draw_indexed_primitives") static function drawIndexedPrimitives(indices:Int, instances:Int):Void;
}
