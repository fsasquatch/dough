#include "ext_common.h"
#include <hl.h>

HL_PRIM int HL_NAME(create_window)(int width, int height, vstring* title, bool debug) {
    return dh_create_window(width, height, hl_to_utf8(title->bytes), debug);
}
DEFINE_PRIM(_I32, create_window, _I32 _I32 _STRING _BOOL);

HL_PRIM void HL_NAME(destroy_window)(int window_id) {
   dh_destroy_window(window_id);
}
DEFINE_PRIM(_VOID, destroy_window, _I32);

HL_PRIM bool HL_NAME(is_window_running)(int window_id) {
    return dh_is_window_running(window_id);
}
DEFINE_PRIM(_BOOL, is_window_running, _I32);

HL_PRIM void HL_NAME(set_window_running)(int window_id, bool running) {
    dh_set_window_running(window_id, running);
}
DEFINE_PRIM(_VOID, set_window_running, _I32 _I32);

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

HL_PRIM bool HL_NAME(is_window_minimized)(int window_id) {
    return dh_is_window_minimized(window_id);
}
DEFINE_PRIM(_BOOL, is_window_minimized, _I32);

HL_PRIM bool HL_NAME(minimize_window)(int window_id) {
    return dh_minimize_window(window_id);
}
DEFINE_PRIM(_BOOL, minimize_window, _I32);

HL_PRIM bool HL_NAME(is_window_maximized)(int window_id) {
    return dh_is_window_maximized(window_id);
}
DEFINE_PRIM(_BOOL, is_window_maximized, _I32);

HL_PRIM bool HL_NAME(maximize_window)(int window_id) {
    return dh_maximize_window(window_id);
}
DEFINE_PRIM(_BOOL, maximize_window, _I32);

HL_PRIM bool HL_NAME(restore_window)(int window_id) {
    return dh_restore_window(window_id);
}
DEFINE_PRIM(_BOOL, restore_window, _I32);

HL_PRIM bool HL_NAME(raise_window)(int window_id) {
    return dh_raise_window(window_id);
}
DEFINE_PRIM(_BOOL, raise_window, _I32);

HL_PRIM bool HL_NAME(is_window_resizable)(int window_id) {
    return dh_is_window_resizable(window_id);
}
DEFINE_PRIM(_BOOL, is_window_resizable, _I32);

HL_PRIM bool HL_NAME(set_window_resizable)(int window_id, bool resizable) {
    return dh_set_window_resizable(window_id, resizable);
}
DEFINE_PRIM(_BOOL, set_window_resizable, _I32 _BOOL);

HL_PRIM bool HL_NAME(was_window_resized)(int window_id) {
    return dh_was_window_resized(window_id);
}
DEFINE_PRIM(_BOOL, was_window_resized, _I32);

HL_PRIM bool HL_NAME(is_window_focused)(int window_id) {
    return dh_is_window_focused(window_id);
}
DEFINE_PRIM(_BOOL, is_window_focused, _I32);

HL_PRIM bool HL_NAME(focus_window)(int window_id) {
    return dh_focus_window(window_id);
}
DEFINE_PRIM(_BOOL, focus_window, _I32);

HL_PRIM bool HL_NAME(poll_window_events)() {
    return dh_poll_window_events();
}
DEFINE_PRIM(_BOOL, poll_window_events, _NO_ARG);

HL_PRIM void HL_NAME(handle_window_events)(int window_id) {
    dh_handle_window_events(window_id);
}
DEFINE_PRIM(_VOID, handle_window_events, _I32);

HL_PRIM void HL_NAME(handle_input_events)() {
    dh_handle_input_events();
}
DEFINE_PRIM(_VOID, handle_input_events, _NO_ARG);

HL_PRIM void HL_NAME(set_fps_cap)(int fps) {
    dh_set_fps_cap(fps);
}
DEFINE_PRIM(_VOID, set_fps_cap, _I32);

HL_PRIM void HL_NAME(enable_fps_cap)() {
    dh_enable_fps_cap();
}
DEFINE_PRIM(_VOID, enable_fps_cap, _NO_ARG);

HL_PRIM void HL_NAME(disable_fps_cap)() {
    dh_disable_fps_cap();
}
DEFINE_PRIM(_VOID, disable_fps_cap, _NO_ARG);

HL_PRIM bool HL_NAME(is_fps_capped)() {
    return dh_is_fps_capped(); 
}
DEFINE_PRIM(_BOOL, is_fps_capped, _NO_ARG);

