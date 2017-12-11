package de.superclass.test.haxe.util;

import de.superclass.haxe.utest.TestCase;
import de.superclass.haxe.util.ArrayUtil;

class ArrayUtilTestCase extends TestCase {

    public function testContains() {

        var floats : Array<Float> = [ 0.0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9 ];
        var strings : Array<String> = [ "a", "b", "c", "d", "e", "f" ];
        var instances : Array<TestClass> = [ new TestClass(), new TestClass(), new TestClass() ];

        assertTrue( ArrayUtil.contains( floats, 0.0 ) );
        assertTrue( ArrayUtil.contains( floats, 9.9 ) );
        assertFalse( ArrayUtil.contains( floats, 10.10 ) );

        assertTrue( ArrayUtil.contains( strings, "a" ) );
        assertTrue( ArrayUtil.contains( strings, "f" ) );
        assertFalse( ArrayUtil.contains( strings, "g" ) );
        assertFalse( ArrayUtil.contains( strings, null ) );

        assertTrue( ArrayUtil.contains( instances, instances[ 0 ] ) );
        assertTrue( ArrayUtil.contains( instances, instances[ instances.length - 1 ] ) );
        assertFalse( ArrayUtil.contains( instances, new TestClass() ) );
        assertFalse( ArrayUtil.contains( instances, null ) );
    }

    public function testDetectFirstUsedValue() {

        var floats : Array<Float> = [ 0.0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9 ];
        var strings : Array<String> = [ "a", "b", "c", "d", "e", "f" ];
        var instances : Array<TestClass> = [ new TestClass(), new TestClass(), new TestClass() ];

        assertEquals( ArrayUtil.detectFirstUsedValue( floats, [ 9.9, 0.0 ] ), 9.9 );
        assertEquals( ArrayUtil.detectFirstUsedValue( floats, [ 3.3, 4.4 ] ), 3.3 );
        assertEquals( ArrayUtil.detectFirstUsedValue( floats, [ 11.11, 8.8 ] ), 8.8 );
        assertEquals( ArrayUtil.detectFirstUsedValue( floats, [ 10.10 ], 0.0 ), 0.0 );
        assertEquals( ArrayUtil.detectFirstUsedValue( floats, [ 10.10 ], 0.0 ), 0.0 );

        assertEquals( ArrayUtil.detectFirstUsedValue( strings, [ "f", "a" ] ), "f" );
        assertEquals( ArrayUtil.detectFirstUsedValue( strings, [ "b", "d" ] ), "b" );
        assertEquals( ArrayUtil.detectFirstUsedValue( strings, [ "g", "d" ] ), "d" );
        assertEquals( ArrayUtil.detectFirstUsedValue( strings, [ "g", "H" ] ), null );

        assertEquals( ArrayUtil.detectFirstUsedValue( instances, [ instances[ 0 ], instances[ 1 ] ] ), instances[ 0 ] );
        assertEquals( ArrayUtil.detectFirstUsedValue( instances, [ instances[ 2 ], instances[ 1 ] ] ), instances[ 2 ] );
        assertEquals( ArrayUtil.detectFirstUsedValue( instances, [ null, instances[ 1 ] ] ), instances[ 1 ] );
        assertEquals( ArrayUtil.detectFirstUsedValue( instances, [ instances[ 1 ], null ] ), instances[ 1 ] );
        assertEquals( ArrayUtil.detectFirstUsedValue( instances, [ instances[ 1 ] ] ), instances[ 1 ] );
        assertEquals( ArrayUtil.detectFirstUsedValue( instances, [ new TestClass() ] ), null );
    }

    public function testFill() {

        var floats : Array<Float> = [ 0.0 ];
        var strings : Array<String> = [ "a" ];

        assertEquals( ArrayUtil.fill( floats, 0, 0.0 ).length, 1 );
        assertEquals( ArrayUtil.fill( floats, 1, 0.0 ).length, 1 );
        assertEquals( ArrayUtil.fill( floats, 10, 0.0 ).length, 10 );

        assertEquals( ArrayUtil.fill( strings, 0, "a" ).length, 1 );
        assertEquals( ArrayUtil.fill( strings, 1, "a" ).length, 1 );
        assertEquals( ArrayUtil.fill( strings, 10, "a" ).length, 10 );
    }

    public function testGetValueFollowing() {

        var floats : Array<Float> = [ 0.0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9 ];
        var strings : Array<String> = [ "a", "b", "c", "d", "e", "f" ];
        var instances : Array<TestClass> = [ new TestClass(), new TestClass(), new TestClass() ];

        assertEquals( ArrayUtil.getValueFollowing( floats, 0.0 ), 1.1 );
        assertEquals( ArrayUtil.getValueFollowing( floats, 2.2 ), 3.3 );
        assertEquals( ArrayUtil.getValueFollowing( floats, 10.10 ), null );

        assertEquals( ArrayUtil.getValueFollowing( strings, "a" ), "b" );
        assertEquals( ArrayUtil.getValueFollowing( strings, "b" ), "c" );
        assertEquals( ArrayUtil.getValueFollowing( strings, "g" ), null );
        assertEquals( ArrayUtil.getValueFollowing( strings, null ), null );

        assertEquals( ArrayUtil.getValueFollowing( instances, instances[ 0 ] ), instances[ 1 ] );
        assertEquals( ArrayUtil.getValueFollowing( instances, instances[ 1 ] ), instances[ 2 ] );
        assertEquals( ArrayUtil.getValueFollowing( instances, instances[ 2 ] ), null );
        assertEquals( ArrayUtil.getValueFollowing( instances, null ), null );
    }

    public function testHasLength() {

        var floats : Array<Float> = [ 0.0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9 ];
        var strings : Array<String> = [ "a", "b", "c", "d", "e", "f" ];
        var instances : Array<TestClass> = [ new TestClass(), new TestClass(), new TestClass() ];

        assertTrue( ArrayUtil.hasLength( floats  ) );
        assertTrue( ArrayUtil.hasLength( strings  ) );
        assertTrue( ArrayUtil.hasLength( instances  ) );

        floats = [];
        strings = [];
        instances = [];

        assertFalse( ArrayUtil.hasLength( floats  ) );
        assertFalse( ArrayUtil.hasLength( strings  ) );
        assertFalse( ArrayUtil.hasLength( instances  ) );

        floats = null;
        strings = null;
        instances = null;

        assertFalse( ArrayUtil.hasLength( floats  ) );
        assertFalse( ArrayUtil.hasLength( strings  ) );
        assertFalse( ArrayUtil.hasLength( instances  ) );
        assertFalse( ArrayUtil.hasLength( instances  ) );
    }
}
