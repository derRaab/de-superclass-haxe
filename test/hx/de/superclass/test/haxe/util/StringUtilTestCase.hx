package de.superclass.test.haxe.util;

import de.superclass.haxe.util.StringUtil;
import de.superclass.haxe.utest.TestCase;

class StringUtilTestCase extends TestCase {

    public function testContains() {

        assertTrue( StringUtil.contains( "a", "a" ) );
        assertTrue( StringUtil.contains( "abc", "a" ) );
        assertTrue( StringUtil.contains( "abc", "b" ) );
        assertTrue( StringUtil.contains( "abc", "c" ) );

        assertFalse( StringUtil.contains( "a", "b" ) );
        assertFalse( StringUtil.contains( "abc", "cd" ) );
        assertFalse( StringUtil.contains( "abc", "cba" ) );
    }

    public function testCountOf() {

        assertEquals( StringUtil.countOf( "a", "a" ), 1 );
        assertEquals( StringUtil.countOf( "a", "b" ), 0 );
        assertEquals( StringUtil.countOf( "", "b" ), 0 );
        assertEquals( StringUtil.countOf( "bbb", "b" ), 3 );
        assertEquals( StringUtil.countOf( "bbb", "bb" ), 1 );
    }

    public function testDetectFirstUsedValue() {

        assertEquals( StringUtil.detectFirstUsedValue( "a", [ "a" ] ), "a" );
        assertEquals( StringUtil.detectFirstUsedValue( "aa", [ "aa", "a" ] ), "aa" );
        assertEquals( StringUtil.detectFirstUsedValue( "", [ "aa", "a" ] ), null );
        assertEquals( StringUtil.detectFirstUsedValue( "", [ "aa", "a" ], "C" ), "C" );
    }
}
