package dough.backend;

#if hl
typedef BackendShader = dough.native.Dough.NativeShader;
#elseif js
typedef BackendShader = js.html.webgl.Shader;
#end
