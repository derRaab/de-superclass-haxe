package de.superclass.test.haxe;

import de.superclass.test.haxe.util.ArrayUtilTestCase;
import de.superclass.test.haxe.util.AsciiUtilTestCase;
import de.superclass.test.haxe.util.BoolUtilTestCase;
import de.superclass.test.haxe.util.BytesUtilTestCase;
import de.superclass.test.haxe.util.ColorUtilTestCase;
import de.superclass.test.haxe.util.DateUtilTestCase;
import haxe.unit.TestRunner;

class TestCases {
    
    public static function addAll( r : TestRunner ) : TestRunner {
        
        r.add( new ArrayUtilTestCase() );
        r.add( new AsciiUtilTestCase() );
        r.add( new BoolUtilTestCase() );
        r.add( new BytesUtilTestCase() );
        r.add( new ColorUtilTestCase() );
        r.add( new DateUtilTestCase() );

        return r;
    }
}
