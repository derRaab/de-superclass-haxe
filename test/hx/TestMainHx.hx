package;

import de.superclass.haxe.util.HaxeTargetUtil;

class TestMainHx {

    static function main() {

        trace( "\n\n|\n|\n|\n| TestMainHx.main() on target '" + HaxeTargetUtil.getTarget() + "'\n|\n|\n|\n" );

        var r = new haxe.unit.TestRunner();

        r = de.superclass.test.haxe.TestCases.addAll( r );

        r.run();

        #if flash
        flash.system.System.exit(0);
        #end
    }
}
