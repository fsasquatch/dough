#include "ext_common.h"
#include <hl.h>

// A note for future me
// You can pass SDL_GPUShader* as _ABSTRACT(sdl_gpushader)
// and on the haxe side typedef BackendShader = hl.Abstract<"sdl_gpushader">;

#define _GPU_BUFFER _ABSTRACT(sdl_gpubuffer)
#define _GPU_TEXTURE _ABSTRACT(sdl_gputexture)
#define _GPU_SAMPLER _ABSTRACT(sdl_gpusampler)
#define _GPU_SHADER _ABSTRACT(sdl_gpushader)
#define _GPU_GRAPHICS_PIPELINE _ABSTRACT(sdl_gpugraphicspipeline)

HL_PRIM void HL_NAME(begin_render)() {
    dh_begin_render();
}
DEFINE_PRIM(_VOID, begin_render, _NO_ARG);

HL_PRIM void HL_NAME(end_render)() {
    dh_end_render();
}
DEFINE_PRIM(_VOID, end_render, _NO_ARG);

HL_PRIM void HL_NAME(set_clear_color)(float r, float g, float b, float a) {
    dh_set_clear_color(r, g, b, a);
}
DEFINE_PRIM(_VOID, set_clear_color, _F32 _F32 _F32 _F32);

HL_PRIM void HL_NAME(begin_render_pass)(int window_id, int render_pass_id) {
    dh_begin_render_pass(window_id, render_pass_id);
}
DEFINE_PRIM(_VOID, begin_render_pass, _I32 _I32);

HL_PRIM void HL_NAME(end_render_pass)(int render_pass_id) {
    dh_end_render_pass(render_pass_id);
}
DEFINE_PRIM(_VOID, end_render_pass, _I32);

HL_PRIM void HL_NAME(begin_copy_pass)() {
    dh_begin_copy_pass();
}
DEFINE_PRIM(_VOID, begin_copy_pass, _NO_ARG);

HL_PRIM void HL_NAME(end_copy_pass)() {
    dh_end_copy_pass();
}
DEFINE_PRIM(_VOID, end_copy_pass, _NO_ARG);

HL_PRIM SDL_GPUBuffer* HL_NAME(load_vertex_buffer)(void* data, int size) {
    return dh_load_vertex_buffer(data, size);
}
DEFINE_PRIM(_GPU_BUFFER, load_vertex_buffer, _BYTES _I32);

HL_PRIM SDL_GPUBuffer* HL_NAME(load_index_buffer)(void* data, int size) {
    return dh_load_index_buffer(data, size);
}
DEFINE_PRIM(_GPU_BUFFER, load_index_buffer, _BYTES _I32);

HL_PRIM void HL_NAME(unload_buffer)(SDL_GPUBuffer* buffer) {
    dh_unload_buffer(buffer);
}
DEFINE_PRIM(_VOID, unload_buffer, _GPU_BUFFER);

HL_PRIM SDL_GPUTexture* HL_NAME(load_texture_from_bytes)(void* data, int width, int height, int format) {
    return dh_load_texture_from_bytes(data, width, height, format);
}
DEFINE_PRIM(_GPU_TEXTURE, load_texture_from_bytes, _BYTES _I32 _I32 _I32);

HL_PRIM SDL_GPUTexture* HL_NAME(load_texture_from_file)(vstring* file) {
    return dh_load_texture_from_file(hl_to_utf8(file->bytes));
}
DEFINE_PRIM(_GPU_TEXTURE, load_texture_from_file, _STRING);

HL_PRIM void HL_NAME(unload_texture)(SDL_GPUTexture* texture) {
    dh_unload_texture(texture);
}
DEFINE_PRIM(_VOID, unload_texture, _GPU_TEXTURE);

HL_PRIM SDL_GPUSampler* HL_NAME(load_sampler)() {
    return dh_load_sampler(); 
}
DEFINE_PRIM(_GPU_SAMPLER, load_sampler, _NO_ARG);

HL_PRIM void HL_NAME(unload_sampler)(SDL_GPUSampler* sampler) {
    dh_unload_sampler(sampler);
}
DEFINE_PRIM(_VOID, unload_sampler, _GPU_SAMPLER);

