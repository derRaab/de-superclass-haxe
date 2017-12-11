package de.superclass.test.haxe.util;

import de.superclass.haxe.utest.TestCase;
import de.superclass.haxe.util.BoolUtil;

class BoolUtilTestCase extends TestCase {

    public function testParse() {

        assertTrue( BoolUtil.parse( "1" ) );
        assertTrue( BoolUtil.parse( "true" ) );
        assertTrue( BoolUtil.parse( "on" ) );
        assertTrue( BoolUtil.parse( "yes" ) );

        assertFalse( BoolUtil.parse( "no" ) );
        assertFalse( BoolUtil.parse( "0" ) );
        assertFalse( BoolUtil.parse( "false" ) );
        assertFalse( BoolUtil.parse( "off" ) );
    }
}
