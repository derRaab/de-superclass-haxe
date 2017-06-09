package de.superclass.test.haxe;

/**
	`TestClass` is just a class without any functionality but used within the tests when it comes to instance handling.
**/
class TestClass {

    private static var _instanceCount : Int = 0;
    private var _instance : Int;

    public function new() {

        _instance = _instanceCount++;
    }

    public function toString() : String {

        return "[TestClass-"+ _instance +"]";
    }
}