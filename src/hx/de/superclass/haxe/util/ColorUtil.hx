/*
 * Copyright (C)2017 Markus Raab (derRaab) | blog.derraab.com | superclass.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package de.superclass.haxe.util;

/**
	`ColorUtil` provides simple helper methods to work with color values.
**/
class ColorUtil {

	public static function hexToRgbArray( hexString : String, ?rgb : Array<Int> = null ) : Array<Int> {

		if ( hexString.indexOf( "#" ) == 0 ) {

			hexString = hexString.substr( 1 );
		}

		if ( hexString.length == 3 ) {

			hexString = hexString.charAt(0) + hexString.charAt(0) + hexString.charAt(1) + hexString.charAt(1) + hexString.charAt(2) + hexString.charAt(2);
		}
		else if ( hexString.length != 6 ) {

			throw( 'Invalid hex color: ' + hexString );
		}

		if ( rgb == null ) {

			rgb = [];
		}

		for ( i in 0...3 ) {

			rgb[ i ] = Std.parseInt( "0x" + hexString.substr( i * 2, 2 ) );
		}

		return rgb;
	}

	public static function luminanaceFromHex( hexString : String ) : Float {

		var rgb : Array<Int> = hexToRgbArray( hexString );
		return luminanaceFromRgb( rgb[ 0 ], rgb[ 1 ], rgb[ 2 ] );
	}

	public static function luminanaceFromRgb( r : Int, g : Int, b : Int ) : Float {

		var a = [ r, g, b].map( function( v : Float ) {

			v /= 255;
			return ( v <= 0.03928 ) ? v / 12.92 : Math.pow( ((v+0.055)/1.055), 2.4 );
		});

		return a[ 0 ] * 0.2126 + a[ 1 ] * 0.7152 + a[ 2 ] * 0.0722;
	}

	public static function fromHexString( hexString : String ) : Int {

		if ( hexString.indexOf( "#" ) == 0 ) {

			hexString = "0x" + hexString.substr( 1 );
		}

		return Std.parseInt( hexString );
	}

	public static function interpolate( fromColor : Int, toColor : Int, progress : Float ) : Int
	{
		var q : Float = 1 - progress;
		var fromA : Int = (fromColor >> 24) & 0xFF;
		var fromR : Int = (fromColor >> 16) & 0xFF;
		var fromG : Int = (fromColor >> 8) & 0xFF;
		var fromB : Int = fromColor & 0xFF;

		var toA : Int = (toColor >> 24) & 0xFF;
		var toR : Int = (toColor >> 16) & 0xFF;
		var toG : Int = (toColor >> 8) & 0xFF;
		var toB : Int = toColor & 0xFF;

		var resultA : Int = Std.int( fromA * q + toA * progress );
		var resultR : Int = Std.int( fromR * q + toR * progress );
		var resultG : Int = Std.int( fromG * q + toG * progress );
		var resultB : Int = Std.int( fromB * q + toB * progress );
		var resultColor : Int = resultA << 24 | resultR << 16 | resultG << 8 | resultB;

		return resultColor;
	}


}
