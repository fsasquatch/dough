#include <stdbool.h>
#include "SDL3/SDL.h"

// TODO: Window focus + internal variables for window min & max
// TODO: SDL_Log callback to dough logging function
// TODO: Better error handling in dough_window.c

// TODO: [Feature] Allow for use with other rendering apis?

#ifndef DOUGH_H
#define DOUGH_H

int dh_create_window(int width, int height, const char* title, int flags);
void dh_destroy_window(int window_id);
bool dh_is_window_running(int window_id);
int dh_get_window_width(int window_id);
int dh_get_window_height(int window_id);
bool dh_set_window_size(int window_id, int width, int height);
int dh_get_window_x(int window_id);
int dh_get_window_y(int window_id);
bool dh_set_window_position(int window_id, int x, int y);
int dh_get_current_display(int window_id);
bool dh_set_current_display(int window_id, int display);
int dh_get_primary_display();
bool dh_is_window_fullscreen(int window_id);
bool dh_toggle_fullscreen(int window_id, bool borderless);
bool dh_is_window_minized(int window_id);
bool dh_minimize_window(int window_id);
bool dh_is_window_maximized(int window_id);
bool dh_maximize_window(int window_id);
bool dh_raise_window(int window_id);
bool dh_is_window_focused(int window_id);
// bool dh_set_window_icon();
bool dh_poll_window_events();
void dh_handle_window_events(int window_id);

void dh_begin_command_buffer();
void dh_end_command_buffer();
void dh_acquire_swapchain_texture(int window_id);
void dh_begin_render_pass(int render_pass_id);
void dh_end_render_pass(int render_pass_id);

SDL_GPUShader* dh_load_shader(const char* file, int type);
void dh_unload_shader(SDL_GPUShader* shader);

#endif
