#include "dough_internal.h"

void dh_init_array(dh_array* a, size_t elem_size, size_t init_size) {
    a->array = SDL_malloc(init_size * elem_size);
    if(a->array == NULL) {
        SDL_Log("Failed to allocate array");
    }
    a->used = 0;
    a->size = init_size;
    a->element_size = elem_size;
}

void dh_free_array(dh_array* a) {
    SDL_free(a->array);
    a->array = NULL;
    a->used = a->size = 0;
}

void dh_push_int_to_array(dh_array* a, int element) {
    if(a->used == a->size) {
        a->size *= 2;
        a->array = SDL_realloc(a->array, a->size * a->element_size);
        if(a->array == NULL) {
            SDL_Log("Failed to reallocate array");
        }
    }
    SDL_memcpy(&((int*)a->array)[a->used], &element, a->element_size);    
    a->used++;
}

void dh_push_va_to_array(dh_array* a, SDL_GPUVertexAttribute element) {
    if(a->used == a->size) {
        a->size *= 2;
        a->array = SDL_realloc(a->array, a->size * a->element_size);
        if(a->array == NULL) {
            SDL_Log("Failed to reallocate array");
        }
    }
    SDL_memcpy(&((SDL_GPUVertexAttribute*)a->array)[a->used], &element, a->element_size);    
    a->used++;
}
