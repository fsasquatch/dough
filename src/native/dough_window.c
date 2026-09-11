#include "SDL3/SDL_gpu.h"
#include "dough_internal.h"

// Multiple windows? 
// You don't even use that feature.
// I had the idea to use it for a bug tracker
// like the one I saw on Supergiant Games' Hades documentary.
// On another note, is that how the " ' " is used there?

static int window_counter = 0;
static bool dh_app_created = false;
dh_internal_application dh_app;

int dh_create_window(int width, int height, const char* title, int flags) {
    if(!dh_app_created) {
        dh_app = (dh_internal_application) {0};
        dh_app_created = true;
        // TODO: i hate myself fix this? move this?
        dh_init_array(&(dh_app.current_vertex_attribs), sizeof(SDL_GPUVertexAttribute), 3);
    }

    if(window_counter > DH_MAX_WINDOWS) {
        SDL_Log("Cannot create more than %d windows. To increase it change the define in dough_internal.h and recompile the library.", DH_MAX_WINDOWS);
        return -1;
    }

    int window_id = window_counter;
    window_counter++;

    dh_internal_window window = {0}; 
    window.window_width = width;
    window.window_height = height;
    window.window_title = title;
    window.window_flags = flags;

    if(!SDL_Init(SDL_INIT_VIDEO)) {
        SDL_Log("Failed to load SDL: %s", SDL_GetError());
    }

    window.sdl_window = SDL_CreateWindow(window.window_title, window.window_width, window.window_height, 0);
    if(window.sdl_window == NULL) {
        SDL_Log("Failed to create window: %s", SDL_GetError());
    }
    window.sdl_window_id = SDL_GetWindowID(window.sdl_window);
    window.is_running = true;

    dh_app.enable_gpu_debug = true; // TODO: Make this a flag?
    if(!dh_app.gpu_device_created) {
        dh_app.gpu_device = SDL_CreateGPUDevice(SDL_GPU_SHADERFORMAT_SPIRV | SDL_GPU_SHADERFORMAT_MSL | SDL_GPU_SHADERFORMAT_DXIL, dh_app.enable_gpu_debug, NULL);
        dh_app.gpu_device_created = true;
    }
    if(dh_app.gpu_device == NULL) {
        SDL_Log("Failed to create GPU device: %s", SDL_GetError());
    }
    if(!SDL_ClaimWindowForGPUDevice(dh_app.gpu_device, window.sdl_window)) {
        SDL_Log("Failed to claim window for GPU device: %s", SDL_GetError());
    }

    // TODO: Implement switching between SDR, SDR_LINEAR, HDR
    SDL_GPUPresentMode presentMode = SDL_WindowSupportsGPUPresentMode(dh_app.gpu_device, window.sdl_window, SDL_GPU_PRESENTMODE_MAILBOX) ? SDL_GPU_PRESENTMODE_MAILBOX : SDL_GPU_PRESENTMODE_VSYNC;
    SDL_SetGPUSwapchainParameters(dh_app.gpu_device, window.sdl_window, SDL_GPU_SWAPCHAINCOMPOSITION_SDR, presentMode);

    dh_app.last_ticks = SDL_GetTicks(); // Does this need to be here?

    dh_app.windows[window_id] = window;
    return window_id;
}

void dh_destroy_window(int window_id) {
    SDL_WaitForGPUIdle(dh_app.gpu_device);

    if(dh_app.windows[window_id].sdl_window != NULL) {
        SDL_ReleaseWindowFromGPUDevice(dh_app.gpu_device, dh_app.windows[window_id].sdl_window);
        SDL_DestroyWindow(dh_app.windows[window_id].sdl_window);
    }
    // Should the array element be removed now?
    // Is that even a thing in c? I should learn c properly tbh
    // Or use a nicer c-like language :thonk:
    // Zig and Rust really look really good...

    if(dh_app.exit) {
        for(int i = 0;i<=DH_MAX_WINDOWS;i++) {
            if(dh_app.windows[i].sdl_window != NULL) {
                SDL_ReleaseWindowFromGPUDevice(dh_app.gpu_device, dh_app.windows[i].sdl_window);
                SDL_DestroyWindow(dh_app.windows[i].sdl_window);
            }
        }

        dh_free_array(&(dh_app.current_vertex_attribs));
        SDL_DestroyGPUDevice(dh_app.gpu_device);
        SDL_Quit();
    }
}

bool dh_is_window_running(int window_id) {
    return dh_app.windows[window_id].is_running;
}

int dh_get_window_width(int window_id) {
    return dh_app.windows[window_id].window_width;
}

int dh_get_window_height(int window_id) {
    return dh_app.windows[window_id].window_height;
}

bool dh_set_window_size(int window_id, int width, int height) {
    return SDL_SetWindowSize(dh_app.windows[window_id].sdl_window, width, height);
}

// IDK if this really works or the variable vanishes because of scope.
int dh_get_window_x(int window_id) {
    int x, y = 0;
    SDL_GetWindowPosition(dh_app.windows[window_id].sdl_window, &x, &y);
    return x; 
}

int dh_get_window_y(int window_id) {
    int x, y = 0;
    SDL_GetWindowPosition(dh_app.windows[window_id].sdl_window, &x, &y);
    return y; 
}

bool dh_set_window_position(int window_id, int x, int y) {
    return SDL_SetWindowPosition(dh_app.windows[window_id].sdl_window, x, y);
}

// Does this work? Lots of stuff in this codebase I'm unsure of if they work...
int dh_get_current_display(int window_id) {
    return SDL_GetDisplayForWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_set_current_display(int window_id, int display) {
    // TODO: Implement this
    // https://lazyfoo.net/tutorials/SDL/36_multiple_windows/index.php
    return false;
}

int dh_get_primary_display() {
    if(dh_app.gpu_device == NULL) SDL_Log("f");
    return SDL_GetPrimaryDisplay();
}

bool dh_is_window_fullscreen(int window_id) {
    return dh_app.windows[window_id].is_fullscreen;
}

// TODO: Exclusive fullscreen mode
// Currently it always defaults to borderless
bool dh_toggle_fullscreen(int window_id, bool borderless) {
    dh_app.windows[window_id].is_fullscreen = !dh_app.windows[window_id].is_fullscreen;
    return SDL_SetWindowFullscreen(dh_app.windows[window_id].sdl_window, dh_app.windows[window_id].is_fullscreen);
}

bool dh_is_window_minimized(int window_id) {
    return dh_app.windows[window_id].is_minimized; 
}

bool dh_minimize_window(int window_id) {
    return SDL_MinimizeWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_maximize_window(int window_id) {
    return SDL_MaximizeWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_raise_window(int window_id) {
    return SDL_RaiseWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_poll_window_events() {
    return SDL_PollEvent(&dh_app.event);
}

// TODO: There must a better way to handle this
void dh_handle_window_events(int window_id) {
    if(dh_app.event.window.windowID == dh_app.windows[window_id].sdl_window_id) {
        switch(dh_app.event.type) {
            case SDL_EVENT_QUIT:
                dh_app.exit = true;
            case SDL_EVENT_WINDOW_CLOSE_REQUESTED:
                dh_app.windows[window_id].is_running = false;
            default:
                break;
        }
    } 
}
