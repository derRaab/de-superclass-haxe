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
	`StringUtil` provides simple helper methods to work with strings.
**/
class StringUtil {

	public static var LINE_BREAKS : Array<String> = [ "\r\n", "\n\r", "\r", "\n" ];

	public static function detectLineBreak( string : String, ?fallback : String = null ) : String {

		return detectFirstUsedValue( string, LINE_BREAKS, fallback );
	}

	public static function indexOf( string : String, searchStringsArray : Array<String>, ?startIndex : Int = 0) : Int
	{
		var firstIndex : Int = -1;

		for ( i in 0...searchStringsArray.length ) {

			var searchString : String = searchStringsArray[ i ];
			var index : Int = string.indexOf( searchString, startIndex );
			if ( index != -1 ) {

				if ( firstIndex == -1 || index < firstIndex ) {

					firstIndex = index;
				}
			}
		}

		return firstIndex;
	}

	/* Returns a list of indexes or null if no index was found */
	public static function indexesOf( string : String, searchString : String ) : Array<Int> {

		var indexes : Array<Int> = null;

		var index : Int = string.indexOf( searchString );
		while ( 0 <= index ) {

			if ( indexes == null ) {

				// create on demand
				indexes = [];
			}

			indexes[ indexes.length ] = index;

			// find next
			index = string.indexOf( searchString, index + searchString.length );
		}

		return indexes;
	}

	public static function countOf( string : String, searchString : String ) : Int {

		var count : Int = 0;

		var index : Int = string.indexOf( searchString );
		while ( 0 <= index ) {

			++count;

			// find next
			index = string.indexOf( searchString, index + searchString.length );
		}

		return count;
	}

	public static function endsWith( string : String, end : String ) : Bool {

		var lastIndex : Int = string.lastIndexOf( end );
		return ( lastIndex != -1 && lastIndex == string.length - end.length );
	}

	public static function startsWith( string : String, start : String ) : Bool {

		return ( string.indexOf( start ) == 0 );
	}

	public static function getStartEndIndexes( string : String, find : String ) : Array<Int> {

		var stringLength : Int = string.length;
		var findLength : Int = find.length;
		var ints : Array<Int> = null;

		if ( findLength <= stringLength ) {

			var startIndex : Int = string.indexOf( find );
			while ( startIndex != -1 ) {

				if ( ints == null ) {

					ints = [];
				}

				var endIndex : Int = startIndex + findLength;

				ints[ ints.length ] = startIndex;
				ints[ ints.length ] = endIndex;

				startIndex = string.indexOf( find, endIndex );
			}
		}

		return ints;
	}

	public static function fillLeft( string : String, fillString : String, minLength : Int ) : String {

		while ( string.length < minLength ) {

			string = fillString + string;
		}

		return string;
	}

	public static function fillRight( string : String, fillString : String, minLength : Int ) : String {

		while ( string.length < minLength ) {

			string = string + fillString;
		}

		return string;
	}

	public static function detectFirstUsedValue( string : String, possibleValues : Array<String>, ?fallback : String = null ) : String {

		for ( i in 0...possibleValues.length ) {

			var value = possibleValues[ i ];
			if ( string.indexOf( value ) != -1 ) {

				return value;
			}
		}

		return fallback;
	}

	public static function extract( string : String, prefix : String, suffix : String, prefixIndex : Int = 0, suffixIndex : Int = 0 ) : String
	{
		if ( string == null || prefix == null || suffix == null ) return null;
		if ( string.length == 0 || prefix.length == 0 || suffix.length == 0 ) return null;

		prefixIndex = string.indexOf( prefix, prefixIndex );
		if ( prefixIndex == -1 ) return null;

			suffixIndex = Std.int( Math.max( suffixIndex, prefixIndex + 1 ) );
			suffixIndex = string.indexOf( suffix, suffixIndex );
		if ( suffixIndex == -1 ) return null;

		return string.substring( prefixIndex + prefix.length, suffixIndex );
	}

	public static inline function hasLength( string : String ) : Bool {

		return ( string != null && 0 < string.length );
	}

	public static inline function contains( string : String, searchString : String ) : Bool {

		var index : Int = -1;

		if ( string != null && searchString != null ) {

			index = string.indexOf( searchString );
		}

		return ( index != -1 );
	}

	public static function getPrefix( urlA : String, urlB : String ) : String {

		var c : Int = cast Math.min( urlA.length, urlB.length );
		for ( i in 0...c ) {

			if ( urlA.charAt( i ) != urlB.charAt( i ) ) {

				return urlA.substr( 0, i );
			}
		}

		return urlA.substr( 0, c );
	}

	public static function replace( string : String, search : String, replace : String ) : String {

		if ( string.indexOf( search ) != -1 ) {

			string = string.split( search ).join( replace );
		}

		return string;
	}

	public static function replaceWhile( string : String, search : String, replace : String ) : String {

		while ( string.indexOf( search ) != -1 ) {

			string = string.split( search ).join( replace );
		}

		return string;
	}

	public static function replaceMap( string : String, replaceMap : Map<String,String> ) : String {

		for ( key in replaceMap.keys() ) {

			if ( string.indexOf( key ) != -1 ) {

				string = string.split( key ).join( replaceMap.get( key ) );
			}
		}

		return string;
	}

	public static function replaceNonAlphaNumeric( string : String, ?replaceString : String = "" ) : String {

		var r = ~/[^a-zA-Z0-9]+/g;
		return r.replace( string, replaceString );
	}

	public static function trim( string : String, ?char : String = " " ) : String {

		while ( string.indexOf( char ) == 0 ) {

			string = string.substr( char.length );
		}

		while ( string.lastIndexOf( char ) != -1 && string.lastIndexOf( char ) == string.length - char.length ) {

			string = string.substr( 0, string.length - char.length );
		}

		return string;
	}

	public static function trimLeft( string : String, ?char : String = " " ) : String {

		while ( string.indexOf( char ) == 0 ) {

			string = string.substr( char.length );
		}

		return string;
	}

	public static function trimRight( string : String, ?char : String = " " ) : String {

		while ( string.lastIndexOf( char ) != -1 && string.lastIndexOf( char ) == string.length - char.length ) {

			string = string.substr( 0, string.length - char.length );
		}

		return string;
	}

	public static function upperCaseLeft( string : String, ?chars : Int = 1 ) : String {

		if ( chars <= string.length ) {

			string = string.substr( 0, chars ).toUpperCase() + string.substr( chars );
		}

		return string;
	}
}
