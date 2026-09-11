package dough.backend;

#if hl
typedef System = dough.backend.sdl.SDLSystem;
#else
typedef System = dough.backend.web.WebSystem;
#end