HL_PRIM SDL_GPUShader* HL_NAME(load_shader_from_bytes)(void* data, int size, int stage, Uint32 sampler_count, Uint32 uniform_buffer_count, Uint32 storage_buffer_count, Uint32 storage_texture_count) {
    return dh_load_shader_from_bytes(data, size, stage, sampler_count, uniform_buffer_count, storage_buffer_count, storage_texture_count);
}
DEFINE_PRIM(_GPU_SHADER, load_shader_from_bytes, _BYTES _I32 _I32 _I32 _I32 _I32 _I32);

HL_PRIM SDL_GPUShader* HL_NAME(load_shader_from_file)(vstring* file, int stage, Uint32 sampler_count, Uint32 uniform_buffer_count, Uint32 storage_buffer_count, Uint32 storage_texture_count) {
    return dh_load_shader_from_file(hl_to_utf8(file->bytes), stage, sampler_count, uniform_buffer_count, storage_buffer_count, storage_texture_count);
}
DEFINE_PRIM(_GPU_SHADER, load_shader_from_file, _STRING _I32 _I32 _I32 _I32 _I32);

HL_PRIM void HL_NAME(unload_shader)(SDL_GPUShader* shader) {
    dh_unload_shader(shader);
}
DEFINE_PRIM(_VOID, unload_shader, _GPU_SHADER);

HL_PRIM void HL_NAME(set_vertex_data_size)(int size) {
    dh_set_vertex_data_size(size);
}
DEFINE_PRIM(_VOID, set_vertex_data_size, _I32);

HL_PRIM void HL_NAME(add_vertex_attribute)(int element_format, int location, int offset) {
    dh_add_vertex_attribute(element_format, location, offset);
}
DEFINE_PRIM(_VOID, add_vertex_attribute, _I32 _I32 _I32);

HL_PRIM SDL_GPUGraphicsPipeline* HL_NAME(load_graphics_pipeline)(SDL_GPUShader* vertex, SDL_GPUShader* fragment) {
    return dh_load_graphics_pipeline(vertex, fragment);
}
DEFINE_PRIM(_GPU_GRAPHICS_PIPELINE, load_graphics_pipeline, _GPU_SHADER _GPU_SHADER);

HL_PRIM void HL_NAME(unload_graphics_pipeline)(SDL_GPUGraphicsPipeline* pipeline) {
    dh_unload_graphics_pipeline(pipeline);
}
DEFINE_PRIM(_VOID, unload_graphics_pipeline, _GPU_GRAPHICS_PIPELINE);

HL_PRIM void HL_NAME(set_graphics_pipeline)(SDL_GPUGraphicsPipeline* pipeline) {
    dh_set_graphics_pipeline(pipeline);
}
DEFINE_PRIM(_VOID, set_graphics_pipeline, _GPU_GRAPHICS_PIPELINE);

HL_PRIM void HL_NAME(set_vertex_buffer)(SDL_GPUBuffer* buffer) {
    dh_set_vertex_buffer(buffer);
}
DEFINE_PRIM(_VOID, set_vertex_buffer, _GPU_BUFFER);

HL_PRIM void HL_NAME(set_index_buffer)(SDL_GPUBuffer* buffer) {
    dh_set_index_buffer(buffer);
}
DEFINE_PRIM(_VOID, set_index_buffer, _GPU_BUFFER);

HL_PRIM void HL_NAME(set_vertex_uniform_data)(int slot, void* data, int size) {
    dh_set_vertex_uniform_data(slot, data, size);
}
DEFINE_PRIM(_VOID, set_vertex_uniform_data, _I32 _BYTES _I32);

HL_PRIM void HL_NAME(set_fragment_uniform_data)(int slot, void* data, int size) {
    dh_set_fragment_uniform_data(slot, data, size);
}
DEFINE_PRIM(_VOID, set_fragment_uniform_data, _I32 _BYTES _I32);

HL_PRIM void HL_NAME(set_fragment_sampler)(SDL_GPUTexture* texture, SDL_GPUSampler* sampler) {
    dh_set_fragment_sampler(texture, sampler);
}
DEFINE_PRIM(_VOID, set_fragment_sampler, _GPU_TEXTURE _GPU_SAMPLER);

HL_PRIM void HL_NAME(draw_primitives)(int vertices, int instances) {
    dh_draw_primitives(vertices, instances);
}
DEFINE_PRIM(_VOID, draw_primitives, _I32 _I32);

HL_PRIM void HL_NAME(draw_indexed_primitives)(int indices, int instances) {
    dh_draw_indexed_primitives(indices, instances);
}
DEFINE_PRIM(_VOID, draw_indexed_primitives, _I32 _I32);
