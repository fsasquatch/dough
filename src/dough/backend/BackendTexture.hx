package dough.backend;

#if (hl || cpp)
typedef BackendTexture = dough.native.Dough.NativeTexture; 
#elseif js
typedef BackendTexture = js.html.webgl.Texture;
#end
