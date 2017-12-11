package de.superclass.haxe.utest;

import haxe.PosInfos;
import utest.Assert;

class TestCase {

    public function new() {
    }

    inline function assertTrue( b:Bool, ?c : PosInfos ) : Void {

        Assert.isTrue( b, null, c );
    }

    inline function assertFalse( b:Bool, ?c : PosInfos ) : Void {

        Assert.isFalse( b, null, c );
    }

    inline function assertEquals<T>( expected: T , actual: T,  ?c : PosInfos ) : Void {

        Assert.equals( expected, actual, null, c );
    }
}
