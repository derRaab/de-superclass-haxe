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
	`FloatUtil` provides simple helper methods to work with floating point numbers.
**/
class FloatUtil {

	// See https://github.com/aduros/flambe/blob/master/src/flambe/math/FMath.hx
	/** The highest integer value in Flash and JS.*/
	public static var MAX_VALUE : Float = 1.79769313486231e+308;
	/** The lowest integer value in Flash and JS. */
	public static var MIN_VALUE : Float = -1.79769313486231e+308;

	public static function prettify( floatValue : Float, thousandSeparator : String, comma : String ) : String
	{
		var floatString = Std.string( floatValue );
		if ( ! isNaN( floatValue ) ) {

			// Find dot
			var commaIndex : Int = floatString.indexOf( "." );
			var hasComma : Bool = ( commaIndex != -1 );
			var beforeComma : String = ( hasComma ) ? floatString.substr( 0, commaIndex ) : floatString;
			var afterComma : String = ( hasComma ) ? floatString.substr( commaIndex + 1 ) : "";

			floatString = "";

			var i : Int = beforeComma.length - 1;
			while ( 0 <= i ) {

				var addThousandSeparator : Bool = ( 0 < floatString.length && ( floatString.length == 3 || floatString.length % 4 == 3 ) );
				if ( addThousandSeparator ) {

					floatString = thousandSeparator + floatString;
				}

				floatString = beforeComma.substr( i, 1 ) + floatString;

				--i;
			}

			if ( StringUtil.hasLength( afterComma ) ) {

				floatString = floatString + comma + afterComma;
			}
		}

		return floatString;
	}

	public static function chop( floatValue : Float, min : Float = 0, max : Float = 1 ) : Float
	{
		return Math.min( max, Math.max( min, floatValue ) );
	}

	public static function distance( n1 : Float, n0 : Float ) : Float
	{
		if ( n1 == n0 ) return 0;
		if ( n0 < n1 ) return n1 - n0;
		return n0 - n1;
	}

	public static function fixed( floatValue : Float, fractionDigits : Int = 0 ) : Float
	{
		if ( fractionDigits == 0 || fractionDigits > 20 ) return Math.round( floatValue );

		var f : Float = Math.pow( 10, fractionDigits );
		return Math.round( floatValue * f ) / f;
	}

	public static function interpolateAndSnap( n1 : Float, n0 : Float, f : Float, snapDistance : Float ) : Float
	{
		if ( n1 == n0 ) return n0;
		if ( Math.max( n1, n0 ) - Math.min( n1, n0 ) < snapDistance ) return n1;
		return n0 + ( n1 - n0 ) * f;
	}

	public inline static function interpolate( n0 : Float, n1 : Float, f : Float ) : Float
	{
		if ( n1 == n0 ) return n0;
		return n0 + ( n1 - n0 ) * f;
	}

	public static function isNaNFallback( floatValue : Float, fallBack : Float ) : Float {

		if ( isNaN( floatValue ) ) {

			floatValue = fallBack;
		}

		return floatValue;
	}

	public static inline function isNaN( floatValue : Float ) : Bool {

		#if flash
		return ( "" + floatValue == "" + Math.NaN );
		#else
		return Math.isNaN( floatValue );
		#end
	}

	/**
		Returns only the `float`s fractions.
	**/
	public static function getFractions( floatValue : Float ) : Float {

		if ( floatValue < 0 ) {

			return floatValue + Math.ceil( floatValue );
		}
		else if ( 0 < floatValue ) {

			return floatValue - Math.floor( floatValue );
		}
		else {

			return 0;
		}
	}
}
