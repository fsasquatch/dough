package dough.backend;

#if (hl || cpp)
typedef BackendGraphicsPipeline = dough.native.Dough.NativeGraphicsPipeline;
#elseif js
typedef BackendGraphicsPipeline = js.html.webgl.Program; 
#end
