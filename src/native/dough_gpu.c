// TODO: Error checks everywhere!

#include "dough_internal.h"
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

extern dh_internal_application dh_app;
int vertex_data_size = 0;
SDL_FColor clear_color = {0, 0, 0, 1};

void dh_begin_render() {
    dh_app.command_buffer = SDL_AcquireGPUCommandBuffer(dh_app.gpu_device);
    if(dh_app.command_buffer == NULL) {
        SDL_Log("Failed to acquire command buffer: %s", SDL_GetError());
    }
}

void dh_end_render() {
    SDL_SubmitGPUCommandBuffer(dh_app.command_buffer);
}

void dh_set_clear_color(float r, float g, float b, float a) {
    clear_color = (SDL_FColor){r, g, b, a};
}

void dh_begin_render_pass(int window_id, int render_pass_id) {
    if(!SDL_WaitAndAcquireGPUSwapchainTexture(dh_app.command_buffer, dh_app.windows[window_id].sdl_window, &dh_app.swapchain_tex, NULL, NULL)) {
        SDL_Log("Failed to acquire swapchain texture: %s", SDL_GetError());
    }
    if(dh_app.swapchain_tex != NULL) {
        SDL_GPUColorTargetInfo colorTargetInfo = {0};
        colorTargetInfo.clear_color = clear_color; 
        colorTargetInfo.texture = dh_app.swapchain_tex;
        colorTargetInfo.load_op =  SDL_GPU_LOADOP_CLEAR;
        colorTargetInfo.store_op = SDL_GPU_STOREOP_DONT_CARE;

        dh_app.render_passes[render_pass_id] = SDL_BeginGPURenderPass(dh_app.command_buffer, &colorTargetInfo, 1, NULL);
    }
    dh_app.active_render_pass = render_pass_id;
}

void dh_end_render_pass(int render_pass_id) {
    if(dh_app.swapchain_tex != NULL) SDL_EndGPURenderPass(dh_app.render_passes[render_pass_id]);
    dh_app.active_render_pass = -1;
}

void dh_begin_copy_pass() {
    dh_app.command_buffer = SDL_AcquireGPUCommandBuffer(dh_app.gpu_device);
    dh_app.copy_pass = SDL_BeginGPUCopyPass(dh_app.command_buffer);
}

void dh_end_copy_pass() {
    SDL_EndGPUCopyPass(dh_app.copy_pass);
    SDL_SubmitGPUCommandBuffer(dh_app.command_buffer);
}

// TODO: Cycling
// TODO: Packing vertex and index buffers into the same transfer buffer? 
// IDK if that is really necessary
SDL_GPUBuffer* dh_load_vertex_buffer(void* data, int size) {
    SDL_GPUBuffer* vertex_buffer = SDL_CreateGPUBuffer(dh_app.gpu_device, &(SDL_GPUBufferCreateInfo){
        .usage = SDL_GPU_BUFFERUSAGE_VERTEX,
        .size = size
    });

    SDL_GPUTransferBuffer* transfer_buffer = SDL_CreateGPUTransferBuffer(dh_app.gpu_device, &(SDL_GPUTransferBufferCreateInfo) {
        .usage = SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD,
        .size = size
    });

    void* transfer_data = SDL_MapGPUTransferBuffer(dh_app.gpu_device, transfer_buffer, false);
    SDL_memcpy(transfer_data, data, size);
    SDL_UnmapGPUTransferBuffer(dh_app.gpu_device, transfer_buffer);

    if(dh_app.copy_pass != NULL) {
        SDL_Log("copy pass active");
        SDL_UploadToGPUBuffer(dh_app.copy_pass, &(SDL_GPUTransferBufferLocation) {
            .transfer_buffer = transfer_buffer,
            .offset = 0
        }, &(SDL_GPUBufferRegion) {
            .buffer = vertex_buffer,
            .offset = 0,
            .size = size
        }, false);
    } else {
        dh_begin_copy_pass();
        SDL_Log("copy pass not active");
        SDL_UploadToGPUBuffer(dh_app.copy_pass, &(SDL_GPUTransferBufferLocation) {
            .transfer_buffer = transfer_buffer,
            .offset = 0
        }, &(SDL_GPUBufferRegion) {
            .buffer = vertex_buffer,
            .offset = 0,
            .size = size
        }, false);
        dh_end_copy_pass();
    }
    
    SDL_ReleaseGPUTransferBuffer(dh_app.gpu_device, transfer_buffer);

    return vertex_buffer;
}

