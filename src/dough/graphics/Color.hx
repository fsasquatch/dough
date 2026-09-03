/*
   MIT License

   Copyright (c) 2018 Sylvio Sell

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
*/
package dough.graphics;

// The license is pasted in here cause I think it's necessary?
// Thank you, Semmi! :)
abstract Color(Int) from Int to Int from UInt to UInt {
    public var r(get,set):Int;
    public var g(get,set):Int;
    public var b(get,set):Int;
    public var a(get,set):Int;

    public var rgb(get,set):Int;
    public var argb(get,set):Int;

    public var red(get,set):Int;
    public var green(get,set):Int;
    public var blue(get,set):Int;
    public var alpha(get,set):Int;
    public var luminance(get,set):Int;

    public var rF(get,set):Float;
    public var gF(get,set):Float;
    public var bF(get,set):Float;
    public var aF(get,set):Float;

    public var redF(get,set):Float;
    public var greenF(get,set):Float;
    public var blueF(get,set):Float;
    public var alphaF(get,set):Float;
    public var luminanceF(get,set):Float;

    // getter Integer
    inline function get_r() return (this >> 24) & 0xff;
    inline function get_g() return (this >> 16) & 0xff;
    inline function get_b() return (this >>  8) & 0xff;
    inline function get_a() return  this & 0xff;
    
    inline function get_rgb () return  this >> 8;
    inline function get_argb() return (this >> 8) | (a << 24);
    
    inline function get_red  () return get_r();
    inline function get_green() return get_g();
    inline function get_blue () return get_b();
    inline function get_alpha() return get_a();
    inline function get_luminance() return Math.round((r + g + b)/3);

    // getter Float
    inline function get_rF() return get_r() / 0xff;
    inline function get_gF() return get_g() / 0xff;
    inline function get_bF() return get_b() / 0xff;
    inline function get_aF() return get_a() / 0xff;

    inline function get_redF  () return get_rF();
    inline function get_greenF() return get_gF();
    inline function get_blueF () return get_bF();
    inline function get_alphaF() return get_aF();
    inline function get_luminanceF() return (rF + gF + bF)/3;

    // setter Integer
    inline function set_r(r:Int) { this = (this & 0x00ffffff) | (r<<24); return r; }
    inline function set_g(g:Int) { this = (this & 0xff00ffff) | (g<<16); return g; }
    inline function set_b(b:Int) { this = (this & 0xffff00ff) | (b<<8 ); return b; }
    inline function set_a(a:Int) { this = (this & 0xffffff00) | a; return a; }
    
    inline function set_rgb (rgb:Int)  { this = ( rgb << 8) | a; return rgb; }
    inline function set_argb(argb:Int) { this = (argb << 8) | (argb >> 24); return argb; }
    
    inline function set_red  (r:Int) return set_r(r);
    inline function set_green(g:Int) return set_g(g);
    inline function set_blue (b:Int) return set_b(b);
    inline function set_alpha(a:Int) return set_a(a);	
    inline function set_luminance(lum:Int) { setRGB(lum, lum, lum); return lum; }

    // setter Float
    inline function set_rF(r:Float) return set_r( Math.round(r * 0xff) );
    inline function set_gF(g:Float) return set_g( Math.round(g * 0xff) );
    inline function set_bF(b:Float) return set_b( Math.round(b * 0xff) );
    inline function set_aF(a:Float) return set_a( Math.round(a * 0xff) );

    inline function set_redF  (r:Float) return set_rF(r);
    inline function set_greenF(g:Float) return set_gF(g);
    inline function set_blueF (b:Float) return set_bF(b);
    inline function set_alphaF(a:Float) return set_aF(a);
    inline function set_luminanceF(lum:Float) { setFloatRGB(lum, lum, lum); return lum; }

    public function new(hexValue:Int = 0) {
        this = hexValue;
    }

    public inline function setARGB(a:Int, r:Int, g:Int, b:Int):Color return this = ARGB(a, r, g, b);

    public inline function setRGBA(r:Int, g:Int, b:Int, a:Int):Color return this = RGBA(r, g, b, a);

    public inline function setRGB(r:Int, g:Int, b:Int):Color return this = (this & 0x000000ff)|(r<<24)|(g<<16)|(b<<8);

    public inline function setLuminanceAlpha(lum:Int, a:Int):Color return setRGBA(lum, lum, lum, a);

    public inline function setRed(r:Int):Color return this = (this & 0x00ffffff)|(r<<24);

    public inline function setGreen(g:Int):Color return this = (this & 0xff00ffff)|(g<<16);

    public inline function setBlue(b:Int):Color return this = (this & 0xffff00ff)|(b<<8);

    public inline function setAlpha(a:Int):Color return this = (this & 0xffffff00)|a;

    public inline function setLuminance(lum:Int):Color return setRGB(lum, lum, lum);

    public inline function setFloatARGB(a:Float, r:Float, g:Float, b:Float):Color return this = FloatARGB(a, r, g, b);

    public inline function setFloatRGBA(r:Float, g:Float, b:Float, a:Float):Color return this = FloatRGBA(r, g, b, a);

    public inline function setFloatRGB(r:Float, g:Float, b:Float):Color return this = (this & 0x000000ff)|(Math.round(r*0xFF)<<24)|(Math.round(g*0xFF)<<16)|(Math.round(b*0xFF)<<8);

    public inline function setFloatLuminanceAlpha(lum:Float, a:Float):Color return setFloatRGBA(lum, lum, lum, a);

    public inline function setFloatRed(r:Float):Color return this = (this & 0x00ffffff) | (Math.round(r*0xFF)<<24);

    public inline function setFloatGreen(g:Float):Color return this = (this & 0xff00ffff) | (Math.round(g*0xFF)<<16);

    public inline function setFloatBlue(b:Float):Color return this = (this & 0xffff00ff) | (Math.round(b*0xFF)<<8);

    public inline function setFloatAlpha(a:Float):Color return this = (this & 0xffffff00) | Math.round(a*0xFF);

    public inline function setFloatLuminance(lum:Float):Color return setFloatRGB(lum, lum, lum);

    public static inline function ARGB(a:Int, r:Int, g:Int, b:Int):Color return (a<<24)|(r<<16)|(g<<8)|b;

    public static inline function RGBA(r:Int, g:Int, b:Int, a:Int):Color return (r<<24)|(g<<16)|(b<<8)|a;

    public static inline function RGB(r:Int, g:Int, b:Int):Color return (r<<24)|(g<<16)|(b<<8)|0xff;

    static inline function RG(r:Int, g:Int):Color return (r<<24)|(g<<16)|0xff;

    public static inline function LuminanceAlpha(lum:Int, a:Int):Color return RGBA(lum, lum, lum, a);

    public static inline function Red(r:Int):Color return (r<<24)|0xff;

    public static inline function Green(g:Int):Color return (g<<16)|0xff;

    public static inline function Blue(b:Int):Color return (b<<8)|0xff;

    public static inline function Alpha(a:Int):Color return a;

    public static inline function Luminance(lum:Int):Color return RGB(lum, lum, lum);

    public static inline function FloatARGB(a:Float, r:Float, g:Float, b:Float):Color return (Math.round(a*0xFF)<<24)|(Math.round(r*0xFF)<<16)|(Math.round(g*0xFF)<<8)|Math.round(b*0xFF);

    public static inline function FloatRGBA(r:Float, g:Float, b:Float, a:Float):Color return (Math.round(r*0xFF)<<24)|(Math.round(g*0xFF)<<16)|(Math.round(b*0xFF)<<8)|Math.round(a*0xFF);

    public static inline function FloatRGB(r:Float, g:Float, b:Float):Color return (Math.round(r*0xFF)<<24)|(Math.round(g*0xFF)<<16)|(Math.round(b*0xFF)<<8)|0xff;

    public static inline function FloatLuminanceAlpha(lum:Float, a:Float):Color return FloatRGBA(lum, lum, lum, a);

    public static inline function FloatRed(r:Float):Color return (Math.round(r*0xFF)<<24)|0xff;

    public static inline function FloatGreen(g:Float):Color return (Math.round(g*0xFF)<<16)|0xff;

    public static inline function FloatBlue(b:Float):Color return (Math.round(b*0xFF)<<8)|0xff;

    public static inline function FloatAlpha(a:Float):Color return Math.round(a*0xFF);

    public static inline function FloatLuminance(lum:Float):Color return FloatRGB(lum, lum, lum);

    public static inline function mix(fromColor:Color, toColor:Color, step:Float):Color {
        return FloatRGBA(
            _mix(fromColor.rF, toColor.rF, step),
            _mix(fromColor.gF, toColor.gF, step),
            _mix(fromColor.bF, toColor.bF, step),
            _mix(fromColor.aF, toColor.aF, step)
        );	
    }

    static inline function _mix(a:Float, b:Float, step:Float) return a + (b-a) * step;

    public static inline function HSV(hue:Float, saturation:Float, value:Float, alpha:Float = 1.0):Color {
        if (hue < 0) hue = 1.0 + hue % 1.0;
        else hue = hue % 1.0;

        var h:Int = Std.int(hue * 6);
        var f = hue * 6 - h;

        /*
        // https://de.wikipedia.org/wiki/HSV-Farbraum#Umrechnung_HSV_in_RGB
        var p = value * (1-saturation);
        var q = value * (1-saturation*f);
        var t = value * (1-saturation*(1-f));
        return switch (h) {
            case 1: FloatRGBA(q, value, p, alpha);
            case 2: FloatRGBA(p, value, t, alpha);
            case 3: FloatRGBA(p, q, value, alpha);
            case 4: FloatRGBA(t, p, value, alpha);
            case 5: FloatRGBA(value, p, q, alpha);
            default: FloatRGBA(value, t, p, alpha);
        }*/
        return switch (h)
        {
            case 1: FloatRGBA(value * (1-saturation*f), value, value * (1-saturation), alpha);
            case 2: FloatRGBA(value * (1-saturation), value, value * (1-saturation*(1-f)), alpha);
            case 3: FloatRGBA(value * (1-saturation), value * (1-saturation*f), value, alpha);
            case 4: FloatRGBA(value * (1-saturation*(1-f)), value * (1-saturation), value, alpha);
            case 5: FloatRGBA(value, value * (1-saturation), value * (1-saturation*f), alpha);
            default: FloatRGBA(value, value * (1-saturation*(1-f)), value * (1-saturation), alpha);
        }
    } 

    public static inline function HSL(hue:Float, saturation:Float, luminance:Float, alpha:Float = 1.0):Color {
        var v:Float = luminance + saturation * Math.min(luminance, 1-luminance);
        return HSV(hue, (v > 0.0) ? 2*(1-luminance/v) : 0.0, v, alpha);
    }

    public var rgbMax(get, never):Int;
    inline function get_rgbMax():Int return (b>r && b>g) ? b : ( (g>r) ? g : r );


    public var rgbMin(get, never):Int;
    inline function get_rgbMin():Int return (b<r && b<g) ? b : ( (g<r) ? g : r );

    public var rgbMaxF(get, never):Float;
    inline function get_rgbMaxF():Float return Math.max(rF, Math.max(gF, bF));

    public var rgbMinF(get, never):Float;
    inline function get_rgbMinF():Float return Math.min(rF, Math.min(gF, bF));

    public var hue(get, set):Float;
    inline function get_hue():Float {
        if (rgbMax == rgbMin) return 0.0;		
        var h:Float = 
            if (rgbMax == r) ((gF - bF) / (rgbMaxF - rgbMinF)) / 6;
            else if (rgbMax == g) (2 + (bF - rF) / (rgbMaxF - rgbMinF)) / 6;
            else (4 + (rF - gF) / (rgbMaxF - rgbMinF)) / 6;
        
        return (h < 0) ? h + 1 : h;
    }
    inline function set_hue(h:Float):Float {
        return this = HSV(h, saturationHSV, valueHSV, aF);
    }

    public var saturationHSV(get, set):Float;
    inline function get_saturationHSV():Float {
        if (rgbMax == rgbMin) return 0.0;
        else return 1 - rgbMinF/rgbMaxF;
    }
    inline function set_saturationHSV(s:Float):Float {
        return this = HSV(hue, s, valueHSV, aF);
    }

    public var saturationHSL(get, set):Float;
    inline function get_saturationHSL():Float {
        if (rgbMax == rgbMin) return 0.0;
        else return (rgbMaxF - rgbMinF)/(1 - Math.abs(rgbMaxF + rgbMinF - 1));
    }
    inline function set_saturationHSL(s:Float):Float {
        return this = HSL(hue, s, luminanceHSL, aF);
    }

    public var valueHSV(get, set):Float;
    inline function get_valueHSV():Float return rgbMaxF;
    inline function set_valueHSV(v:Float):Float {
        return this = HSV(hue, saturationHSV, v, aF);
    }


    public var luminanceHSL(get, set):Float;
    inline function get_luminanceHSL():Float return (rgbMaxF + rgbMinF) / 2;
    inline function set_luminanceHSL(l:Float):Float {
        return this = HSL(hue, saturationHSL, l, aF);
    }

    public static inline function rnd(fromColor:Color, toColor:Color):Color {
        return FloatRGBA(
            _mix(fromColor.rF, toColor.rF, Math.random()),
            _mix(fromColor.gF, toColor.gF, Math.random()),
            _mix(fromColor.bF, toColor.bF, Math.random()),
            _mix(fromColor.aF, toColor.aF, Math.random())
        );	
    }

    public static inline function random(?alpha:Null<Int>):Color {
        return
            if (alpha == null) 
                (Std.int(Math.random()*256) << 24) | Std.random(0x1000000);
            else
                (Std.int(Math.random()*256) << 24) | (Std.random(0x10000) << 8) | alpha;
    }

    public inline function randomize(?alpha:Null<Int>) {
        this = random(alpha);
    }

    // TODO: Change a few of these colors.
    public static inline var BLACK:Color = 0x000000ff;
    public static inline var WHITE:Color = 0xffffffff;

    public static inline var GREY:Color = 0x7f7f7fff;
    public static inline var GREY1:Color = 0x1f1f1fff;
    public static inline var GREY2:Color = 0x3f3f3fff;
    public static inline var GREY3:Color = 0x5f5f5fff;
    public static inline var GREY4:Color = 0x7f7f7fff;
    public static inline var GREY5:Color = 0x9f9f9fff;
    public static inline var GREY6:Color = 0xbfbfbfff;
    public static inline var GREY7:Color = 0xdfdfdfff;

    public static inline var RED :Color = 0xff0000ff;
    public static inline var RED1:Color = 0x3f0000ff;
    public static inline var RED2:Color = 0x7f0000ff;
    public static inline var RED3:Color = 0xbf0000ff;

    public static inline var GREEN:Color  = 0x00ff00ff;
    public static inline var GREEN1:Color = 0x003f00ff;
    public static inline var GREEN2:Color = 0x007f00ff;
    public static inline var GREEN3:Color = 0x00bf00ff;

    public static inline var BLUE :Color = 0x0000ffff;
    public static inline var BLUE1:Color = 0x00003fff;
    public static inline var BLUE2:Color = 0x00007fff;
    public static inline var BLUE3:Color = 0x0000bfff;

    public static inline var CYAN   :Color = 0x00ffffff;
    public static inline var MAGENTA:Color = 0xff00ffff;
    public static inline var YELLOW :Color = 0xffff00ff;

    public static inline var GOLD:Color = 0xffd700ff;
    public static inline var ORANGE:Color = 0xffa500ff;
    public static inline var BROWN:Color = 0x8B4513ff;
    public static inline var PURPLE:Color = 0x800080ff;
    public static inline var PINK:Color = 0xffc0cbff;
    public static inline var LIME:Color = 0xccff00ff; // https://en.wikipedia.org/wiki/Lime_(color)

    @:to public inline function toString():String {
        var s = "";
        for (i in 0...8) s = getHexDigit(this, i) + s;
        return s;
    }

    inline function getHexDigit(c:Int, n:Int):String {
        c = (c >> (n << 2)) & 0xf;
        return String.fromCharCode( c + ( c < 10 ? 48 : 55) );
    }
}
