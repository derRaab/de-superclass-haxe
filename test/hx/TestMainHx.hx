package;

class TestMainHx {

    static function main() {

        trace( "TestMainHx.main()" );

        var r = new haxe.unit.TestRunner();

        r = de.superclass.test.haxe.TestCases.addAll( r );

        r.run();

        #if flash
        flash.system.System.exit(0);
        #end
    }
}
