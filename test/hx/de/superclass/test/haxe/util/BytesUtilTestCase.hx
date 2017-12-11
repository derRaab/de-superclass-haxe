package de.superclass.test.haxe.util;

import de.superclass.haxe.utest.TestCase;
import de.superclass.haxe.util.BytesUtil;
import haxe.io.Bytes;

class BytesUtilTestCase extends TestCase {

    public function testCopyTo() {

        var stringA : String = "AAA";
        var stringB : String = "BBB";
        var stringC : String = "CCC";
        var stringD : String = "         ";

        var stringABytes : Bytes = Bytes.ofString( stringA );
        var stringBBytes : Bytes = Bytes.ofString( stringB );
        var stringCBytes : Bytes = Bytes.ofString( stringC );
        var stringDBytes : Bytes = Bytes.ofString( stringD );

        BytesUtil.copyTo( stringCBytes, 0, stringCBytes.length, stringDBytes, 6 );
        assertEquals( "      CCC", stringDBytes.toString() );

        BytesUtil.copyTo( stringBBytes, 0, stringBBytes.length, stringDBytes, 3 );
        assertEquals( "   BBBCCC", stringDBytes.toString() );

        BytesUtil.copyTo( stringABytes, 0, stringABytes.length, stringDBytes, 0 );
        assertEquals( "AAABBBCCC", stringDBytes.toString() );
    }

    public function testIndexOfString() {

        var stringBytes : Bytes = Bytes.ofString( "My test string. My test string." );

        assertEquals( BytesUtil.indexOfString( stringBytes, "test" ), 3 );
        assertEquals( BytesUtil.indexOfString( stringBytes, "test", 4 ), 19 );
        assertEquals( BytesUtil.indexOfString( stringBytes, "not included" ), -1 );
    }
}
