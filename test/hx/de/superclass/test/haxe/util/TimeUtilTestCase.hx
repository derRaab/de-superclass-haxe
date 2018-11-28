package de.superclass.test.haxe.util;

import de.superclass.haxe.utest.TestCase;
import de.superclass.haxe.util.TimeUtil;

class TimeUtilTestCase extends TestCase {

    public function testDaysToHours() {

        assertEquals( TimeUtil.daysToHours( 1 ), 24 );
    }

    public function testDaysToMinutes() {

        assertEquals( TimeUtil.daysToMinutes( 1 ), 24 * 60 );
    }

    public function testDaysToSeconds() {

        assertEquals( TimeUtil.daysToSeconds( 1 ), 24 * 60 * 60 );
    }

    public function testDaysToMilliseconds() {

        assertEquals( TimeUtil.daysToMilliseconds( 1 ), 24 * 60 * 60 * 1000 );
    }

    public function testHoursToDays() {

        assertEquals( TimeUtil.hoursToDays( 24 ), 1 );
    }

    public function testHoursToMinutes() {

        assertEquals( TimeUtil.hoursToMinutes( 1 ), 60 );
    }

    public function testHoursToSeconds() {

        assertEquals( TimeUtil.hoursToSeconds( 1 ), 60 * 60  );
    }

    public function testHoursToMilliseconds() {

        assertEquals( TimeUtil.hoursToMilliseconds( 1 ), 60 * 60 * 1000  );
    }

    public function testMinutesToDays() {
        
        assertEquals( TimeUtil.minutesToDays( 24 * 60 ), 1 );
    }
    
    public function testMinutesToHours() {

        assertEquals( TimeUtil.minutesToHours( 60 ), 1 );
    }

    public function testMinutesToSeconds() {

        assertEquals( TimeUtil.minutesToSeconds( 1 ), 60 );
    }

    public function testMinutesToMilliseconds() {

        assertEquals( TimeUtil.minutesToMilliseconds( 1 ), 60 * 1000 );
    }

    public function testSecondsToDays() {

        assertEquals( TimeUtil.secondsToDays( 24 * 60 * 60 ), 1 );
    }

    public function testSecondsToHours() {

        assertEquals( TimeUtil.secondsToHours( 60 * 60 ), 1 );
    }

    public function testSecondsToMinutes() {

        assertEquals( TimeUtil.secondsToMinutes( 60 ), 1 );
    }

    public function testSecondsToMilliseconds() {

        assertEquals( TimeUtil.secondsToMilliseconds( 1 ), 1000 );
    }

    public function testMillisecondsToDays() {

        assertEquals( TimeUtil.millisecondsToDays( 24 * 60 * 60 * 1000 ), 1 );
    }

    public function testMillisecondsToHours() {

        assertEquals( TimeUtil.millisecondsToHours( 60 * 60 * 1000 ), 1 );
    }

    public function testMillisecondsToMinutes() {

        assertEquals( TimeUtil.millisecondsToMinutes( 60 * 1000 ), 1 );
    }

    public function testMillisecondsToSeconds() {

        assertEquals( TimeUtil.millisecondsToSeconds( 1000 ), 1 );
    }

    public function testSecondsToPlaybackString() {

        assertEquals( TimeUtil.secondsToPlaybackString( 0 ), "0:00" );
        assertEquals( TimeUtil.secondsToPlaybackString( 60 ), "1:00" );
    }
}
