#include "SDL3/SDL.h"

#ifndef DOUGH_UTILS_H
#define DOUGH_UTILS_H

typedef struct dh_array {
    void* array;
    size_t element_size;
    size_t size;
    size_t used;
} dh_array;

void dh_init_array(dh_array* a, size_t elem_size, size_t init_size);
void dh_free_array(dh_array* a);
void dh_push_int_to_array(dh_array* a, int element);
void dh_push_va_to_array(dh_array* a, SDL_GPUVertexAttribute element);

#endif
