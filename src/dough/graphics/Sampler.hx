package dough.graphics;

import dough.backend.BackendSampler;

class Sampler {
    var backendObj:BackendSampler;

    public function new() {
        backendObj = Application.instance.gpu.loadSampler();
    }

    public function unload() {
        Application.instance.gpu.unloadSampler(backendObj);
    }
}
