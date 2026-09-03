import dough.native.Native;

function main() {
    var window = Native.createWindow(1280, 720, "hello world", 0);
    var window2 = Native.createWindow(800, 600, "another window?", 0);

    while(Native.isWindowRunning(window)) {
        while(Native.pollWindowEvents()) {
            Native.handleWindowEvents(window);
            Native.handleWindowEvents(window2);
        }

        Native.beginCommandBuffer();

        Native.acquireSwapchainTexture(window);
        Native.beginRenderPass(0);
        Native.endRenderPass(0);

        if(Native.isWindowRunning(window2)) {
            Native.acquireSwapchainTexture(window2);
            Native.beginRenderPass(0);
            Native.endRenderPass(0);
        }

        Native.endCommandBuffer();

        if(!Native.isWindowRunning(window2)) Native.destroyWindow(window2);
    }

    Native.destroyWindow(window);
}
