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

	/**
		Returns `true` if an array contains the `value`. Otherwise `false`.
	**/
	public static inline function contains<T>( array : Array<T>, value : T ) : Bool {

		return ( array.indexOf( value ) != -1 );
	}

	/**
		Returns `true` if an array contains the exact same values. Otherwise `false`.
	**/
	public static function equals<T>( array : Array<T>, arrayB : Array<T> ) : Bool {

		if ( array != null && arrayB != null ) {

			// Same instance
			if ( array == arrayB ) return true;

			if ( array.length == arrayB.length ) {

				var c : Int = array.length;
				if ( 0 < c ) {

					for ( i in 0...c ) {

						if ( array[ i ] != arrayB[ i ] ) {

							return false;
						}
					}
				}

				return true;
			}
		}

		return false;
	}

	/**
		Checks if a value from `detectValuesOrder` is used in and array and returns it. Otherwise `null`.
	**/
	public static function detectFirstUsedValue<T>( array : Array<T>, detectValuesOrder : Array<T>, ?fallback : Null<T> = null ) : T {

		for ( i in 0...detectValuesOrder.length ) {

			var value : T = detectValuesOrder[ i ];
			if ( array.indexOf( value ) != -1 ) {

				return value;
			}
		}

		return fallback;
	}

	/**
		Fill up an array with the `value` until it reaches `maxlength`.
	**/
	public static function fill<T>( array : Array<T>, maxLength : Int, value : T ) : Array<T> {

		for ( i in array.length...maxLength ) {

			array[ i ] = value;
		}
		return array;
	}

	/**
		Finds `value` in an array and returns the value after it.
	**/
	public static function getValueFollowing<T>( array : Array<T>, value : T ) : Null<T> {

		var index : Int = array.indexOf( value );
		if ( index != -1 && index < array.length - 1 ) {

			return array[ index + 1 ];
		}
		return null;
	}

	/**
		Returns true if `array` is not null and has a length greater than 0. Otherwise false.
	**/
	public static inline function hasLength<T>( array : Array<T> ) : Bool {

		return ( array != null && 0 < array.length );
	}

	public static function insertAll<T>( toArray : Array<T>, fromArray : Array<T>, pos : Int ) : Array<T> {

		var i : Int = fromArray.length - 1;
		while ( 0 <= i ) {

			toArray.insert( pos, fromArray[ i ] );
			--i;
		}

		return toArray;
	}

	public static function pushAvoidNull<T>(array : Array<T>, x: T ) : Array<T> {

		if ( x != null ) {

			array.push( x );
		}
		return array;
	}

	public static function popAll<T>( array : Array<T> ) : Array<T> {

		if ( array != null ) {

			var all : Array<T> = [];
			while ( 0 < array.length ) {

				all.push( array.pop() );
			}
			return all;
		}
		return null;
	}

	public static function pushAll<T>( toArray : Array<T>, fromArray : Array<T> ) : Array<T> {

		for ( i in 0...fromArray.length ) {

			toArray[ toArray.length ] = fromArray[ i ];
		}

		return toArray;
	}

	public static inline function remove<T>( array : Array<T>, value : T ) : Int {

		var index : Int = array.indexOf( value );
		if ( index != -1 ) {

			array.splice( index, 1 );
		}
		return index;
	}

	public static inline function removeDuplicates<T>( array : Array<T> ) : Int {

		var unique : Array<T> = [];
		var removed : Int = 0;

		var i : Int = 0;
		while ( i < array.length ) {

			var value : T = array[ i ];
			if ( ArrayUtil.contains( unique, value ) ) {

				removed++;
				array.splice( i, 1 );
			}
			else {

				unique.push( value );
				i++;
			}
		}
		return removed;
	}

	/* Shuffles an array */
	public static function shuffle<T>( array : Array<T> ) : Array<T>
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