HL_PRIM bool HL_NAME(is_cursor_shown)() {
    return dh_is_cursor_shown();
}
DEFINE_PRIM(_BOOL, is_cursor_shown, _NO_ARG);

HL_PRIM void HL_NAME(show_cursor)() {
    dh_show_cursor();
}
DEFINE_PRIM(_VOID, show_cursor, _NO_ARG);

HL_PRIM void HL_NAME(hide_cursor)() {
    dh_hide_cursor();
}
DEFINE_PRIM(_VOID, hide_cursor, _NO_ARG);

HL_PRIM void HL_NAME(lock_cursor)(int window_id) {
    dh_lock_cursor(window_id);
}
DEFINE_PRIM(_VOID, lock_cursor, _I32);

HL_PRIM void HL_NAME(unlock_cursor)(int window_id) {
    dh_unlock_cursor(window_id);
}
DEFINE_PRIM(_VOID, unlock_cursor, _I32);

HL_PRIM void HL_NAME(set_clipboard_text)(vstring* text) {
    dh_set_clipboard_text(hl_to_utf8(text->bytes));
}
DEFINE_PRIM(_VOID, set_clipboard_text, _STRING);

HL_PRIM vbyte* HL_NAME(get_clipboard_text)() {
    const uchar* utext = (uchar *)dh_get_clipboard_text();

    hl_buffer* b = hl_alloc_buffer();
    hl_buffer_str(b, utext);
    vbyte* string = (vbyte *)hl_buffer_content(b, NULL);

    return string;
}
DEFINE_PRIM(_BYTES, get_clipboard_text, _NO_ARG);

HL_PRIM double HL_NAME(get_frame_time)() {
    return dh_get_frame_time(); 
}
DEFINE_PRIM(_F64, get_frame_time, _NO_ARG);

HL_PRIM double HL_NAME(get_elapsed_time)() {
    return dh_get_elapsed_time();
}
DEFINE_PRIM(_F64, get_elapsed_time, _NO_ARG);

HL_PRIM bool HL_NAME(is_key_down)(int key) {
    return dh_is_key_down(key);
}
DEFINE_PRIM(_BOOL, is_key_down, _I32);

HL_PRIM bool HL_NAME(is_key_just_down)(int key) {
    return dh_is_key_just_down(key);
}
DEFINE_PRIM(_BOOL, is_key_just_down, _I32);

HL_PRIM bool HL_NAME(is_key_released)(int key) {
    return dh_is_key_released(key);
}
DEFINE_PRIM(_BOOL, is_key_released, _I32);

// GAMEPADS

HL_PRIM bool HL_NAME(is_mouse_button_down)(int button) {
    return dh_is_mouse_button_down(button);
}
DEFINE_PRIM(_BOOL, is_mouse_button_down, _I32);

HL_PRIM bool HL_NAME(is_mouse_button_just_down)(int button) {
    return dh_is_mouse_button_just_down(button);
}
DEFINE_PRIM(_BOOL, is_mouse_button_just_down, _I32);

HL_PRIM bool HL_NAME(is_mouse_button_released)(int button) {
    return dh_is_mouse_button_released(button);
}
DEFINE_PRIM(_BOOL, is_mouse_button_released, _I32);

HL_PRIM int HL_NAME(get_mouse_position_x)() {
    return dh_get_mouse_position_x();
}
DEFINE_PRIM(_I32, get_mouse_position_x, _NO_ARG);

HL_PRIM int HL_NAME(get_mouse_position_y)() {
    return dh_get_mouse_position_y();
}
DEFINE_PRIM(_I32, get_mouse_position_y, _NO_ARG);

HL_PRIM void HL_NAME(set_mouse_position)(int window_id, int x, int y) {
    dh_set_mouse_position(window_id, x, y);
}
DEFINE_PRIM(_VOID, set_mouse_position, _I32 _I32 _I32);

HL_PRIM float HL_NAME(get_mouse_wheel_movement_x)() {
    return dh_get_mouse_wheel_movement_x();
}
DEFINE_PRIM(_F32, get_mouse_wheel_movement_x, _NO_ARG);

HL_PRIM float HL_NAME(get_mouse_wheel_movement_y)() {
    return dh_get_mouse_wheel_movement_y();
}
DEFINE_PRIM(_F32, get_mouse_wheel_movement_y, _NO_ARG);

HL_PRIM void HL_NAME(set_mouse_cursor)(int cursor) {
    dh_set_mouse_cursor(cursor);
}
DEFINE_PRIM(_VOID, set_mouse_cursor, _I32);
