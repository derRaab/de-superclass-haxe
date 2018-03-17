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
	`DateUtil` provides simple helper methods to work with `Date` instances and related time values.
**/
import de.superclass.haxe.util.TimeUtil;

class DateUtil {

    private static var _localTimezoneOffsetSeconds : Float = -1;

    private inline static var _TIME_SEPARATOR : String = "T";
    private inline static var _TIME_ZONE_DESIGNATOR_UTC : String = "Z";
    private inline static var _TIME_ZONE_DESIGNATOR_PLUS : String = "+";
    private inline static var _TIME_ZONE_DESIGNATOR_MINUS : String = "-";

    private static var _TIME_ZONE_DESIGNATOR_PREFIXES : Array<String> = [ _TIME_ZONE_DESIGNATOR_UTC, _TIME_ZONE_DESIGNATOR_PLUS, _TIME_ZONE_DESIGNATOR_MINUS ];

    public static function getLocalTimeStampSecondsW3cDtf( timestampSeconds : Float ) : String {

        var timestampSecondsFull : Float = Math.floor( timestampSeconds );
        var timestampSecondsFraction : String = "";
        // Avoid rounding problems but detect fractions:
        var timestampSecondsString : String = timestampSeconds + "";
        var dotIndex : Int = timestampSecondsString.indexOf( "." );
        if ( dotIndex != -1 ) {

            timestampSecondsFraction = timestampSecondsString.substr( dotIndex );
        }

        var timestampMilliseconds : Float = timestampSeconds * 1000;
        var date : Date = Date.fromTime( timestampMilliseconds );

        var dtf : String = "";

        dtf += date.getFullYear();
        dtf += "-";
        dtf += StringUtil.fillLeft( Std.string( date.getMonth() + 1 ), "0" , 2);
        dtf += "-";
        dtf += StringUtil.fillLeft( Std.string( date.getDate() ), "0" , 2 );
        dtf += "T";
        dtf += StringUtil.fillLeft( Std.string( date.getHours() ), "0", 2 );
        dtf += ":";
        dtf += StringUtil.fillLeft( Std.string( date.getMinutes() ), "0", 2 );
        dtf += ":";
        dtf += StringUtil.fillLeft( Std.string( date.getSeconds() ), "0", 2 );
        dtf += timestampSecondsFraction;

        return dtf;
    }

    public static function isSameDate( a : Date, b : Date ) : Bool {

        return (    a.getFullYear() == b.getFullYear() &&
                    a.getMonth() == b.getMonth() &&
                    a.getDate() == b.getDate() );
    }

    /**
     * Parses dates that conform to the W3C Date-time Format into Date objects.
	 * Timezone designators will be ignored. Use getTimezoneOffsetSecondsFromW3cDtf to extract it
	 *
	 * @param w3cDtf		W3C Date-time Format string (or similar)
	 * @returns             Seconds from 1.1.1970
	 *
	 * @see http://www.w3.org/TR/NOTE-datetime
	 */
    public static function getLocalTimeStampSecondsFromW3cDtf( w3cDtf : String ) : Float {

        var c : Int = w3cDtf.length;

        var year : Int = 0;
        var month : Int = 0;
        var day : Int = 0;
        var hour : Int = 0;
        var min : Int = 0;
        var sec : Int = 0;

        if (4 <= c)
        {
            year = Std.parseInt( w3cDtf.substr(0, 4) );
        }

        if (7 <= c)
        {
            month = Std.parseInt( w3cDtf.substr( 5, 2 ) ) - 1;
        }

        if (10 <= c)
        {
            day = Std.parseInt( w3cDtf.substr( 8, 2 ) );
        }

        if (13 <= c)
        {
            hour = Std.parseInt( w3cDtf.substr( 11, 2 ) );
        }

        if (16 <= c)
        {
            min = Std.parseInt( w3cDtf.substr( 14, 2 ) );
        }

        if (19 <= c)
        {
            sec = Std.parseInt( w3cDtf.substr( 17, 2 ) );
        }

        var timeZoneDesignatorIndex : Int = getTimezoneOffsetStartIndexFromW3cDtf( w3cDtf );

        // Create date (no support for milliseconds)
        var date : Date = new Date( year, month, day, hour, min, sec );
        var timeStampMilliseconds : Float = date.getTime();

        if (21 <= c && w3cDtf.charAt(19) == ".")
        {
            var millisecondsString : String = "";

            if (timeZoneDesignatorIndex == -1)
            {
                millisecondsString = w3cDtf.substr(20);
            }
            else
            {
                millisecondsString = w3cDtf.substring(20, timeZoneDesignatorIndex);
            }

            var millisecondsSeconds : Float = Std.parseFloat( "0." + millisecondsString );
            timeStampMilliseconds += millisecondsSeconds * 1000;
        }

        var timeStampSeconds : Float = ( timeStampMilliseconds == 0 ) ? 0 : timeStampMilliseconds / 1000;
        return timeStampSeconds;
    }