SDL_GPUBuffer* dh_load_index_buffer(void* data, int size) {
    SDL_GPUBuffer* index_buffer = SDL_CreateGPUBuffer(dh_app.gpu_device, &(SDL_GPUBufferCreateInfo){
        .usage = SDL_GPU_BUFFERUSAGE_INDEX,
        .size = size
    });

    SDL_GPUTransferBuffer* transfer_buffer = SDL_CreateGPUTransferBuffer(dh_app.gpu_device, &(SDL_GPUTransferBufferCreateInfo) {
        .usage = SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD,
        .size = size
    });

    void* transfer_data = SDL_MapGPUTransferBuffer(dh_app.gpu_device, transfer_buffer, false);
    SDL_memcpy(transfer_data, data, size);
    SDL_UnmapGPUTransferBuffer(dh_app.gpu_device, transfer_buffer);

    if(dh_app.copy_pass != NULL) {
        SDL_UploadToGPUBuffer(dh_app.copy_pass, &(SDL_GPUTransferBufferLocation) {
            .transfer_buffer = transfer_buffer,
            .offset = 0
        }, &(SDL_GPUBufferRegion) {
            .buffer = index_buffer,
            .offset = 0,
            .size = size
        }, false);
    } else {
        dh_begin_copy_pass();
        SDL_UploadToGPUBuffer(dh_app.copy_pass, &(SDL_GPUTransferBufferLocation) {
            .transfer_buffer = transfer_buffer,
            .offset = 0
        }, &(SDL_GPUBufferRegion) {
            .buffer = index_buffer,
            .offset = 0,
            .size = size
        }, false);
        dh_end_copy_pass();
    }

    SDL_ReleaseGPUTransferBuffer(dh_app.gpu_device, transfer_buffer);
    
    return index_buffer;
}

void dh_unload_buffer(SDL_GPUBuffer* buffer) {
    SDL_ReleaseGPUBuffer(dh_app.gpu_device, buffer);
}

// TODO: Image formats
SDL_GPUTexture* dh_load_texture_from_bytes(void* data, int width, int height, int format) {
    SDL_GPUTexture* texture = SDL_CreateGPUTexture(dh_app.gpu_device, &(SDL_GPUTextureCreateInfo) {\
        .type = SDL_GPU_TEXTURETYPE_2D,
        .format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM,
        .usage = SDL_GPU_TEXTUREUSAGE_SAMPLER,
        .width = width,
        .height = height,
        .layer_count_or_depth = 1,
        .num_levels = 1
    });

    int size = width * height * 4; // 4 because 1byte per pixel in R8G8B8A8
    SDL_GPUTransferBuffer* transfer_buffer = SDL_CreateGPUTransferBuffer(dh_app.gpu_device, &(SDL_GPUTransferBufferCreateInfo) {
        .usage = SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD,
        .size = size 
    });

    void* transfer_data = SDL_MapGPUTransferBuffer(dh_app.gpu_device, transfer_buffer, false);
    SDL_memcpy(transfer_data, data, size);
    SDL_UnmapGPUTransferBuffer(dh_app.gpu_device, transfer_buffer);

    if(dh_app.copy_pass != NULL) {
        SDL_UploadToGPUTexture(dh_app.copy_pass, &(SDL_GPUTextureTransferInfo) {
            .transfer_buffer = transfer_buffer,
        }, &(SDL_GPUTextureRegion) {
            .texture = texture,
            .w = width,
            .h = height,
            .d = 1
        }, false);
    } else {
        dh_begin_copy_pass();
        SDL_UploadToGPUTexture(dh_app.copy_pass, &(SDL_GPUTextureTransferInfo) {
            .transfer_buffer = transfer_buffer,
        }, &(SDL_GPUTextureRegion) {
            .texture = texture,
            .w = width,
            .h = height,
            .d = 1
        }, false);
        dh_end_copy_pass();
    }

    SDL_ReleaseGPUTransferBuffer(dh_app.gpu_device, transfer_buffer);

    return texture;
}

