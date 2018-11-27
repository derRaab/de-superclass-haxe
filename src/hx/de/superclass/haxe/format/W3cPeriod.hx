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

package de.superclass.haxe.format;

import de.superclass.haxe.util.FloatUtil;
import de.superclass.haxe.util.StringUtil;
import de.superclass.haxe.util.TimeUtil;

/**
	`W3cPeriod` provides simple helper methods to work with w3c formatted period strings.

	@see https://www.w3schools.com/xml/schema_dtypes_date.asp (Duration Data Type) and
	https://www.w3.org/TR/xmlschema-2/#duration
 **/
class W3cPeriod {

	public static var DAYS_IN_YEAR : Float = 365.0;
	public static var DAYS_IN_MONTH : Float = 30.0;
	public static var TO_MILLISECONDS_FAILED_FALLBACK : Float = 0.0;

	public static function fromMilliseconds( milliseconds : Float, secondFractionDigits : Int = 0 ) : String {

		if ( milliseconds == 0 ) {

			return "PT0S"; // no time at all
		}

		var negative : Bool = ( milliseconds < 0 );
		if ( negative ) {

			milliseconds *= -1;
		}

		var days : Float = Math.floor( TimeUtil.millisecondsToDays( milliseconds ) );
		if ( 0 < days ) {

			milliseconds -= TimeUtil.daysToMilliseconds( days );
		}

		var hours : Float = Math.floor( TimeUtil.millisecondsToHours( milliseconds ) );
		if ( 0 < hours ) {

			milliseconds -= TimeUtil.hoursToMilliseconds( hours );
		}

		var minutes : Float = Math.floor( TimeUtil.millisecondsToMinutes( milliseconds ) );
		if ( 0 < minutes ) {

			milliseconds -= TimeUtil.minutesToMilliseconds( minutes );
		}

		var seconds : Float = FloatUtil.fixed( TimeUtil.millisecondsToSeconds( milliseconds ), secondFractionDigits );

		var period : String = "P";

		if ( 0 < days ) {

			period += days + "D";
		}

		var time : String = "T";

		if ( 0 < hours ) {

			time += hours + "H";
		}

		if ( 0 < minutes ) {

			time += minutes + "M";
		}

		if ( 0 < seconds ) {

			time += seconds + "S";
		}

		if ( 1 < time.length ) {

			period += time;
		}

		if ( 1 == period.length ) {

			return "PT0S"; // no time at all
		}

		if ( negative ) {

			return "-" + period;
		}

		return period;
	}

	public static function toMilliseconds( w3cPeriod : String ) : Float {

		if ( w3cPeriod == "PT0S" ) {

			return 0.0;
		}

		// detect negative -
		var negative : Bool = ( w3cPeriod.charAt( 0 ) == "-" );
		if ( negative ) {

			w3cPeriod = w3cPeriod.substr( 1 );
		}

		var milliseconds : Float = 0.0;

		// remove leading P
		if( w3cPeriod.charAt( 0 ) == "P" ) {

			w3cPeriod = w3cPeriod.substr( 1 );
		}
		else {

			// No leading "P" found
			return TO_MILLISECONDS_FAILED_FALLBACK;
		}

		var w3cPeriodDayPart : String = null;
		var w3cPeriodTimePart : String = null;

		if ( w3cPeriod.indexOf( "T" ) != -1 ) {

			var w3cPeriodParts : Array<String> = w3cPeriod.split( "T" );
			w3cPeriodDayPart = w3cPeriodParts[ 0 ];
			w3cPeriodTimePart = w3cPeriodParts[ 1 ];
		}
		else {

			// No separator found
			w3cPeriodDayPart = w3cPeriod;
			w3cPeriodTimePart = "";
		}

		var w3cPeriodDaySeparators : Array<String> = "YnMnD".split( "n" );
		var w3cPeriodTimeSeparators : Array<String> = "HnMnS".split( "n" );

		var separators : Array<String> = w3cPeriodDaySeparators;
		var w3cPeriodPart : String = w3cPeriodDayPart;

		if ( StringUtil.hasLength( w3cPeriodPart ) ) {

			while ( 0 < w3cPeriodPart.length ) {

				var separator : String = separators.shift();
				if ( separator != null ) {

					var index : Int = w3cPeriodPart.indexOf( separator );
					if ( index != -1 ) {

						var n : Float = Std.parseFloat( w3cPeriodPart );
						if ( 0 < n ) {

							switch( w3cPeriodPart.charAt( index ) ) {

								case "Y": n = TimeUtil.daysToMilliseconds( n * DAYS_IN_YEAR );
								case "M": n = TimeUtil.daysToMilliseconds( n * DAYS_IN_MONTH );
								case "D": n = TimeUtil.daysToMilliseconds( n );
								default: n;
							}

							milliseconds += n;
						}

						w3cPeriodPart = w3cPeriodPart.substr( index + 1 );
					}
				}
				else {

					// Invalid format
					return TO_MILLISECONDS_FAILED_FALLBACK;
				}
			}
		}

		var separators : Array<String> = w3cPeriodTimeSeparators;
		var w3cPeriodPart : String = w3cPeriodTimePart;

		if ( StringUtil.hasLength( w3cPeriodPart ) ) {

			while ( 0 < w3cPeriodPart.length ) {

				var separator : String = separators.shift();
				if ( separator != null ) {

					var index : Int = w3cPeriodPart.indexOf( separator );
					if ( index != -1 ) {

						var n : Float = Std.parseFloat( w3cPeriodPart );
						if ( 0 < n ) {

							switch( w3cPeriodPart.charAt( index ) ) {

								case "H": n = TimeUtil.hoursToMilliseconds( n );
								case "M": n = TimeUtil.minutesToMilliseconds( n );
								case "S": n = TimeUtil.secondsToMilliseconds( n );
								default: n;
							}

							milliseconds += n;
						}

						w3cPeriodPart = w3cPeriodPart.substr( index + 1 );
					}
				}
				else {

					// Invalid format
					return TO_MILLISECONDS_FAILED_FALLBACK;
				}
			}
		}

		if ( negative ) {

			milliseconds *= -1;
		}

		return milliseconds;
	}
}
