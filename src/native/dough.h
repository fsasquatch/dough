#include <stdbool.h>
#include "SDL3/SDL.h"

// TODO: SDL_Log callback to dough logging function
// TODO: Better error handling in dough_window.c

#ifndef DOUGH_H
#define DOUGH_H

int dh_create_window(int width, int height, const char* title, bool debug);
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
bool dh_is_window_minimized(int window_id);
bool dh_minimize_window(int window_id);
bool dh_is_window_maximized(int window_id);
bool dh_maximize_window(int window_id);
bool dh_restore_window(int window_id);
bool dh_raise_window(int window_id);
bool dh_is_window_resizable(int window_id);
bool dh_set_window_resizable(int window_id, bool resizable);
bool dh_was_window_resized(int window_id);
bool dh_is_window_focused(int window_id);
bool dh_focus_window(int window_id);
// bool dh_set_window_icon();
bool dh_poll_window_events();
void dh_handle_window_events(int window_id);

bool dh_is_cursor_shown();
void dh_show_cursor();
void dh_hide_cursor();
void dh_lock_cursor(int window_id);
void dh_unlock_cursor(int window_id);

void dh_set_clipboard_text(const char* text);
const char* dh_get_clipboard_text();

double dh_get_frame_time();
double dh_get_elapsed_time();

bool dh_is_key_down(int key);
bool dh_is_key_just_down(int key);
bool dh_is_key_released(int key);

bool dh_is_gamepad_available(int gamepad);
const char* dh_get_gamepad_name(int gamepad);
bool dh_is_gamepad_button_down(int gamepad, int button);
bool dh_is_gamepad_button_just_down(int gamepad, int button);
bool dh_is_gamepad_button_released(int gamepad, int button);
int dh_get_gamepad_axis_count(int gamepad);
float dh_get_gamepad_axis_movement(int gamepad, int axis);
void dh_set_gamepad_vibration(int gamepad, float left_motor, float right_motor, float duration_sec);

bool dh_is_mouse_button_down(int button);
bool dh_is_mouse_button_just_down(int button);
bool dh_is_mouse_button_released(int button);

int dh_get_mouse_position_x();
int dh_get_mouse_position_y();
void dh_set_mouse_position(int window_id, int x, int y);
float dh_get_mouse_wheel_movement_x();
float dh_get_mouse_wheel_movement_y();
void dh_set_mouse_cursor(int cursor);

void dh_begin_render();
void dh_end_render();
void dh_set_clear_color(float r, float g, float b, float a);
void dh_begin_render_pass(int window_id, int render_pass_id);
void dh_end_render_pass(int render_pass_id);

void dh_begin_copy_pass();
void dh_end_copy_pass();

SDL_GPUBuffer* dh_load_vertex_buffer(void* data, int size);
SDL_GPUBuffer* dh_load_index_buffer(void* data, int size);
void dh_unload_buffer(SDL_GPUBuffer* buffer);

SDL_GPUTexture* dh_load_texture_from_bytes(void* data, int width, int height, int format);
SDL_GPUTexture* dh_load_texture_from_file(const char* file);
void dh_unload_texture(SDL_GPUTexture* texture);

SDL_GPUSampler* dh_load_sampler();
void dh_unload_sampler(SDL_GPUSampler* sampler);

SDL_GPUShader* dh_load_shader_from_bytes(void* data, int size, int stage, Uint32 sampler_count, Uint32 uniform_buffer_count, Uint32 storage_buffer_count, Uint32 storage_texture_count);
SDL_GPUShader* dh_load_shader_from_file(const char* file, int stage, Uint32 sampler_count, Uint32 uniform_buffer_count, Uint32 storage_buffer_count, Uint32 storage_texture_count);
void dh_unload_shader(SDL_GPUShader* shader);

void dh_set_vertex_data_size(int size);
void dh_add_vertex_attribute(int element_format, int location, int offset);
SDL_GPUGraphicsPipeline* dh_load_graphics_pipeline(SDL_GPUShader* vertex_shader, SDL_GPUShader* fragment_shader);
void dh_unload_graphics_pipeline(SDL_GPUGraphicsPipeline* pipeline);

void dh_set_graphics_pipeline(SDL_GPUGraphicsPipeline* pipeline);

void dh_set_vertex_buffer(SDL_GPUBuffer* vertex_buffer);
void dh_set_index_buffer(SDL_GPUBuffer* index_buffer);

void dh_set_vertex_uniform_data(int slot, void* data, int size); 
void dh_set_fragment_uniform_data(int slot, void* data, int size);
void dh_set_fragment_sampler(SDL_GPUTexture* texture, SDL_GPUSampler* sampler); 

void dh_draw_primitives(int vertices, int instances);
void dh_draw_indexed_primitives(int indices, int instances);

#endif
