package dough.backend;

#if (hl || cpp)
typedef System = dough.backend.system.SDLSystem;
#else
typedef System = dough.backend.system.WebSystem;
#end
