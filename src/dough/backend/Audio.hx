package dough.backend;

#if hl
typedef Audio = Int;
#elseif js
typedef Audio = dough.backend.web.WebAudio;
#end
