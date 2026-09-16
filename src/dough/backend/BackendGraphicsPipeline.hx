package dough.backend;

#if hl
typedef BackendGraphicsPipeline = dough.native.Dough.NativeGraphicsPipeline;
#elseif js
typedef BackendGraphicsPipeline = js.html.webgl.Program; 
#end
