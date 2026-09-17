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

    public var windows:Array<Window>;
    
    // for the main window
    var width:Int;
    var height:Int;
    var title:String;

    public function new(w:Int, h:Int, t:String) {
        if(instance != null) trace("This might crash and burn");
        else instance = this;

        system = new System();
        gpu = new Gpu();

        windows = [];

        width = w;
        height = h;
        title = t;
    }

    public function run() {
        windows[0] = new Window(width, height, title);
        if(onCreate != null) onCreate();
       
        #if !js
        while(windows[0].isRunning()) {
            while(system.pollWindowEvents()) {
                for(w in windows) {
                    if(!w.isRunning()) continue;
                    w.handleEvents();
                    if(system.wasWindowResized(@:privateAccess w.backendID)) if(w.onResize != null) w.onResize();
                }
            }

            if(onUpdate != null) onUpdate();

            #if !opengl
            dough.native.Dough.beginRender();
            if(onDraw != null) onDraw();
            dough.native.Dough.endRender();
            #else
            if(onDraw != null) onDraw();
            #end

            for(i in 0...windows.length) {
                if(i == 0) continue;
                if(!windows[i].isRunning()) windows[i].destroy();
            }
        }
        #else
        #end

        if(onDestroy != null) onDestroy();
        for(w in windows) w.destroy();
    }
}
