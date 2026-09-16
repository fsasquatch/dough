package dough;
// TODO: This doesn't work
import sys.io.File;
#if macro
import haxe.macro.Compiler;
import haxe.io.Path;
import sys.FileSystem;
import haxe.macro.Context;

@:noCompletion
class BuildMacro {
    public static function init() {
        if(Context.defined("cpp")) {
            return;
        }

        if(Context.defined("js")) {
            return;
        }

        if(Context.defined("hl") || Context.defined("hlc")) {
            Context.onAfterGenerate(() -> {
                buildAndCopyHDLL();
            });           
        }
    }

    public static function buildAndCopyHDLL() {
        var libPath = locateDoughPath();
        if(libPath == null) {
            Context.error("Could not find dough folder", Context.currentPos());
            return;
        }

        var outputDir = Path.directory(Compiler.getOutput());
        var prevBuild = null;
        if(FileSystem.exists(Path.join([outputDir, "dough.hdll"]))) {
            prevBuild = FileSystem.stat(Path.join([outputDir, "dough.hdll"]));
        }

        var prevCwd = Sys.getCwd();
        Sys.setCwd(libPath);
        
        var target = "hl";
        if(Context.defined("hlc")) {
            target = "hlc";
        }

        if(!FileSystem.exists(Path.join([libPath, "build"]))) {
            FileSystem.createDirectory(Path.join([libPath, "build"]));
            Sys.setCwd(Path.join([libPath, "build"]));
            var result = Sys.command("cmake ..");
            if(result != 0) trace(result);
            Sys.setCwd(libPath);
        }

        if(!FileSystem.exists(Path.join([libPath, "build", "dough.hdll"]))) {
            Sys.setCwd(Path.join([libPath, "build"]));
            var result = Sys.command("make");
            if(result != 0) trace(result);
            File.copy("dough.hdll", Path.join([outputDir, "dough.hdll"]));
        } else {
            if(!FileSystem.exists(Path.join([outputDir, "dough.hdll"]))) { 
                File.copy("dough.hdll", Path.join([outputDir, "dough.hdll"]));
            } else {
                if(FileSystem.stat(Path.join([libPath, "build", "dough.hdll"])).mtime != prevBuild.mtime) {
                    File.copy("dough.hdll", Path.join([outputDir, "dough.hdll"]));
                }
            }
        }
    }

    static function locateDoughPath():String {
        for(path in Context.getClassPath()) {
            var parent = Path.directory(Path.removeTrailingSlashes(path));
            if(FileSystem.exists(Path.join([parent, "src", "dough"]))) {
                return parent;
            }
        }
        return null;
    }
}
#end
