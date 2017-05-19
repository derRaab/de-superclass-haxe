/*
 * Copyright (C)2017 Markus Raab (derRaab) | blog.derraab.com | superclass.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package de.superclass.haxe.util;

/**
	`UrlUtil` provides simple helper methods for url manipulations.
	IMPORTANT: directory urls need to end with /
**/
class UrlUtil {

	public static var EREG_VALID : EReg = ~/^[a-zA-Z0-9-:_\.~\/@]+$/m;

	public static function getVars( url : String ) : Map<String,String> {

		var index : Int = url.indexOf( "?" );
		if ( index != -1 ) {

			url = url.substr( index + 1 );

			index = url.indexOf( "#" );
			if ( index != -1 ) {

				url = url.substr( 0, index );
			}

			if ( 0 < url.length ) {

				var map : Map<String,String> = new Map<String,String>();

				var foundKeyValue : Bool = false;

				var keyValues : Array<String> = url.split( "&" );
				for ( i in 0...keyValues.length ) {

					var keyValue : String = keyValues[ i ];

					index = keyValue.indexOf( "=" );
					if ( 0 < index ) {

						map.set( keyValue.substr( 0, index ), keyValue.substr( index + 1 ) );
						foundKeyValue = true;
					}
				}

				if ( foundKeyValue ) return map;
			}
		}

		return null;
	}

	public static function removeHash( url : String ) : String {

		var index : Int = url.indexOf( "#" );
		if ( index != -1 ) {

			url = url.substr( 0, index );
		}
		return url;
	}

	public static function removeVars( url : String ) : String {

		var index : Int = url.indexOf( "?" );
		if ( index != -1 ) {

			url = url.substr( 0, index );
		}
		return url;
	}

	public static function getDirectory( url : String ) : String {

		if ( isDirectory( url ) ) return url;

		var lastIndex : Int = url.lastIndexOf( "/" );
		if ( lastIndex != -1 ) {

			return url.substr( 0, lastIndex + 1 );
		}
		return "";
	}

	/* Changes %20 to space and %40 to @ */
	public static function ensureUnescaped( url : String ) : String {

		if( 2 < url.length ) {

			// unescape space
			if ( url.indexOf( "%20" ) != -1 ) {

				url = url.split( "%20" ).join( " " );
			}

			// unescape @
			if ( url.indexOf( "%40" ) != -1 ) {

				url = url.split( "%40" ).join( "@" );
			}
		}

		return url;
	}

	public static function ensureDirectoryUrl( url : String ) : String {

		if ( url.charAt( url.length - 1 ) != "/" ) {

			return url + "/";
		}
		return url;
	}

	public static function getDirectoryName( url : String ) : String {

		if ( isDirectory( url ) ) {

			// remove last /
			url = url.substring( 0, url.length - 1 );

			var lastIndex : Int = url.lastIndexOf( "/" );
			if ( lastIndex != -1 ) {

				url = url.substr( lastIndex + 1 );
			}
			return url;
		}

		return null;
	}

	public static function getName( url : String, ?withoutExtension : Bool = false, ?withoutAttribute : Bool = false ) : String {

		if ( isDirectory( url ) ) {

			return null;
		}

		var directory : String = getDirectory( url );
		var name : String = url.substr( directory.length );

		if ( withoutAttribute ) {

			var attribute : String = getAttribute( name );
			if ( attribute != null ) {

				name = setAttribute( name, null );
			}
		}

		if ( withoutExtension ) {

			var extension : String = getExtension( name );
			if ( extension != null ) {

				name = name.substring( 0, name.length - extension.length - 1 );
			}
		}

		return name;
	}

	/** Returns the file extension if available / **/
	public static function getExtension( url : String ) : String {

		if ( url.indexOf( "." ) != -1 ) {

			var extension : String = url.split( "." ).pop();
			if ( extension.indexOf( "/" ) == -1 ) {

				return extension;
			}
		}
		return null;
	}

