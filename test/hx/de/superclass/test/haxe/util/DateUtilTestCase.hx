package de.superclass.test.haxe.util;

import de.superclass.haxe.utest.TestCase;
import de.superclass.haxe.util.DateUtil;
import de.superclass.haxe.util.StringUtil;

// TODO DateUtilTestCase ausbauen!
class DateUtilTestCase extends TestCase {

//    public function testGetLocalTimeStampSecondsFromW3cDtf() {
//
//        DateUtil.getLocalTimeStampSecondsFromW3cDtf;
//        DateUtil.getLocalTimeStampSecondsW3cDtf;
//        DateUtil.getTimezoneOffsetFromW3cDtf;
//        DateUtil.getTimezoneOffsetSecondsFromW3cDtf;
//        DateUtil.getTimezoneOffsetStartIndexFromW3cDtf;
//        DateUtil.isSameDate;
//        DateUtil.toW3cDtf();
//
////        assertEquals( 0.0, DateUtil.getLocalTimeStampSecondsFromW3cDtf( "1970-01-01T00:00:00") );
//    }

    public function testToW3cDtfUtc() {

        var nowZulu : String = DateUtil.toW3cDtfUtc( Date.now(), 0, true );
        assertTrue( StringUtil.endsWith( nowZulu, "Z" ) );
    }

    public function testToW3cDtf() {

        assertEquals( "2000-07-15T12:12:12", DateUtil.toW3cDtf( new Date( 2000, 6, 15, 12, 12, 12 ), 0, false ) );
    }

    public function testFromW3cDtf() {

        assertEquals( new Date( 1970, 0, 1, 0, 0, 0 ).getTime(), DateUtil.fromW3cDtf( "1970-01-01T00:00:00" ).getTime() );
        assertEquals( 0.0, DateUtil.fromW3cDtf( "1970-01-01T00:00:00Z" ).getTime() );
        assertEquals( 0.0, DateUtil.fromW3cDtf( "1970-01-01T00:00:00.00Z" ).getTime() );
        assertEquals( 3600000.0, DateUtil.fromW3cDtf( "1970-01-01T00:00:00+01:00" ).getTime() );
        assertEquals( 3600000.0, DateUtil.fromW3cDtf( "1970-01-01T00:00:00.00+01:00" ).getTime() );
        assertEquals( -3600000.0, DateUtil.fromW3cDtf( "1970-01-01T00:00:00-01:00" ).getTime() );
        assertEquals( -3600000.0, DateUtil.fromW3cDtf( "1970-01-01T00:00:00.00-01:00" ).getTime() );
    }

    public function testGetTimezoneOffsetFromW3cDtf() {

        assertEquals( null, DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00" ) );
        assertEquals( "Z", DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00Z" ) );
        assertEquals( "Z", DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00.00Z" ) );
        assertEquals( "+01:00", DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00+01:00" ) );
        assertEquals( "+01:00", DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00.00+01:00" ) );
        assertEquals( "-01:00", DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00-01:00" ) );
        assertEquals( "-01:00", DateUtil.getTimezoneOffsetFromW3cDtf( "1970-01-01T00:00:00.00-01:00" ) );
    }

    public function testGetTimezoneOffsetSecondsFromW3cDtf() {

        assertTrue( Math.isNaN( DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00" ) ) );
        assertEquals( 0.0, DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00Z" ) );
        assertEquals( 0.0, DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00.00Z" ) );
        assertEquals( 3600.0, DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00+01:00" ) );
        assertEquals( 3600.0, DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00.00+01:00" ) );
        assertEquals( -3600.0, DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00-01:00" ) );
        assertEquals( -3600.0, DateUtil.getTimezoneOffsetSecondsFromW3cDtf( "1970-01-01T00:00:00.00-01:00" ) );
    }

    public function testGetTimezoneOffsetStartIndexFromW3cDtf() {

        assertEquals( -1, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00" ) );
        assertEquals( 19, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00Z" ) );
        assertEquals( 22, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00.00Z" ) );
        assertEquals( 19, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00+01:00" ) );
        assertEquals( 22, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00.00+01:00" ) );
        assertEquals( 19, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00-01:00" ) );
        assertEquals( 22, DateUtil.getTimezoneOffsetStartIndexFromW3cDtf( "1970-01-01T00:00:00.00-01:00" ) );
    }

    public function testIsSameDate() {

        var dateA : Date = new Date( 1970, 1, 1, 1, 1, 1 );
        var dateB : Date = new Date( 1970, 1, 1, 1, 1, 1 );
        var dateC : Date = new Date( 1970, 1, 1, 1, 1, 2 );
        var dateD : Date = new Date( 1970, 1, 2, 1, 1, 2 );

        assertTrue( DateUtil.isSameDate( dateA, dateA ) );
        assertTrue( DateUtil.isSameDate( dateA, dateB ) );
        assertTrue( DateUtil.isSameDate( dateA, dateC ) );
        assertFalse( DateUtil.isSameDate( dateA, dateD ) );
    }
}
