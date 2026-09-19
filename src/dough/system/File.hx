package dough.system;

class File {
    public static function loadBytes(file:String):haxe.io.Bytes {
        return Application.instance.system.loadBytes(file);
    }

    public static function loadText(file:String):String {
        return Application.instance.system.loadText(file);
    }

    public static function writeBytes(file:String, content:haxe.io.Bytes) {
        Application.instance.system.writeBytes(file, content);
    }

    public static function writeText(file:String, content:String) {
        Application.instance.system.writeText(file, content);
    }

    public static function listFileEntries(location:String):Array<String> {
        return Application.instance.system.listFileEntries(location);
    }

    public static function fileExists(file:String):Bool {
        return Application.instance.system.fileExists(file);
    }

    public static function isDirectory(entry:String):Bool {
        return Application.instance.system.isDirectory(entry);
    }
}
