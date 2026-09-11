package dough.backend;

#if hl
typedef Gpu = dough.backend.sdl.SDLGpu;
#elseif js
typedef Gpu = dough.backend.web.WebGpu;
#end