	/** Returns true if the url ends with / **/
	public static function isDirectory( url : String ) : Bool {

		return ( url.charAt( url.length - 1 ) == "/" );
	}

	/** Returns true if the url ends with / **/
	public static function isHidden( url : String ) : Bool {

		return ( url.charAt( 0 ) == "." );
	}

	public static function isLocal( url : String ) : Bool {

		url = url.toLowerCase();

		if ( url.indexOf( "file:" ) == 0 ) return true;
		if ( url.indexOf( "app:" ) == 0 ) return true;
		if ( url.indexOf( "app-storage:" ) == 0 ) return true;
		if ( url.indexOf( "res:" ) == 0 ) return true;
		if ( url.indexOf( "widget:" ) == 0 ) return true;

		return false;
		//(?:about|app|app-storage|.+-extension|file|res|widget):$/;

		//return EREG_LOCAL.match( url );
	}

	public static function isValid( url : String ) : Bool {

		return EREG_VALID.match( url );
	}

	public static function optimize( url : String ) : String {

		if ( url.indexOf( "/" ) != -1 ) {

			var urlArray : Array<String> = url.split( "/" );

			// check for . (same directory) and remove them all
			var index : Int = urlArray.indexOf( "." );
			while ( index != -1 ) {

				urlArray.splice( index, 1 );
				index = urlArray.indexOf( "." );
			}

			// check for .. (parent directory) and resolve them all (if possible)
			index = urlArray.indexOf( ".." );
			if ( index != -1 ) {

				urlArray.reverse();
				// reverse index
				index = urlArray.length - 1 - index;
				while ( index != -1 ) {

					var foundDirectoryPart : Bool = false;

					// find next directory part
					var index2 : Int = index + 1;
					while ( index2 < urlArray.length ) {

						if ( urlArray[ index2 ] != ".." ) {

							// remove .. and relative directory name
							urlArray.splice( index2, 1 );
							urlArray.splice( index, 1 );

							foundDirectoryPart = true;
							break;
						}

						index2++;
					}

					if ( ! foundDirectoryPart ) {

						break;
					}

					index = urlArray.indexOf( ".." );
				}

				urlArray.reverse();
			}

			url = urlArray.join( "/" );
		}

		return url;
	}

	public static function resolvePath( url : String, pathUrl : String ) : String {

		return optimize( getDirectory( url ) + pathUrl );
	}

	/**
		 Sets the attribute value for and url.

		 Examples:
		 setAttribute( "directory/file.png", null ) -> "directory/file.png"
		 setAttribute( "directory/file.png", "" ) -> "directory/file@.png"
		 setAttribute( "directory/file.png", "2x" ) -> "directory/file@2x.png"
		 setAttribute( "directory/", null ) -> "directory/"
		 setAttribute( "directory/", "" ) -> "directory@/"
		 setAttribute( "directory/", "2x" ) -> "directory@2x/"
	 **/
	public static function setAttribute( url : String, attribute : String ) : String {

		var isDirectory : Bool = ( url.charAt( url.length - 1 ) == "/" );
		if ( isDirectory ) {

			// remove last slash
			url = url.substr( 0, url.length - 1 );
		}

		var prefix : String = "";
		var suffix : String = "";

		// remove any folders and use them as prefix
		var index : Int = url.lastIndexOf( "/" );
		if ( index != -1 ) {

			prefix = url.substr( 0, index + 1 );
			url = url.substr( index + 1 );
		}

		// just use last part before extension
		index = url.lastIndexOf( "." );
		if ( index != -1 ) {

			// remove extension and use it as suffix
			suffix =  url.substr( index );
			url = url.substr( 0, index );

			// remove any dot separated part before and add this also to prefix
			index = url.lastIndexOf( "." );
			if ( index != -1 ) {

				prefix = prefix + url.substr( 0, index + 1 );
				url = url.substr( index + 1 );
			}
		}

		// find attribute prefix
		index = url.lastIndexOf( "@" );
		if ( index != -1 ) {

			// add this also to prefix
			prefix = prefix + url.substr( 0, index );
		}
		else {

			// add complete url to prefix
			prefix = prefix + url;
		}

		attribute = ( attribute == null ) ? "" : "@" + attribute;

		url = prefix + attribute + suffix;

		if ( isDirectory ) {

			url += "/";
		}

		return url;
	}