SDL_GPUTexture* dh_load_texture_from_file(const char* file) {
    int image_width, image_height;
    stbi_set_flip_vertically_on_load(1);
    void* image_data = stbi_load(file, &image_width, &image_height, NULL, 4);
    return dh_load_texture_from_bytes(image_data, image_width, image_height, -1);
}

void dh_unload_texture(SDL_GPUTexture* texture) {
    SDL_ReleaseGPUTexture(dh_app.gpu_device, texture);
}

SDL_GPUSampler* dh_load_sampler() {
    SDL_GPUSampler* sampler = SDL_CreateGPUSampler(dh_app.gpu_device, &(SDL_GPUSamplerCreateInfo) {});
    return sampler;
}

void dh_unload_sampler(SDL_GPUSampler* sampler) {
    SDL_ReleaseGPUSampler(dh_app.gpu_device, sampler);
}

SDL_GPUShader* dh_load_shader_from_bytes(void* data, int size, int stage, Uint32 sampler_count, Uint32 uniform_buffer_count, Uint32 storage_buffer_count, Uint32 storage_texture_count) {
    SDL_GPUShaderStage s;
    if(stage == 0) s = SDL_GPU_SHADERSTAGE_VERTEX;
    else if(stage == 1) s = SDL_GPU_SHADERSTAGE_FRAGMENT;
    else {
        SDL_Log("Invalid shader stage");
        return NULL;
    }

    SDL_GPUShaderFormat backend_formats = SDL_GetGPUShaderFormats(dh_app.gpu_device);
    SDL_GPUShaderFormat format = SDL_GPU_SHADERFORMAT_INVALID;
    const char* entrypoint;

    if(backend_formats & SDL_GPU_SHADERFORMAT_SPIRV) {
        format = SDL_GPU_SHADERFORMAT_SPIRV;
        entrypoint = "main";
    } else if(backend_formats & SDL_GPU_SHADERFORMAT_MSL) {
        format = SDL_GPU_SHADERFORMAT_MSL;
        entrypoint = "main0";
    } else if(backend_formats & SDL_GPU_SHADERFORMAT_DXIL) {
        format = SDL_GPU_SHADERFORMAT_DXIL;
        entrypoint = "main";
    } else {
        SDL_Log("Unrecognized shader format!");
        return NULL;
    }

    SDL_GPUShaderCreateInfo shader_create_info = {
        .code = data,
        .code_size = size,
        .format = format,
        .stage = s,
        .num_samplers = sampler_count,
        .num_uniform_buffers = uniform_buffer_count,
        .num_storage_textures = storage_texture_count,
        .num_storage_buffers = storage_buffer_count
    };
    SDL_GPUShader* shader = SDL_CreateGPUShader(dh_app.gpu_device, &shader_create_info);
    if(shader == NULL) {
        SDL_Log("Failed to create shader: %s", SDL_GetError());
        return NULL;
    }
    
    return shader;
}

SDL_GPUShader* dh_load_shader_from_file(const char* file, int stage, Uint32 sampler_count, Uint32 uniform_buffer_count, Uint32 storage_buffer_count, Uint32 storage_texture_count) {
    size_t code_size;
    void* code = SDL_LoadFile(file, &code_size);
    if(code == NULL) {
        SDL_Log("Failed to load shader from file: %s", file);
        return NULL;
    }
    
    SDL_GPUShader* shader = dh_load_shader_from_bytes(code, code_size, stage, sampler_count, uniform_buffer_count, storage_buffer_count, storage_texture_count);
    SDL_free(code);

    return shader;
}

void dh_unload_shader(SDL_GPUShader* shader) {
    SDL_ReleaseGPUShader(dh_app.gpu_device, shader);
}

void dh_set_vertex_data_size(int size) {
    vertex_data_size = size;
}

void dh_add_vertex_attribute(int element_format, int location, int offset) {
    int format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3;
    // TODO: Enum?
    switch(element_format) {
        case 0:
            format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT2;
        case 1:
            format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3;
        case 2:
            format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT4;
    }

    // TODO: Buffer slot
    dh_push_va_to_array(&(dh_app.current_vertex_attribs), (SDL_GPUVertexAttribute){
        .buffer_slot = 0,
        .location = location,
        .format = format,
        .offset = offset
    });
}

