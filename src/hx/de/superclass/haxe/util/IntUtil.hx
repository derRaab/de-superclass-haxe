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
	`IntUtil` provides simple helper methods to work with integers.
**/
class IntUtil {

    // See https://github.com/aduros/flambe/blob/master/src/flambe/math/FMath.hx
    /** The highest integer value in Flash and JS. */
    public static var MAX_VALUE :Int = 2147483647;
    /** The lowest integer value in Flash and JS. */
    public static var MIN_VALUE :Int = -2147483648;

    /** Return a random integer between 0 (inclusive) and the given integer (inclusive) **/
    public static function random( int : Int ) : Int {

        if ( int == 0 ) return 0;
        return Std.int( Math.round( Math.random() * int ) );
    }

    /** Return the list of prime factors for a given integer **/
    public static function primeFactors( n : Int ) : Array<Int> {

        var factors : Array<Int> = [];

        var i : Int = 2;
        while ( i <=n ) {

            while ( n % i == 0 ) {

                factors.push( i );
                n = Std.int( n / i );
            }
            i++;
        }

        if ( n > 1 ) {

            factors.push( n );
        }

        return factors;
    }
}
