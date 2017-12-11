package;

import de.superclass.haxe.util.HaxeTargetUtil;
import utest.Runner;
import utest.ui.Report;

class TestMainHx {

    static function main() {

        trace( "\n\n|\n|\n|\n| TestMainHx.main() on target '" + HaxeTargetUtil.getTarget() + "'\n|\n|\n|\n" );

        var r = new Runner();

        r = de.superclass.test.haxe.TestCases.addAll( r );
        Report.create( r );

        r.run();

        #if flash
        flash.system.System.exit(0);
        #end
    }
}
