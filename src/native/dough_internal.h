#include "dough.h"
#include "dough_utils.h"
#include "SDL3/SDL.h"
#include <stdbool.h>

#ifndef DOUGH_INTERNAL_H
#define DOUGH_INTERNAL_H

#define DH_MAX_WINDOWS 12
#define DH_MAX_RENDERPASS 8

typedef struct dh_internal_window {
    int window_width, window_height;
    const char* window_title;
    int window_flags;

    bool is_running;
    bool is_resizable;
    bool is_fullscreen;
    bool is_maximized;
    bool is_minimized;
    bool is_focused;
    bool was_resized;

    SDL_Window* sdl_window;
    SDL_WindowID sdl_window_id;
} dh_internal_window;

typedef struct dh_internal_application {
    dh_internal_window windows[DH_MAX_WINDOWS];
    bool exit;

    bool debug;

    Uint64 last_ticks;
    Uint64 new_ticks;
    double frame_time;
    int window_fps_cap;
    bool is_fps_capped;

    bool current_key_state[512];
    bool previous_key_state[512];

    bool current_mouse_state[4];
    bool previous_mouse_state[4];
    int current_mouse_x;
    int current_mouse_y;
    float current_mouse_wheel_delta_x;
    float current_mouse_wheel_delta_y;

    
    SDL_Event event;
    
    bool gpu_device_created;
    SDL_GPUDevice* gpu_device;
    SDL_GPUTexture* swapchain_tex;
    SDL_GPUTexture* depth_texture;
    SDL_GPUCommandBuffer* command_buffer;
    SDL_GPUCopyPass* copy_pass;
    SDL_GPURenderPass* render_passes[DH_MAX_RENDERPASS];
    int active_render_pass;
    dh_array current_vertex_attribs;
} dh_internal_application;

#endif
