package de.superclass.test.haxe;

import de.superclass.test.haxe.util.ArrayUtilTestCase;
import haxe.unit.TestRunner;

class TestCases {
    
    public static function addAll( r : TestRunner ) : TestRunner {
        
        r.add( new ArrayUtilTestCase() );
        
        return r;
    }
}
