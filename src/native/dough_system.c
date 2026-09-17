#include "dough_internal.h"

// Multiple windows? 
// You don't even use that feature.
// I had the idea to use it for a bug tracker
// like the one I saw on Supergiant Games' Hades documentary.
// On another note, is that how the " ' " is used there?

static int window_counter = 0;
static bool dh_app_created = false;
dh_internal_application dh_app;

int dh_create_window(int width, int height, const char* title, bool debug) {
    if(!dh_app_created) {
        dh_app = (dh_internal_application) {0};
        dh_app_created = true;
        dh_app.debug = debug;
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
    window.window_flags = 0;

    if(!SDL_Init(SDL_INIT_VIDEO)) {
        SDL_Log("Failed to load SDL: %s", SDL_GetError());
    }

    int window_flags = SDL_WINDOW_OPENGL; 
    window.sdl_window = SDL_CreateWindow(window.window_title, window.window_width, window.window_height, window_flags);
    if(window.sdl_window == NULL) {
        SDL_Log("Failed to create window: %s", SDL_GetError());
    }
    window.sdl_window_id = SDL_GetWindowID(window.sdl_window);
    window.is_running = true;

    if(!dh_app.gpu_device_created) {
        dh_app.gpu_device = SDL_CreateGPUDevice(SDL_GPU_SHADERFORMAT_SPIRV | SDL_GPU_SHADERFORMAT_MSL | SDL_GPU_SHADERFORMAT_DXIL, dh_app.debug, NULL);
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
    SDL_Rect rect = {0};
    SDL_GetDisplayUsableBounds(display, &rect);
    int x = rect.x + ((rect.w - dh_app.windows[window_id].window_width) / 2);
    int y = rect.y + ((rect.h - dh_app.windows[window_id].window_height) / 2);
    return SDL_SetWindowPosition(dh_app.windows[window_id].sdl_window, x, y);
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
    // SDL_SetWindowFullscreenMode
    return SDL_SetWindowFullscreen(dh_app.windows[window_id].sdl_window, dh_app.windows[window_id].is_fullscreen);
}

bool dh_is_window_minimized(int window_id) {
    return dh_app.windows[window_id].is_minimized; 
}

bool dh_minimize_window(int window_id) {
    return SDL_MinimizeWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_is_window_maximized(int window_id) {
    return dh_app.windows[window_id].is_maximized;
}

bool dh_maximize_window(int window_id) {
    return SDL_MaximizeWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_restore_window(int window_id) {
    return SDL_RestoreWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_raise_window(int window_id) {
    return SDL_RaiseWindow(dh_app.windows[window_id].sdl_window);
}

bool dh_is_window_resizable(int window_id) {
    return dh_app.windows[window_id].is_resizable;
}

bool dh_set_window_resizable(int window_id, bool resizable) {
    dh_app.windows[window_id].is_resizable = resizable;
    return SDL_SetWindowResizable(dh_app.windows[window_id].sdl_window, resizable);
}

bool dh_was_window_resized(int window_id) {
    return dh_app.windows[window_id].was_resized;
}

bool dh_is_window_focused(int window_id) {
    return dh_app.windows[window_id].is_focused;
}

bool dh_focus_window(int window_id) {
    SDL_RaiseWindow(dh_app.windows[window_id].sdl_window);
    return true;
}

// TODO: Is there anything wrong with these two functions?
// IDK
bool dh_poll_window_events() {
    dh_app.new_ticks = SDL_GetTicks();
    dh_app.frame_time = ((double)(dh_app.new_ticks - dh_app.last_ticks)) / 1000;
    dh_app.last_ticks = dh_app.new_ticks;
    return SDL_PollEvent(&dh_app.event);
}

void dh_handle_window_events(int window_id) {
    dh_app.windows[window_id].was_resized = false;
    for(int i = 0; i <= 512; i++) dh_app.previous_key_state[i] = dh_app.current_key_state[i]; 
    for(int i = 0; i <= 4; i++) dh_app.previous_mouse_state[i] = dh_app.current_mouse_state[i]; 

    if(dh_app.event.window.windowID == dh_app.windows[window_id].sdl_window_id) {
        switch(dh_app.event.type) {
            case SDL_EVENT_QUIT:
                dh_app.exit = true;
            case SDL_EVENT_WINDOW_CLOSE_REQUESTED:
                dh_app.windows[window_id].is_running = false;
            case SDL_EVENT_KEY_DOWN:
                dh_app.current_key_state[dh_app.event.key.scancode] = true;
            case SDL_EVENT_KEY_UP:
                dh_app.current_key_state[dh_app.event.key.scancode] = false;
            case SDL_EVENT_MOUSE_BUTTON_DOWN:
                dh_app.current_mouse_state[dh_app.event.button.button] = true;
            case SDL_EVENT_MOUSE_BUTTON_UP:
                dh_app.current_mouse_state[dh_app.event.button.button] = false;
            case SDL_EVENT_MOUSE_WHEEL:
                dh_app.current_mouse_wheel_delta_x = dh_app.event.wheel.x;
                dh_app.current_mouse_wheel_delta_y = dh_app.event.wheel.y;
            case SDL_EVENT_MOUSE_MOTION:
                dh_app.current_mouse_x = dh_app.event.motion.x;
                dh_app.current_mouse_y = dh_app.event.motion.y;
            case SDL_EVENT_WINDOW_RESIZED:
                if(dh_app.event.window.data1 > 0 || dh_app.event.window.data2 > 0) dh_app.windows[window_id].was_resized = true;
            case SDL_EVENT_WINDOW_FOCUS_GAINED:
                dh_app.windows[window_id].is_focused = true;
            case SDL_EVENT_WINDOW_FOCUS_LOST:
                dh_app.windows[window_id].is_focused = false;
            default:
                break;
        }
    } 
}

bool dh_is_cursor_shown() {
    return SDL_CursorVisible();
}

void dh_show_cursor() {
    SDL_ShowCursor();
}

void dh_lock_cursor(int window_id) {
    SDL_SetWindowMouseGrab(dh_app.windows[window_id].sdl_window, true);
}

void dh_unlock_cursor(int window_id) {
    SDL_SetWindowMouseGrab(dh_app.windows[window_id].sdl_window, false);
}

void dh_set_clipboard_text(const char* text) {
    SDL_SetClipboardText(text);
}

const char* dh_get_clipboard_text() {
    return SDL_GetClipboardText();
}

double dh_get_frame_time() {
    return dh_app.frame_time;
}

double dh_get_elapsed_time() {
    return -1;
}

bool dh_is_key_down(int key) {
    return dh_app.current_key_state[key];
}

bool dh_is_key_just_down(int key) {
    return dh_app.previous_key_state[key] == false && dh_app.current_key_state[key] == true;
}

bool dh_is_key_released(int key) {
    return dh_app.previous_key_state[key] == true && dh_app.current_key_state[key] == false;
}

// TODO: Gamepads

bool dh_is_mouse_button_down(int button) {
    return dh_app.current_mouse_state[button];
}

bool dh_is_mouse_button_just_down(int button) {
    return dh_app.previous_mouse_state[button] == false && dh_app.current_key_state[button] == true;
}

bool dh_is_mouse_button_released(int button) {
    return dh_app.previous_mouse_state[button] == true && dh_app.current_key_state[button] == false;
}

int dh_get_mouse_position_x() {
    return dh_app.current_mouse_x;
}

int dh_get_mouse_position_y() {
    return dh_app.current_mouse_y;
}

void dh_set_mouse_position(int window_id, int x, int y) {
    SDL_WarpMouseInWindow(dh_app.windows[window_id].sdl_window, x, y);
}

float dh_get_mouse_wheel_movement_x() {
    return dh_app.current_mouse_wheel_delta_x;
}

float dh_get_mouse_wheel_movement_y() {
    return dh_app.current_mouse_wheel_delta_y;
}

void dh_set_mouse_cursor(int cursor) {
}