// This api is so bad...
// Maybe I'll rewrite this
// Or not, no one's going to be using this except me sooo :)
// TODO: Shader null checks
// TODO: More detailed pipeline creation api
SDL_GPUGraphicsPipeline* dh_load_graphics_pipeline(SDL_GPUShader* vertex_shader, SDL_GPUShader* fragment_shader) {
    SDL_GPUVertexAttribute* va = {0};
//    SDL_memcpy(va, dh_app.current_vertex_attribs.array, dh_app.current_vertex_attribs.used);

//    SDL_Log("%d", va[0].format);

    SDL_GPUGraphicsPipelineCreateInfo pipeline_create_info = {
        .vertex_shader = vertex_shader,
        .fragment_shader = fragment_shader,
        .vertex_input_state = {
            .num_vertex_buffers = 1,
            .vertex_buffer_descriptions = (SDL_GPUVertexBufferDescription[]) {
                {
                    .slot = 0,
                    .pitch = vertex_data_size,
                    .input_rate = SDL_GPU_VERTEXINPUTRATE_VERTEX
                }
            },
            .num_vertex_attributes = dh_app.current_vertex_attribs.used,
            .vertex_attributes = dh_app.current_vertex_attribs.array 
        },
        .target_info = {
            .num_color_targets = 1,
            .color_target_descriptions= (SDL_GPUColorTargetDescription[]) {
                {
                    .format = SDL_GetGPUSwapchainTextureFormat(dh_app.gpu_device, dh_app.windows[0].sdl_window)
                }
            }
        },
        .primitive_type = SDL_GPU_PRIMITIVETYPE_TRIANGLELIST
    };
    SDL_GPUGraphicsPipeline* pipeline = SDL_CreateGPUGraphicsPipeline(dh_app.gpu_device, &pipeline_create_info);

    return pipeline;
}

void dh_unload_graphics_pipeline(SDL_GPUGraphicsPipeline* pipeline) {
    SDL_ReleaseGPUGraphicsPipeline(dh_app.gpu_device, pipeline);
}

void dh_set_graphics_pipeline(SDL_GPUGraphicsPipeline* pipeline) {
    SDL_BindGPUGraphicsPipeline(dh_app.render_passes[dh_app.active_render_pass], pipeline);
}

// TODO: Handling multiple buffer bindings???
// IDK what that means to be honest.
void dh_set_vertex_buffer(SDL_GPUBuffer* buffer) {
    SDL_BindGPUVertexBuffers(dh_app.render_passes[dh_app.active_render_pass], 0, &(SDL_GPUBufferBinding){.buffer = buffer, .offset = 0}, 1);
}

// TODO: Allow multiple formats
void dh_set_index_buffer(SDL_GPUBuffer* buffer) {
    SDL_BindGPUIndexBuffer(dh_app.render_passes[dh_app.active_render_pass], &(SDL_GPUBufferBinding){.buffer = buffer, .offset = 0}, SDL_GPU_INDEXELEMENTSIZE_16BIT);
}

void dh_set_vertex_uniform_data(int slot, void* data, int size) {
    SDL_PushGPUVertexUniformData(dh_app.command_buffer, slot, data, size);
}

void dh_set_fragment_uniform_data(int slot, void* data, int size) {
    SDL_PushGPUFragmentUniformData(dh_app.command_buffer, slot, data, size);
}

void dh_set_fragment_sampler(SDL_GPUTexture* texture, SDL_GPUSampler* sampler) {
    SDL_BindGPUFragmentSamplers(dh_app.render_passes[dh_app.active_render_pass], 0, &(SDL_GPUTextureSamplerBinding){.texture = texture, .sampler = sampler}, 1);
}

void dh_draw_primitives(int vertices, int instances) {
    SDL_DrawGPUPrimitives(dh_app.render_passes[dh_app.active_render_pass], vertices, instances, 0, 0);
}

void dh_draw_indexed_primitives(int indices, int instances) {
    SDL_DrawGPUIndexedPrimitives(dh_app.render_passes[dh_app.active_render_pass], indices, instances, 0, 0, 0);
}
