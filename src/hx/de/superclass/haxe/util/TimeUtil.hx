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

import de.superclass.haxe.util.StringUtil;

/**
	`TimeUtil` provides simple helper methods to avoid careless calculation mistakes and some time related formating methods.
**/
class TimeUtil {

	public static inline function millisecondsToDays( milliseconds : Float ) : Float {

		return millisecondsToHours( milliseconds ) / 24;
	}

	public static inline function millisecondsToHours( milliseconds : Float ) : Float {

		return millisecondsToMinutes( milliseconds ) / 60;
	}

	public static inline function millisecondsToMinutes( milliseconds : Float ) : Float {

		return millisecondsToSeconds( milliseconds ) / 60;
	}

	public static inline function millisecondsToSeconds( milliseconds : Float ) : Float {

		return milliseconds / 1000;
	}

	public static inline function daysToMilliseconds( days : Float ) : Float {

		return hoursToMilliseconds( days * 24 );
	}

	public static inline function hoursToMilliseconds( hours : Float ) : Float {

		return minutesToMilliseconds( hours * 60 );
	}

	public static inline function minutesToMilliseconds( minutes : Float ) : Float {

		return secondsToMilliseconds( minutes * 60 );
	}

	public static inline function secondsToMilliseconds( seconds : Float ) : Float {

		return seconds * 1000;
	}

	/**
		Creates a nicely formatted time period string from `seconds` perfectly usable for video playback controls (e.g. 0 -> 0:00).

		By default `separator = :` is used as convenient separator,
		`roundSeconds` will avoid second fractions,
		`forceMinutes` will ensure displayed minutes and
		`forceHours` won't ensure displayed hours.
	**/
	public static function secondsToPlaybackString( seconds : Float, ?separator : String = ":", ?roundSeconds : Bool = true, ?forceMinutes : Bool = true, ?forceHours : Bool = false ) : String {

		var fractionsString : String = "";

		if ( roundSeconds ) {

			seconds = Math.round( seconds );
		}
		else {

			fractionsString = "" + seconds;

			var fractionsStringStartIndex : Int = fractionsString.indexOf( "." );
			var hasFractions : Bool = ( fractionsStringStartIndex != -1 );
			if ( hasFractions ) {

				fractionsString = fractionsString.substr( fractionsStringStartIndex );
			}
			else {

				fractionsString = "";
			}

			seconds = Math.floor( seconds );
		}

		var milliseconds : Float = seconds * 1000;

		var hours : Float = Math.floor( millisecondsToHours( milliseconds ) );
		if ( 0 < hours ) {

			milliseconds -= hoursToMilliseconds( hours );
		}

		var minutes : Float = Math.floor( millisecondsToMinutes( milliseconds ) );
		if ( 0 < minutes ) {

			milliseconds -= minutesToMilliseconds( minutes );
		}

		seconds = millisecondsToSeconds( milliseconds );

		var useHours : Bool = ( 0 < hours || forceHours );
		var useMinutes : Bool = ( useHours || 0 < minutes || forceMinutes );

		var string : String = "";

		if ( useHours ) {

			string += hours + separator;
		}

		if ( useMinutes ) {

			if ( useHours ) {

				string += StringUtil.fillLeft( "" + minutes, "0", 2 ) + separator;
			}
			else {

				string += minutes + separator;
			}
		}

		if ( useMinutes ) {

			string += StringUtil.fillLeft( "" + seconds, "0", 2 );
		}
		else {

			string += seconds;
		}

		string += fractionsString;

		return string;
	}
}
