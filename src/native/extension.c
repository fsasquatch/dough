#define HL_NAME(n) dough_##n

#include <hl.h>
#include "dough.h"

// A note for future me
// You can pass SDL_GPUShader* as _ABSTRACT(sdl_gpushader)
// and on the haxe side typedef BackendShader = hl.Abstract<"sdl_gpushader">;

// dough_window.c

HL_PRIM int HL_NAME(create_window)(int width, int height, vstring* title, int flags) {
    return dh_create_window(width, height, hl_to_utf8(title->bytes), flags);
}
DEFINE_PRIM(_I32, create_window, _I32 _I32 _STRING _I32);

HL_PRIM void HL_NAME(destroy_window)(int window_id) {
   dh_destroy_window(window_id);
}
DEFINE_PRIM(_VOID, destroy_window, _I32);

HL_PRIM bool HL_NAME(is_window_running)(int window_id) {
    return dh_is_window_running(window_id);
}
DEFINE_PRIM(_BOOL, is_window_running, _I32);

HL_PRIM int HL_NAME(get_window_width)(int window_id) {
    return dh_get_window_width(window_id);
}
DEFINE_PRIM(_I32, get_window_width, _I32);

HL_PRIM int HL_NAME(get_window_height)(int window_id) {
    return dh_get_window_height(window_id);
}
DEFINE_PRIM(_I32, get_window_height, _I32);

HL_PRIM bool HL_NAME(set_window_size)(int window_id, int width, int height) {
    return dh_set_window_size(window_id, width, height);
}
DEFINE_PRIM(_BOOL, set_window_size, _I32 _I32 _I32);

HL_PRIM int HL_NAME(get_window_x)(int window_id) {
    return dh_get_window_x(window_id);
}
DEFINE_PRIM(_I32, get_window_x, _I32);

HL_PRIM int HL_NAME(get_window_y)(int window_id) {
    return dh_get_window_y(window_id);
}
DEFINE_PRIM(_I32, get_window_y, _I32);

HL_PRIM bool HL_NAME(set_window_position)(int window_id, int x, int y) {
    return dh_set_window_position(window_id, x, y);
}
DEFINE_PRIM(_BOOL, set_window_position, _I32 _I32 _I32);

HL_PRIM int HL_NAME(get_current_display)(int window_id) {
    return dh_get_current_display(window_id);
}
DEFINE_PRIM(_I32, get_current_display, _I32);

HL_PRIM bool HL_NAME(set_current_display)(int window_id, int display) {
    return dh_set_current_display(window_id, display);
}
DEFINE_PRIM(_BOOL, set_current_display, _I32 _I32);

HL_PRIM int HL_NAME(get_primary_display)() {
    return dh_get_primary_display();
}
DEFINE_PRIM(_I32, get_primary_display, _NO_ARG);

HL_PRIM bool HL_NAME(is_window_fullscreen)(int window_id) {
    return dh_is_window_fullscreen(window_id);
}
DEFINE_PRIM(_BOOL, is_window_fullscreen, _I32);

HL_PRIM bool HL_NAME(toggle_fullscreen)(int window_id, bool borderless) {
    return dh_toggle_fullscreen(window_id, borderless);
}
DEFINE_PRIM(_BOOL, toggle_fullscreen, _I32 _BOOL);

HL_PRIM bool HL_NAME(minimize_window)(int window_id) {
    return dh_minimize_window(window_id);
}
DEFINE_PRIM(_BOOL, minimize_window, _I32);

HL_PRIM bool HL_NAME(maximize_window)(int window_id) {
    return dh_maximize_window(window_id);
}
DEFINE_PRIM(_BOOL, maximize_window, _I32);

HL_PRIM bool HL_NAME(raise_window)(int window_id) {
    return dh_raise_window(window_id);
}
DEFINE_PRIM(_BOOL, raise_window, _I32);

HL_PRIM bool HL_NAME(poll_window_events)() {
    return dh_poll_window_events();
}
DEFINE_PRIM(_BOOL, poll_window_events, _NO_ARG);

HL_PRIM void HL_NAME(handle_window_events)(int window_id) {
    dh_handle_window_events(window_id);
}
DEFINE_PRIM(_VOID, handle_window_events, _I32);

// dough_gpu.c

HL_PRIM void HL_NAME(begin_command_buffer)() {
    dh_begin_command_buffer();
}
DEFINE_PRIM(_VOID, begin_command_buffer, _NO_ARG);

HL_PRIM void HL_NAME(end_command_buffer)() {
    dh_end_command_buffer();
}
DEFINE_PRIM(_VOID, end_command_buffer, _NO_ARG);

HL_PRIM void HL_NAME(acquire_swapchain_texture)(int window_id) {
    dh_acquire_swapchain_texture(window_id);
}
DEFINE_PRIM(_VOID, acquire_swapchain_texture, _I32);

HL_PRIM void HL_NAME(begin_render_pass)(int render_pass_id) {
    dh_begin_render_pass(render_pass_id);
}
DEFINE_PRIM(_VOID, begin_render_pass, _I32);

HL_PRIM void HL_NAME(end_render_pass)(int render_pass_id) {
    dh_end_render_pass(render_pass_id);
}
DEFINE_PRIM(_VOID, end_render_pass, _I32);
