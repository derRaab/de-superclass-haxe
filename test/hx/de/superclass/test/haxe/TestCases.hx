package de.superclass.test.haxe;

import de.superclass.test.haxe.util.AsciiUtilTestCase;
import de.superclass.test.haxe.util.ArrayUtilTestCase;
import haxe.unit.TestRunner;

class TestCases {
    
    public static function addAll( r : TestRunner ) : TestRunner {
        
        r.add( new ArrayUtilTestCase() );
        r.add( new AsciiUtilTestCase() );

        return r;
    }
}
