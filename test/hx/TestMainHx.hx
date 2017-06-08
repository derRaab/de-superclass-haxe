package;

class TestMainHx {

    static function main() {

        var r = new haxe.unit.TestRunner();

        r = de.superclass.test.haxe.TestCases.addAll( r );

        r.run();
    }
}
