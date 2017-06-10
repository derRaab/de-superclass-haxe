package de.superclass.test.haxe.util;

import de.superclass.haxe.util.AsciiUtil;
import haxe.unit.TestCase;

class AsciiUtilTestCase extends TestCase {

    public function testHasAccents() {

        assertTrue( AsciiUtil.hasAccents( "ä" ) );
        assertFalse( AsciiUtil.hasAccents( "a" ) );
    }

    public function testRemoveAccents() {

        assertEquals( AsciiUtil.removeAccents( "ä" ), "a" );
        assertEquals( AsciiUtil.removeAccents( "ö" ), "o" );
    }
}
