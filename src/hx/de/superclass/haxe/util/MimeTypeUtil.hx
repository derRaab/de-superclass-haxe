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
	`MimeTypeUtil` provides simple helper methods to work with mime types.
**/
class MimeTypeUtil {

	private static var _extensionMimeMap : Map<String,String>;

	public static function fromFileExtension( extension : String ) : String {

		extension = extension.toLowerCase();

		var extensionMimeMap : Map<String,String> = _extensionMimeMap;
		if ( extensionMimeMap == null ) {

			_init();
			extensionMimeMap = _extensionMimeMap;
		}

		if ( extensionMimeMap.exists( extension ) ) {

			return extensionMimeMap.get( extension );
		}

		// return empty string to avoid bad behaviour
		return "";
	}

	private static function _init() : Void {

		// fully borrowed from HTML5 boilerplate plus some additional basics!

		var mimeExtensionsMap : Map<String,Array<String>> = new Map<String,Array<String>>();

		// Data interchange

		mimeExtensionsMap.set( "application/json", [ "json", "map", "topojson" ] );
		mimeExtensionsMap.set( "application/ld+json", ["jsonld" ] );
		mimeExtensionsMap.set( "application/vnd.geo+json", [ "geojson" ] );
		mimeExtensionsMap.set( "application/xml", ["atom", "rdf", "rss", "xml" ] );

		// JavaScript

		// Normalize to standard type.
		// https://tools.ietf.org/html/rfc4329//section-7.2

		mimeExtensionsMap.set( "application/javascript", [ "js" ] );

		// Manifest files

		// If you are providing a web application manifest file (see
		// the specification: https://w3c.github.io/manifest/), it is
		// recommended that you serve it with the `application/manifest+json`
		// media type.
		//
		// Because the web application manifest file doesn't have its
		// own unique file extension, you can set its media type either
		// by matching:
		//
		// 1) the exact location of the file (this can be done using a
		//    directive such as `<Location>`, but it will NOT work in
		//    the `.htaccess` file, so you will have to do it in the main
		//    server configuration file or inside of a `<VirtualHost>`
		//    container)
		//
		//    e.g.:
		//
		//       <Location "/.well-known/manifest.json">
		//           map.set( "application/manifest+json               json
		//       </Location>
		//
		// 2) the filename (this can be problematic as you will need to
		//    ensure that you don't have any other file with the same name
		//    as the one you gave to your web application manifest file)
		//
		//    e.g.:
		//
		//       <Files "manifest.json">
		//           map.set( "application/manifest+json               json
		//       </Files>

		mimeExtensionsMap.set( "application/x-web-app-manifest+json", [ "webapp" ] );
		mimeExtensionsMap.set( "text/cache-manifest", [ "appcache", "manifest" ] );

		// Media files

		mimeExtensionsMap.set( "audio/mp4", [ "f4a", "f4b", "m4a" ] );
		mimeExtensionsMap.set( "audio/ogg", [ "oga", "ogg", "opus" ] );
		mimeExtensionsMap.set( "image/bmp", [ "bmp" ] );
		mimeExtensionsMap.set( "image/webp", [ "webp" ] );
		mimeExtensionsMap.set( "video/mp4", [ "f4v", "f4p", "m4v", "mp4" ] );
		mimeExtensionsMap.set( "video/ogg", [ "ogv" ] );
		mimeExtensionsMap.set( "video/webm", [ "webm" ] );
		mimeExtensionsMap.set( "video/x-flv", [ "flv" ] );
		mimeExtensionsMap.set( "image/svg+xml", [ "svg", "svgz" ] );

		// Serving `.ico` image files with a different media type
		// prevents Internet Explorer from displaying then as images:
		// https://github.com/h5bp/html5-boilerplate/commit/37b5fec090d00f38de64b591bcddcb205aadf8ee

		mimeExtensionsMap.set( "image/x-icon", [ "cur", "ico" ] );

		// Web fonts

		mimeExtensionsMap.set( "application/font-woff", [ "woff" ] );
		mimeExtensionsMap.set( "application/font-woff2", [ "woff2" ] );
		mimeExtensionsMap.set( "application/vnd.ms-fontobject", [ "eot" ] );

		// Browsers usually ignore the font media types and simply sniff
		// the bytes to figure out the font type.
		// https://mimesniff.spec.whatwg.org///matching-a-font-type-pattern
		//
		// However, Blink and WebKit based browsers will show a warning
		// in the console if the following font types are served with any
		// other media types.

		mimeExtensionsMap.set( "application/x-font-ttf", [ "ttc", "ttf" ] );
		mimeExtensionsMap.set( "font/opentype", [ "otf" ] );

		// Other

		mimeExtensionsMap.set( "application/octet-stream", [ "safariextz" ] );
		mimeExtensionsMap.set( "application/x-bb-appworld", [ "bbaw" ] );
		mimeExtensionsMap.set( "application/x-chrome-extension", [ "crx" ] );
		mimeExtensionsMap.set( "application/x-opera-extension", [ "oex" ] );
		mimeExtensionsMap.set( "application/x-xpinstall", [ "xpi" ] );
		mimeExtensionsMap.set( "text/vcard", [ "vcard", "vcf" ] );
		mimeExtensionsMap.set( "text/vnd.rim.location.xloc", [ "xloc" ] );
		mimeExtensionsMap.set( "text/vtt", [ "vtt" ] );
		mimeExtensionsMap.set( "text/x-component", [ "htc" ] );


		// ADDITIONAL to boilerplate
		mimeExtensionsMap.set( "audio/mpeg", [ "mp3" ] );
		mimeExtensionsMap.set( "image/gif", [ "gif" ] );
		mimeExtensionsMap.set( "image/jpeg", [ "jpg", "jpeg", "jpe" ] );
		mimeExtensionsMap.set( "image/png", [ "png" ] );
		mimeExtensionsMap.set( "image/tiff", [ "tiff", "tif" ] );
		mimeExtensionsMap.set( "text/css", [ "css" ] );
		mimeExtensionsMap.set( "text/html", [ "html", "htm" ] );
		mimeExtensionsMap.set( "text/rtf", [ "rtf" ] );
		mimeExtensionsMap.set( "image/svg+xml", [ "svg" ] );
		mimeExtensionsMap.set( "text/plain", [ "txt", "properties", "csv" ] );
		mimeExtensionsMap.set( "application/zip", [ "zip" ] );

		mimeExtensionsMap.set( "application/pdf", [ "pdf" ] );

		// create extention mime map
		var extensionMimeMap : Map<String,String> = new Map<String,String>();

		for ( key in mimeExtensionsMap.keys() ) {

			var extensionArray : Array<String> = mimeExtensionsMap.get( key );
			for ( i in 0...extensionArray.length ) {

				var extension : String = extensionArray[ i ];
				extensionMimeMap.set( extension, key );
			}
		}

		_extensionMimeMap = extensionMimeMap;
	}
}
