package de.superclass.test.haxe.util;

import de.superclass.haxe.util.IntUtil;
import de.superclass.haxe.utest.TestCase;

class IntUtilTestCase extends TestCase {

    public function testPrimeFactors() {

        assertEquals( "" + IntUtil.primeFactors( 2 ), "" + [ 2 ] );
        assertEquals( "" + IntUtil.primeFactors( 3 ), "" + [ 3 ] );
        assertEquals( "" + IntUtil.primeFactors( 4 ), "" + [ 2, 2 ] );
        assertEquals( "" + IntUtil.primeFactors( 6 ), "" + [ 2, 3 ] );
        assertEquals( "" + IntUtil.primeFactors( 8 ), "" + [ 2, 2, 2 ] );
        assertEquals( "" + IntUtil.primeFactors( 9 ), "" + [ 3, 3 ] );
        assertEquals( "" + IntUtil.primeFactors( 27 ), "" + [ 3, 3, 3 ] );
        assertEquals( "" + IntUtil.primeFactors( 625 ), "" + [ 5, 5, 5, 5 ] );
        assertEquals( "" + IntUtil.primeFactors( 901255 ), "" + [ 5, 17, 23, 461 ] );
    }
}
