#include "dough_internal.h"

extern dh_internal_application dh_app;

void dh_begin_command_buffer() {
    dh_app.command_buf = SDL_AcquireGPUCommandBuffer(dh_app.gpu_device);
    if(dh_app.command_buf == NULL) {
        SDL_Log("Failed to acquire command buffer: %s", SDL_GetError());
    }
}

void dh_end_command_buffer() {
    SDL_SubmitGPUCommandBuffer(dh_app.command_buf);
}

void dh_acquire_swapchain_texture(int window_id) {
    if(!SDL_WaitAndAcquireGPUSwapchainTexture(dh_app.command_buf, dh_app.windows[window_id].sdl_window, &dh_app.swapchain_tex, NULL, NULL)) {
        SDL_Log("Failed to acquire swapchain texture: %s", SDL_GetError());
    }
}

void dh_begin_render_pass(int render_pass_id) {
    if(dh_app.swapchain_tex != NULL) {
        SDL_GPUColorTargetInfo colorTargetInfo = {0};
        colorTargetInfo.clear_color = (SDL_FColor) {1, 0, 0, 1};
        colorTargetInfo.texture = dh_app.swapchain_tex;
        colorTargetInfo.load_op =  SDL_GPU_LOADOP_CLEAR;
        colorTargetInfo.store_op = SDL_GPU_STOREOP_DONT_CARE;

        dh_app.render_passes[render_pass_id] = SDL_BeginGPURenderPass(dh_app.command_buf, &colorTargetInfo, 1, NULL);
    }
}

void dh_end_render_pass(int render_pass_id) {
    if(dh_app.swapchain_tex != NULL) SDL_EndGPURenderPass(dh_app.render_passes[render_pass_id]);
}
