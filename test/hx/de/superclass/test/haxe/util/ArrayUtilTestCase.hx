package de.superclass.test.haxe.util;

import de.superclass.haxe.util.ArrayUtil;
import haxe.unit.TestCase;

class ArrayUtilTestCase extends TestCase {

    public function testContains() {

        var floats : Array<Float> = [ 0.0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9 ];
        var strings : Array<Int> = [ "a", "b", "c", "d", "e", "f" ];
        var instances : Array<TestCase> = [ new TestCase(), new TestCase(), new TestCase() ];

        assertTrue( ArrayUtil.contains( floats, 0 ) );
        assertTrue( ArrayUtil.contains( floats, 9.9 ) );
        assertFalse( ArrayUtil.contains( floats, 10.10 ) );

        assertTrue( ArrayUtil.contains( strings, "a" ) );
        assertTrue( ArrayUtil.contains( strings, "f" ) );
        assertFalse( ArrayUtil.contains( strings, "g" ) );
        assertFalse( ArrayUtil.contains( strings, null ) );

        assertTrue( ArrayUtil.contains( instances, instances[ 0 ] ) );
        assertTrue( ArrayUtil.contains( instances, instances[ instances.length - 1 ] ) );
        assertFalse( ArrayUtil.contains( instances, new TestCase() ) );
        assertFalse( ArrayUtil.contains( instances, null ) );
    }
}
