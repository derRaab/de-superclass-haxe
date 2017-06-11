package de.superclass.test.haxe.util;

import de.superclass.haxe.util.FloatUtil;
import de.superclass.haxe.util.ColorUtil;
import haxe.unit.TestCase;

class ColorUtilTestCase extends TestCase {

    public function testFromHexString() {

        assertEquals( 0, ColorUtil.fromHexString( "#000000" ) );
        assertEquals( 0, ColorUtil.fromHexString( "0x000000" ) );
        assertEquals( 16777215, ColorUtil.fromHexString( "#FFFFFF" ) );
        assertEquals( 16777215, ColorUtil.fromHexString( "#FfFfFf" ) );
        assertEquals( 16777215, ColorUtil.fromHexString( "0xFfFfFf" ) );
    }

    public function testHexToRgbArray() {

        assertEquals( [ 0, 0, 0].toString(), ColorUtil.hexToRgbArray( "#000000" ).toString() );
        var ints : Array<Int> = [];
        assertEquals( ints, ColorUtil.hexToRgbArray( "#000000", ints ) );
        assertEquals( 0, ints[ 0 ] );
        assertEquals( 0, ints[ 1 ] );
        assertEquals( 0, ints[ 2 ] );

        assertEquals( [ 255, 255, 255].toString(), ColorUtil.hexToRgbArray( "#FfFfFf" ).toString() );
        assertEquals( ints, ColorUtil.hexToRgbArray( "#FfFfFf", ints ) );
        assertEquals( 255, ints[ 0 ] );
        assertEquals( 255, ints[ 1 ] );
        assertEquals( 255, ints[ 2 ] );
    }

    public function testInterpolate() {

        assertEquals( 0x000000, ColorUtil.interpolate( 0x000000, 0x222222, 0 ) );
        assertEquals( 0x111111, ColorUtil.interpolate( 0x000000, 0x222222, 0.5 ) );
        assertEquals( 0x222222, ColorUtil.interpolate( 0x000000, 0x222222, 1 ) );
        assertEquals( 0x444444, ColorUtil.interpolate( 0x000000, 0x222222, 2 ) );
    }

    public function testLuminanaceFromHex() {

        assertEquals( 0.0, ColorUtil.luminanaceFromHex( "#000000" ) );
        // Round to same digits on all platforms
        assertEquals( 0.246201327, FloatUtil.fixed( ColorUtil.luminanaceFromHex( "#888888" ), 9 ) );
        assertEquals( 1.0, ColorUtil.luminanaceFromHex( "#FFFFFF" ) );
    }

    public function testLuminanaceFromRgb() {

        var rgb : Array<Int> = ColorUtil.hexToRgbArray( "#888888" );
        assertEquals( 0.246201327, FloatUtil.fixed( ColorUtil.luminanaceFromRgb( rgb[ 0 ], rgb[ 1 ], rgb[ 2 ] ), 9 ) );
    }
}
