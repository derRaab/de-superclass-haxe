import Sys.*;
import sys.io.File.*;
import haxe.*;
import haxe.io.*;

class Install {
	// https://www.adobe.com/support/flashplayer/downloads.html
	static var fpDownload(default, never) = switch (systemName()) {
		case "Linux":
			"http://fpdownload.macromedia.com/pub/flashplayer/updaters/25/flash_player_sa_linux_debug.x86_64.tar.gz";
		case "Mac":
			"http://fpdownload.macromedia.com/pub/flashplayer/updaters/25/flashplayer_25_sa_debug.dmg";
		case "Windows":
			"http://fpdownload.macromedia.com/pub/flashplayer/updaters/25/flashplayer_25_sa_debug.exe";
		case _:
			throw "unsupported system";
	}
	// https://helpx.adobe.com/flash-player/kb/configure-debugger-version-flash-player.html
	static var mmcfg(default, never) = switch (systemName()) {
		case "Linux":
			Path.join([getEnv("HOME"), "mm.cfg"]);
		case "Mac":
			"/Library/Application Support/Macromedia/mm.cfg";
		case "Windows":
			Path.join([getEnv("HOMEDRIVE") + getEnv("HOMEPATH"), "mm.cfg"]);
		case _:
			throw "unsupported system";
	}
	// http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7c95.html
	static var fpTrust(default, never) = switch (systemName()) {
		case "Linux":
			Path.join([getEnv("HOME"), ".macromedia/Flash_Player/#Security/FlashPlayerTrust"]);
		case "Mac":
			"/Library/Application Support/Macromedia/FlashPlayerTrust";
		case "Windows":
			Path.join([getEnv("SYSTEMROOT"), "system32", "Macromed", "Flash", "FlashPlayerTrust"]);
		case _:
			throw "unsupported system";
	}
	static function main() {

		trace( "main()" );
		trace( "fpDownload", fpDownload );
		trace( "mmcfg", mmcfg );
		trace( "fpTrust", fpTrust );
		trace( "systemName()", systemName() );


		switch (systemName()) {

			case "Linux":

					trace( "case Linux" );

				// Download and unzip flash player
				if (command("wget", [fpDownload]) != 0)
					throw "failed to download flash player";

					trace( "case Linux 2" );

				if (command("tar", ["-xf", Path.withoutDirectory(fpDownload), "-C", "flash"]) != 0)
					throw "failed to extract flash player";

					trace( "case Linux 3" );
			case "Mac":

				trace( "case Mac" );
				// https://github.com/caskroom/homebrew-cask/pull/15381
				if (command("brew", ["uninstall", "--force", "brew-cask"]) != 0)
					throw "failed to brew uninstall --force brew-cask";
				if (command("brew", ["tap", "caskroom/versions"]) != 0)
					throw "failed to brew tap caskroom/versions";
				if (command("brew", ["cask", "install", "flash-player-debugger"]) != 0)
					throw "failed to install flash-player-debugger";
			case "Windows":

				trace( "case Windows" );
				// Download flash player
				download(fpDownload, "flash\\flashplayer.exe");
			case _:
				throw "unsupported system";
		}

		trace( "createDirectory()" );
		trace( "Path.directory(mmcfg)", Path.directory(mmcfg) );

		// Create a configuration file so the trace log is enabled
		createDirectory(Path.directory(mmcfg));
		trace( "saveContent()" );
		saveContent(mmcfg, "ErrorReportingEnable=1\nTraceOutputFileEnable=1");

	trace( "createDirectory(fpTrust)" );
		// Add the current directory as trusted, so exit() can be used
		createDirectory(fpTrust);
	trace( "saveContent(Path.join([fpTrust, "test.cfg"]), getCwd()" );
	trace( 'Path.join([fpTrust, "test.cfg"])', Path.join([fpTrust, "test.cfg"]) );
	trace( 'getCwd()', getCwd() );
		saveContent(Path.join([fpTrust, "test.cfg"]), getCwd());
	}
	static function download(url:String, saveAs:String):Void {
		var http = new Http(url);
		http.onError = function(e) {
			throw e;
		};
		http.customRequest(false, write(saveAs));
	}
	static function createDirectory(dir:String):Void {
		try {
			sys.FileSystem.createDirectory(dir);
		} catch(e:Dynamic) {
			switch (systemName()) {
				case "Mac", "Linux":
					if (command("sudo", ["mkdir", "-p", dir]) != 0)
						throw 'cannot create $dir';
					if (command("sudo", ["chmod", "a+rw", dir]) != 0)
						throw 'cannot set permission of $dir';
				case _:
					neko.Lib.rethrow(e);
			}
		}
	}
}