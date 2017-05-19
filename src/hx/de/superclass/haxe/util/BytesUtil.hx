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
	`BytesUtil` provides simple helper methods to work with `haxe.io.Bytes`.
**/

import haxe.io.Bytes;

class BytesUtil {

	public static function copyTo( bytes : Bytes, pos : Int, length : Int, target : Bytes, targetPos : Int  ) : Void {

		for ( i in 0...length ) {

			target.set( targetPos + i, bytes.get( pos + i ) );
		}
	}

	public static function indexOfString( bytes : Bytes, string : String , ?startIndex : Int = 0 ) : Int {

		var stringLength : Int = string.length;
		var endIndex : Int = bytes.length - stringLength;
		var index : Int = startIndex;

		while ( index <= endIndex ) {

			var indexString : String = bytes.getString( index, stringLength );
			if ( indexString == string ) {

				return index;
			}

			++index;
		}

		return -1;
	}
}
