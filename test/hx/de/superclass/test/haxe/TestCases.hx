package de.superclass.test.haxe;

import de.superclass.test.haxe.util.ArrayUtilTestCase;
import de.superclass.test.haxe.util.AsciiUtilTestCase;
import de.superclass.test.haxe.util.BoolUtilTestCase;
import de.superclass.test.haxe.util.BytesUtilTestCase;
import de.superclass.test.haxe.util.ColorUtilTestCase;
import de.superclass.test.haxe.util.DateUtilTestCase;
import de.superclass.test.haxe.util.IntUtilTestCase;
import de.superclass.test.haxe.util.StringUtilTestCase;
import utest.Runner;

class TestCases {
    
    public static function addAll( r : Runner ) : Runner {
        
        r.addCase( new ArrayUtilTestCase() );
        r.addCase( new AsciiUtilTestCase() );
        r.addCase( new BoolUtilTestCase() );
        r.addCase( new BytesUtilTestCase() );
        r.addCase( new ColorUtilTestCase() );
        r.addCase( new DateUtilTestCase() );
        r.addCase( new IntUtilTestCase() );
        r.addCase( new StringUtilTestCase() );

        return r;
    }
}
