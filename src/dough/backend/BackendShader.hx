package dough.backend;

#if (hl || cpp) 
typedef BackendShader = dough.native.Dough.NativeShader;
#elseif js
typedef BackendShader = js.html.webgl.Shader;
#end
