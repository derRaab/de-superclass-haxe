package de.superclass.test.haxe;

import de.superclass.test.haxe.format.W3cPeriodTestCase;
import de.superclass.test.haxe.util.ArrayUtilTestCase;
import de.superclass.test.haxe.util.AsciiUtilTestCase;
import de.superclass.test.haxe.util.BoolUtilTestCase;
import de.superclass.test.haxe.util.BytesUtilTestCase;
import de.superclass.test.haxe.util.ColorUtilTestCase;
import de.superclass.test.haxe.util.DateUtilTestCase;
import de.superclass.test.haxe.util.IntUtilTestCase;
import de.superclass.test.haxe.util.StringUtilTestCase;
import de.superclass.test.haxe.util.TimeUtilTestCase;
import utest.Runner;

class TestCases {
    
    public static function addAll( r : Runner ) : Runner {

        // format
        r.addCase( new W3cPeriodTestCase() );

        // util
        r.addCase( new ArrayUtilTestCase() );
        r.addCase( new AsciiUtilTestCase() );
        r.addCase( new BoolUtilTestCase() );
        r.addCase( new BytesUtilTestCase() );
        r.addCase( new ColorUtilTestCase() );
        r.addCase( new DateUtilTestCase() );
        r.addCase( new IntUtilTestCase() );
        r.addCase( new StringUtilTestCase() );
        r.addCase( new TimeUtilTestCase() );

        return r;
    }
}
