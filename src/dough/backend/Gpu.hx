package dough.backend;

#if (hl || cpp)
typedef Gpu = dough.backend.gpu.SDLGpu;
#elseif js
typedef Gpu = dough.backend.gpu.WebGL;
#end
