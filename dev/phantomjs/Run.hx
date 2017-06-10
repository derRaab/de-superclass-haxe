import Sys.*;
import sys.FileSystem.*;
import sys.io.File.*;
import haxe.*;
import haxe.io.*;
using StringTools;

/**
    Test a JS file in PhantomJS.
*/
class Run {
	static var phantomjsRunner(default, never) = "dev/phantomjs/phantomjs.js";
	static var phantomjsHtml(default, never) = "dev/phantomjs/phantomjs.html";
	static function main() {
		var args = args();
		trace( args );
		var jsFile = fullPath(args[0]);
		trace( jsFile );
		var tmpl = new Template(getContent(phantomjsHtml));
		trace( tmpl );
		var html = tmpl.execute({
			jsFile: Path.withoutDirectory(jsFile)
		});
		trace( html );
		trace( Path.directory(jsFile) );
		trace(Path.join([Path.directory(jsFile), "phantomjs.html"]) );
		saveContent(Path.join([Path.directory(jsFile), "phantomjs.html"]), html);

		var exitCode = command("phantomjs", [phantomjsRunner]);
		exit(exitCode);
	}
}