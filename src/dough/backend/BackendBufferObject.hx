package dough.backend;

#if hl
typedef BackendBufferObject = dough.native.Dough.NativeBuffer;
#elseif js
typedef BackendBufferObject = js.html.webgl.Buffer; 
#end