    /**
	 * Parses timezone designators from W3C Datetime format into seconds.
	 *
	 * @param w3cDtf		W3C Date-time Format string (or similar)
	 * @returns			Timezone offset in seconds e.g z -> 0 | -01:00 -> -3600 | +02:00 -> 7200
	 *
	 * @see http://www.w3.org/TR/NOTE-datetime
	 */
    public static function getTimezoneOffsetSecondsFromW3cDtf( w3cDtf : String ) : Float {

        var tzd : String = getTimezoneOffsetFromW3cDtf( w3cDtf );
        if ( StringUtil.hasLength( tzd ) ) {

            var firstChar : String = tzd.charAt( 0 );
            switch( firstChar ) {

                case _TIME_ZONE_DESIGNATOR_UTC:

                    return 0;

                case _TIME_ZONE_DESIGNATOR_PLUS, _TIME_ZONE_DESIGNATOR_MINUS:

                    var hoursString : String = tzd.substr( 1, 2 );
                    var minutesString : String = tzd.substr( 4, 2 );

                    var hours : Float = Std.parseFloat( hoursString );
                    var minutes : Float = Std.parseFloat( minutesString );

                    minutes += hours * 60;

                    if ( firstChar == _TIME_ZONE_DESIGNATOR_MINUS ) {

                        minutes *= -1;
                    }

                    return minutes * 60;
            }
        }

        return Math.NaN;
    }

    public static function getTimezoneOffsetStartIndexFromW3cDtf( w3cDtf : String ) : Int {

        var timeZoneDesignatorStartIndex : Int = StringUtil.indexOf( w3cDtf, _TIME_ZONE_DESIGNATOR_PREFIXES );

        var zIndex : Int = w3cDtf.indexOf( _TIME_ZONE_DESIGNATOR_UTC );
        if ( zIndex != -1 ) {

            return zIndex;
        }

        var plusIndex : Int = w3cDtf.indexOf( _TIME_ZONE_DESIGNATOR_PLUS );
        if ( plusIndex != -1 ) {

            return plusIndex;
        }

        var timeSeparatorIndex : Int = w3cDtf.lastIndexOf( _TIME_SEPARATOR );
        if ( timeSeparatorIndex != -1 ) {

            var minusIndex : Int = w3cDtf.indexOf( _TIME_ZONE_DESIGNATOR_MINUS, timeSeparatorIndex );
            if ( minusIndex != -1 ) {

                return minusIndex;
            }
        }

        return -1;
    }

    public static function getTimezoneOffsetFromW3cDtf( w3cDtf : String ) : String {

        var index : Int = getTimezoneOffsetStartIndexFromW3cDtf( w3cDtf );
        if ( index != -1 ) {

            return w3cDtf.substr( index );
        }

        return null;
    }

    /**
		Returns the default timezone offset in seconds for created `Date` instances. (GMT + 1 would return 3600).

		Since the Haxe `Date` implementation doesn't provide an UTC api for all platforms, this is a convienient way to detect
		how much timezone offset (in seconds) a new created `Date` instance includes.

		If this returns 0, it just means no timezone offset is available. It doesn't ensure this date instance represents
		actual UTC time, but that the platform doesn't apply any offset to new instances!
	**/
    public static function getDefaultTimezoneOffsetSeconds() : Float {

        var localTimezoneOffsetSeconds : Float = _localTimezoneOffsetSeconds;
        if ( localTimezoneOffsetSeconds == -1 ) {

            _localTimezoneOffsetSeconds = localTimezoneOffsetSeconds = _createDefaultTimezoneOffsetSeconds();
        }
        return localTimezoneOffsetSeconds;
    }

