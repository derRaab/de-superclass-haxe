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
				while ( fractionsString.length < 4 ) {

					fractionsString += "0";
				}
			}
			else {

				fractionsString = ".000";
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

	/**
		Parses a nicely for formatted time period string to `seconds`(e.g. 00:00:01.000 -> 1).

		By default `separator = :` is used as convenient separator
	**/
	public static function playbackStringToSeconds( playbackString : String, ?separator : String = ":" ) : Float {

		if ( playbackString != null ) {

			playbackString = StringUtil.trim( playbackString );

			if ( StringUtil.hasLength( playbackString ) ) {

				if ( StringUtil.contains( playbackString, separator ) ) {

					var partStrings : Array<String> = playbackString.split( separator );
					var partFloats : Array<Float> = [];
					for ( i in 0...partStrings.length ) {

						var partString : String = partStrings[ i ];
						var partFloat : Float = Std.parseFloat( partString );
						if ( FloatUtil.isNaN( partFloat ) ) {

							return partFloat;
						}

						partFloats[ partFloats.length ] = partFloat;
					}

					partFloats.reverse();

					var seconds : Float = 0;

					for ( i in 0...partFloats.length ) {

						var partFloat : Float = partFloats[ i ];
						if ( i == 0 ) {

							// seconds
							seconds += partFloat;
						}
						else if ( i == 1 ) {

							// minutes
							seconds += partFloat * 60;
						}
						else if ( i == 2 ) {

							// hours
							seconds += partFloat * 60 * 60;
						}
					}

					return seconds;
				}
			}
		}

		return Math.NaN;
	}

	public static inline function daysToHours( days : Float ) : Float {

		return days * 24.0;
	}

	public static inline function daysToMinutes( days : Float ) : Float {

		return hoursToMinutes( daysToHours( days ) );
	}

	public static inline function daysToSeconds( days : Float ) : Float {

		return minutesToSeconds( hoursToMinutes( daysToHours( days ) ) );
	}

	public static inline function daysToMilliseconds( days : Float ) : Float {

		return secondsToMilliseconds( minutesToSeconds( hoursToMinutes( daysToHours( days ) ) ) );
	}



	public static inline function hoursToDays( hours : Float ) : Float {

		return hours / 24.0;
	}

	public static inline function hoursToMinutes( hours : Float ) : Float {

		return hours * 60.0;
	}

	public static inline function hoursToSeconds( hours : Float ) : Float {

		return minutesToSeconds( hoursToMinutes( hours ) );
	}

	public static inline function hoursToMilliseconds( hours : Float ) : Float {

		return secondsToMilliseconds( minutesToSeconds( hoursToMinutes( hours ) ) );
	}



	public static inline function minutesToDays( minutes : Float ) : Float {

		return hoursToDays( minutesToHours( minutes ) );
	}

	public static inline function minutesToHours( minutes : Float ) : Float {

		return minutes / 60.0;
	}

	public static inline function minutesToSeconds( minutes : Float ) : Float {

		return minutes * 60.0;
	}

	public static inline function minutesToMilliseconds( minutes : Float ) : Float {

		return secondsToMilliseconds( minutesToSeconds( minutes ) );
	}



	public static inline function secondsToDays( seconds : Float ) : Float {

		return hoursToDays( minutesToHours( secondsToMinutes( seconds ) ) );
	}

	public static inline function secondsToHours( seconds : Float ) : Float {

		return minutesToHours( secondsToMinutes( seconds ) );
	}

	public static inline function secondsToMinutes( seconds : Float ) : Float {

		return seconds / 60.0;
	}

	public static inline function secondsToMilliseconds( seconds : Float ) : Float {

		return seconds * 1000.0;
	}



	public static inline function millisecondsToDays( milliseconds : Float ) : Float {

		return hoursToDays( minutesToHours( secondsToMinutes( millisecondsToSeconds( milliseconds ) ) ) );
	}

	public static inline function millisecondsToHours( milliseconds : Float ) : Float {

		return minutesToHours( secondsToMinutes( millisecondsToSeconds( milliseconds ) ) );
	}

	public static inline function millisecondsToMinutes( milliseconds : Float ) : Float {

		return secondsToMinutes( millisecondsToSeconds( milliseconds ) );
	}

	public static inline function millisecondsToSeconds( milliseconds : Float ) : Float {

		return milliseconds / 1000.0;
	}
}
