package de.superclass.test.haxe.util;

import de.superclass.haxe.utest.TestCase;
import de.superclass.haxe.util.AsciiUtil;

class AsciiUtilTestCase extends TestCase {

    public function testHasAccents() {

        assertTrue( AsciiUtil.hasAccents( "ä" ) );
        assertTrue( AsciiUtil.hasAccents( "aä" ) );
        assertFalse( AsciiUtil.hasAccents( "a" ) );
    }

    public function testRemoveAccents() {

        assertEquals( AsciiUtil.removeAccents( "ä" ), "a" );
        assertEquals( AsciiUtil.removeAccents( "aä" ), "aa" );
        assertEquals( AsciiUtil.removeAccents( "ö" ), "o" );
        assertEquals( AsciiUtil.removeAccents( "oö" ), "oo" );
    }
}