    private static function _createDefaultTimezoneOffsetSeconds() : Float {

        var offsetSeconds : Float = 0;

        var unixTimestampStartDate : Date = Date.fromTime( TimeUtil.daysToMilliseconds( 0 ) );
        var unixTimestampStartDateHours : Int = unixTimestampStartDate.getHours();
        if ( unixTimestampStartDateHours != 0 ) {

            var isNegativeTimezone : Bool = ( unixTimestampStartDate.getFullYear() < 1970 );
            if ( isNegativeTimezone ) {

                unixTimestampStartDateHours = unixTimestampStartDateHours - 24;
            }

            offsetSeconds +=  TimeUtil.millisecondsToSeconds( TimeUtil.hoursToMilliseconds( unixTimestampStartDateHours ) );
        }

        return offsetSeconds;
    }

    /**
		Returns the `date` as w3c date time format als described here: https://www.w3.org/TR/NOTE-datetime.
	**/
    public static function toW3cDtf( date : Date, ?secondFractionDigits : Int = 3, ?timezoneDesignator : Bool = true ) : String {

        var dtf : String = "";

        dtf += date.getFullYear();
        dtf += "-";
        dtf += StringUtil.fillLeft( Std.string( date.getMonth() + 1 ), "0" , 2);
        dtf += "-";
        dtf += StringUtil.fillLeft( Std.string( date.getDate() ), "0" , 2 );
        dtf += "T";
        dtf += StringUtil.fillLeft( Std.string( date.getHours() ), "0", 2 );
        dtf += ":";
        dtf += StringUtil.fillLeft( Std.string( date.getMinutes() ), "0", 2 );
        dtf += ":";
        dtf += StringUtil.fillLeft( Std.string( date.getSeconds() ), "0", 2 );

        if ( 0 < secondFractionDigits ) {

            var millisecondStamp : Float = date.getTime();
            var secondStamp : Float = millisecondStamp / 1000;
            var secondFractions : Float = FloatUtil.getFractions( secondStamp );
            if ( 0 < secondFractions ) {

                secondFractions = FloatUtil.fixed( secondFractions, secondFractionDigits );
                if ( 0 < secondFractions ) {

                    var secondFractionString : String = "" + secondFractions;
                    dtf += secondFractionString.substr( 1 );
                }
            }
        }

        if ( timezoneDesignator ) {

            var timezoneOffsetSeconds : Float = getDefaultTimezoneOffsetSeconds();
            if ( timezoneOffsetSeconds == 0 ) {

                dtf += _TIME_ZONE_DESIGNATOR_UTC;
            }
            else {

                if ( timezoneOffsetSeconds < 0 ) {

                    timezoneOffsetSeconds *= -1;
                    dtf += _TIME_ZONE_DESIGNATOR_MINUS;
                }
                else {

                    dtf += _TIME_ZONE_DESIGNATOR_PLUS;
                }

                var timezoneOffsetSecondsString : String = TimeUtil.secondsToPlaybackString( timezoneOffsetSeconds );
                if ( timezoneOffsetSecondsString.indexOf( ":" ) == 1 ) {

                    timezoneOffsetSecondsString = "0" + timezoneOffsetSecondsString;
                }
                dtf += timezoneOffsetSecondsString.substring( 0, timezoneOffsetSecondsString.lastIndexOf( ":" ) );
            }
        }

        return dtf;
    }

    /**
		Returns the `date` as w3c date time format als described here: https://www.w3.org/TR/NOTE-datetime.
	**/
    public static function fromW3cDtf( w3cDtf : String ) : Date {

        if ( StringUtil.hasLength( w3cDtf ) ) {

            // Timestamp without timezone offset created using local date object
            var localTimeStampSecondsFromW3cDtf : Float = getLocalTimeStampSecondsFromW3cDtf( w3cDtf );

            var w3cDtfHasTimezone : Bool = ( getTimezoneOffsetStartIndexFromW3cDtf( w3cDtf ) != -1 );
            if ( w3cDtfHasTimezone ) {

                // Remove current default timezone offset for local date objects (so now we have GMT time)
                var defaultOffsetSeconds : Float = getDefaultTimezoneOffsetSeconds();
                localTimeStampSecondsFromW3cDtf += defaultOffsetSeconds;

                // Add w3c timezone offset to
                var w3cDtfTimezoneOffset : Float = getTimezoneOffsetSecondsFromW3cDtf( w3cDtf );
                localTimeStampSecondsFromW3cDtf += w3cDtfTimezoneOffset;
            }

            return Date.fromTime( localTimeStampSecondsFromW3cDtf * 1000 );
        }

        return null;
    }

    public static function toLocaleDateString( date : Date ) : String {

        #if js
        return untyped date.toLocaleDateString();
        #else
        return date.toString();
        #end
    }
}