	/**
		 Returns the attribute value within an url or null if no attribute is set.

		 Examples:
		 directory/file.png		-> null
		 directory/file@.png	-> ""
		 directory/file@2x.png	-> "2x"
		 directory/				-> null
		 directory@/			-> ""
		 directory@2x/			-> "2x"
	 **/
	public static function getAttribute( url : String ) : String {

		var isDirectory : Bool = ( url.charAt( url.length - 1 ) == "/" );
		if ( isDirectory ) {

			// remove last slash
			url = url.substr( 0, url.length - 1 );
		}

		// remove any folders
		var index : Int = url.lastIndexOf( "/" );

		if ( index != -1 ) {

			url = url.substr( index + 1 );
		}

		// just use last part before extension
		index = url.lastIndexOf( "." );
		if ( index != -1 ) {

			// remove extension
			url = url.substr( 0, index );

			// remove any dot separated part before
			index = url.lastIndexOf( "." );
			if ( index != -1 ) {

				url = url.substr( index + 1 );
			}
		}

		// find attribute prefix
		index = url.lastIndexOf( "@" );
		if ( index != -1 ) {

			return url.substr( index + 1 );
		}

		return null;
	}


	public static function getScaleDepreciated( url : String, ?fallback : Float = 0 ) : Float {

		trace( "UrlUtil.getScaleDepreciated() - AVOID THIS!" );
		var attribute : String = getAttribute( url );
		if ( StringUtil.hasLength( attribute ) ) {

			var scale : Float = Std.parseFloat( attribute );
				scale = FloatUtil.isNaNFallback( scale, fallback );
			return scale;
		}

		return fallback;
	}

	/** Converts an file protocol url to windows native path. Example: file:///Z:/path/to/file.ext -> Z:\path\to\file.ext **/
	public static function toWindowsNativePath( fileProtocolUrl : String ) : String {

		// use full path, no file protocol and backslashes
		var fileProtocolPrefix : String = "file:///";
		if ( fileProtocolUrl.indexOf( fileProtocolPrefix ) == 0 ) {

			fileProtocolUrl = fileProtocolUrl.substr( fileProtocolPrefix.length );

			var forwardSlash : String = "/";
			var backwardSlash : String = "\\";

			if ( fileProtocolUrl.indexOf( forwardSlash ) != -1 ) {

				fileProtocolUrl = fileProtocolUrl.split( forwardSlash ).join( backwardSlash );
			}
		}

		return fileProtocolUrl;
	}

	/** Creats a mailto: protocol url based on the the given parameters. See https://en.wikipedia.org/wiki/Mailto **/
	public static function createMailto( toAddresses : Array<String>, subject : String, body : String, ?ccAddresses : Array<String> = null, ?bccAddresses : Array<String> = null, ?addressSeparator : String = "," ) : String
	{
		var separator : String = "?";

		var url : String = "mailto:";
			url += toAddresses.join( addressSeparator );

		if ( ArrayUtil.hasLength( ccAddresses ) ) {

			url += separator;
			separator = "&";

			url += "cc=" + ccAddresses.join( addressSeparator );
		}

		if ( ArrayUtil.hasLength( bccAddresses ) ) {

			url += separator;
			separator = "&";

			url += "bcc=" + bccAddresses.join( addressSeparator );
		}

		if ( StringUtil.hasLength( subject ) ) {

			url += separator;
			separator = "&";

			url += "subject=" + subject;
		}

		if ( StringUtil.hasLength( body ) ) {

			url += separator;
			separator = "&";

			url += "body=" + body;
		}

		return url;
	}
}
