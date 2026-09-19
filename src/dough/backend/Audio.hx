package dough.backend;

#if (hl || cpp)
typedef Audio = Int;
#elseif js
typedef Audio = dough.backend.audio.WebAudio;
#end
