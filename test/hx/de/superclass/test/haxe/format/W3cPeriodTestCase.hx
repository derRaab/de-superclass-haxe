package de.superclass.test.haxe.format;

import de.superclass.haxe.format.W3cPeriod;
import de.superclass.haxe.utest.TestCase;

class W3cPeriodTestCase extends TestCase {

    public function testFromMilliseconds() {

        var millisecondsSecond : Float = 1000.0;
        var millisecondsMinute : Float = 60 * millisecondsSecond;
        var millisecondsHour : Float = 60 * millisecondsMinute;
        var millisecondsDay : Float = 24 * millisecondsHour;

        assertEquals( "PT0S", W3cPeriod.fromMilliseconds( 0 ) );
        assertEquals( "PT1S", W3cPeriod.fromMilliseconds( millisecondsSecond ) );
        assertEquals( "PT1M", W3cPeriod.fromMilliseconds( millisecondsMinute ) );
        assertEquals( "PT1H", W3cPeriod.fromMilliseconds( millisecondsHour ) );
        assertEquals( "P1D", W3cPeriod.fromMilliseconds( millisecondsDay ) );
        assertEquals( "P1DT1S", W3cPeriod.fromMilliseconds( millisecondsDay + millisecondsSecond ) );
        assertEquals( "P24D", W3cPeriod.fromMilliseconds( 24 * millisecondsDay ) );
    }

    public function testToMilliseconds() {

        var millisecondsSecond : Float = 1000.0;
        var millisecondsMinute : Float = 60 * millisecondsSecond;
        var millisecondsHour : Float = 60 * millisecondsMinute;
        var millisecondsDay : Float = 24 * millisecondsHour;

        assertEquals( 0.0, W3cPeriod.toMilliseconds( "PT0" ) );
        assertEquals( 0.0, W3cPeriod.toMilliseconds( "T0S" ) );
        assertEquals( 0.0, W3cPeriod.toMilliseconds( "PT0S" ) );
        assertEquals( millisecondsSecond, W3cPeriod.toMilliseconds( "PT1S" ) );
        assertEquals( millisecondsMinute, W3cPeriod.toMilliseconds( "PT1M" ) );
        assertEquals( millisecondsHour, W3cPeriod.toMilliseconds( "PT1H" ) );
        assertEquals( millisecondsDay, W3cPeriod.toMilliseconds( "P1D" ) );
        assertEquals( millisecondsDay + millisecondsSecond, W3cPeriod.toMilliseconds( "P1DT1S" ) );
        assertEquals( 24 * millisecondsDay, W3cPeriod.toMilliseconds( "P24D" ) );
    }
}
