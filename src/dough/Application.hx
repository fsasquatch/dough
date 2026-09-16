package dough;

import dough.backend.Audio;
import dough.backend.Gpu;
import dough.backend.System;
import dough.system.Window;

class Application {
    public static var instance:Application = null;

    public var onCreate:()->Void;
    public var onUpdate:()->Void;
    public var onDraw:()->Void;
    public var onDestroy:()->Void;

    public var system:System;
    public var gpu:Gpu;
    public var audio:Audio;

    var mainWindow:Window;
    var width:Int;
    var height:Int;
    var title:String;

    public function new(w:Int, h:Int, t:String) {
        if(instance != null) trace("This might crash and burn");
        else instance = this;

        system = new System();
        gpu = new Gpu();

        width = w;
        height = h;
        title = t;
    }

    public function run() {
        mainWindow = new Window(width, height, title);
        if(onCreate != null) onCreate();
       
        #if !js
        while(mainWindow.isRunning()) {
            while(system.pollWindowEvents()) {
                mainWindow.handleEvents();
            }

            if(onUpdate != null) onUpdate();

            #if !opengl
            dough.native.Dough.beginRender();
            if(onDraw != null) onDraw();
            dough.native.Dough.endRender();
            #end
        }
        #else
        #end

        if(onDestroy != null) onDestroy();
        mainWindow.destroy();
    }
}
