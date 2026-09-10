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
    bool is_fullscreen;
    bool is_maximized;
    bool is_minimized;
    bool is_focused;

    SDL_Window* sdl_window;
    SDL_WindowID sdl_window_id;
} dh_internal_window;

typedef struct dh_internal_application {
    dh_internal_window windows[DH_MAX_WINDOWS];
    bool exit;

    bool enable_log_debug;
    bool enable_gpu_debug;

    Uint64 last_ticks;
    Uint64 new_ticks;
    double frame_time;

    bool current_key_state[512];
    bool previous_key_state[512];

    SDL_Event event;
    
    bool gpu_device_created;
    SDL_GPUDevice* gpu_device;
    SDL_GPUTexture* swapchain_tex;
    SDL_GPUCommandBuffer* command_buffer;
    SDL_GPUCopyPass* copy_pass;
    SDL_GPURenderPass* render_passes[DH_MAX_RENDERPASS];
    int active_render_pass;
    dh_array current_vertex_attribs;
} dh_internal_application;

#endif
