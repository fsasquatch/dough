package dough.backend;

#if (hl || cpp)
typedef BackendSampler = dough.native.Dough.NativeSampler; 
#elseif js
typedef BackendSampler = js.html.webgl.Sampler;
#end
