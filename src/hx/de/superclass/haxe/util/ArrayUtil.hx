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
	`ArrayUtil` provides simple helper methods to work with arrays.
**/
class ArrayUtil {

	public static inline function contains( array : Array<Dynamic>, value : Dynamic ) : Bool {

		return ( array.indexOf( value ) != -1 );
	}

	public static function detectFirstUsedValue( array : Array<Dynamic>, detectValuesOrder : Array<Dynamic>, ?fallback : Dynamic = null ) : Dynamic {

		for ( i in 0...detectValuesOrder.length ) {

			var value : Dynamic = detectValuesOrder[ i ];
			if ( array.indexOf( value ) != -1 ) {

				return value;
			}
		}

		return fallback;
	}

	public static inline function fill( array : Array<Dynamic>, maxLength : Int, value : Dynamic ) : Array<Dynamic> {

		for ( i in array.length...maxLength ) {

			array[ i ] = value;
		}
		return array;
	}

	public static function getValueFollowing( array : Array<Dynamic>, value : Dynamic ) : Dynamic {

		var index : Int = array.indexOf( value );
		if ( index != -1 && index < array.length - 1 ) {

			return array[ index + 1 ];
		}
		return null;
	}

	public static inline function hasLength( array : Array<Dynamic> ) : Bool {

		return ( array != null && 0 < array.length );
	}

	public static function insertAll( toArray : Array<Dynamic>, fromArray : Array<Dynamic>, pos : Int ) : Array<Dynamic> {

		var i : Int = fromArray.length - 1;
		while ( 0 <= i ) {

			toArray.insert( pos, fromArray[ i ] );
			--i;
		}

		return toArray;
	}

	public static inline function pushAll( toArray : Array<Dynamic>, fromArray : Array<Dynamic> ) : Array<Dynamic> {

		for ( i in 0...fromArray.length ) {

			toArray[ toArray.length ] = fromArray[ i ];
		}

		return toArray;
	}

	public static inline function remove( array : Array<Dynamic>, value : Dynamic ) : Int {

		var index : Int = array.indexOf( value );
		if ( index != -1 ) {

			array.splice( index, 1 );
		}
		return index;
	}

	/* Shuffles an array */
	public static function shuffle( array : Array<Dynamic> ) : Array<Dynamic>
	{
		// http://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
		var currentIndex : Int = array.length;
		var randomIndex : Int = -1;
		var temporaryValue : Dynamic;

		// While there remain elements to shuffle...
		while ( 0 != currentIndex ) {

			// Pick a remaining element...
			randomIndex = Std.int( Math.random() * currentIndex );
			--currentIndex;

			// And swap it with the current element.
			temporaryValue = array[ currentIndex ];
			array[ currentIndex ] = array[ randomIndex ];
			array[ randomIndex ] = temporaryValue;
		}

		return array;
	}

	public static function sortFunctionAscending( a : Dynamic, b : Dynamic ) : Int {

		if (a < b) return -1;
		if (a > b) return 1;
		return 0;
	}

	public static function sortFunctionDescending( a : Dynamic, b : Dynamic ) : Int {

		if (a < b) return 1;
		if (a > b) return -1;
		return 0;
	}

	public static function sortFunctionRandom( a : Dynamic, b : Dynamic ) : Int {
		return Math.round( Math.random() * 2 - 1 );
	}

	public static function sortFunctionStringLengthDescending( aString : String, bString : String ) : Int {

		var a : Int = aString.length;
		var b : Int = bString.length;

		if (a < b) return 1;
		if (a > b) return -1;
		return 0;
	}
}