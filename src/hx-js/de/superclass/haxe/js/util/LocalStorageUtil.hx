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

package de.superclass.haxe.js.util;

/**
	`LocalStorageUtil` provides simple helper methods to work with `Browser.window.localStorage`.
**/
import de.superclass.haxe.util.UrlUtil;
import js.Browser;
import js.html.Storage;

class LocalStorageUtil {

    private static var _context : String = createPageContext();
    private static var _localStorage : Storage = Browser.window.localStorage;

    /**
		Sets the local storage specific key prefix. If not set, the default value is `Browser.location.href` without vars and hash.
	**/
    public static function setContext( context : String ) : Void {

        _context = context;
    }

    /**
		Returns the local storage specific key prefix.
	**/
    public static function getContext() : String {

        return _context;
    }

    /**
		Creates an context `Browser.location.href` without vars and hash.
	**/
    public static function createPageContext() : String {

        return UrlUtil.removeVars(  UrlUtil.removeHash( Browser.location.href ) ).toLowerCase();
    }

    /**
		Creates an list with all existing context keys.
	**/
    public static function getContextKeys() : Array<String> {

        var contextKeys : Array<String> = [];
        var localStorage : Storage = _localStorage;

        var c : Int = localStorage.length;
        if ( 0 < c ) {

            var context : String = _context;
            var contextLength : Int = context.length;

            for ( i in 0...c ) {

                var key : String = localStorage.key( i );
                if ( contextLength < key.length ) {

                    if ( key.indexOf( context ) == 0 ) {

                        contextKeys[ contextKeys.length ] = key.substr( contextLength );
                    }
                }
            }
        }

        return contextKeys;
    }

    /**
		Will return that key's value.
	**/
    public static function getContextItem( key : String ) : String {

        return _localStorage.getItem( _context + key );
    }

    /**
		Will add that key to the storage, or update that key's value if it already exists.
	**/
    public static function setContextItem( key : String, value : String ) : Void {

        return _localStorage.setItem( _context + key, value );
    }

    /**
		Will remove that key from the storage.
	**/
    public static function removeContextItem( key : String, value : String ) : Void {

        return _localStorage.removeItem( _context + key );
    }

    /**
		Will empty all keys out of the storage.
	**/
    public static function clearContext() : Void {

        var contextKeys : Array<String> = getContextKeys();
        var c : Int = contextKeys.length;
        if ( 0 < c ) {

            var context : String = _context;
            var localStorage : Storage = _localStorage;

            for ( i in 0...c ) {

                localStorage.removeItem( context + contextKeys[ i ] );
            }
        }
    }

    /**
		Will trace all key value pairs.
	**/
    public static function traceContext() : Void {

        var contextKeys : Array<String> = getContextKeys();
        var c : Int = contextKeys.length;

        trace( c + " key value pair(s) for local storage context '" + _context + "'" );
        if ( 0 < c ) {

            var context : String = _context;
            var localStorage : Storage = _localStorage;

            for ( i in 0...c ) {

                var key : String = contextKeys[ i ];
                trace( "'" + key + "' ---> '" + localStorage.getItem( context + key ) + "'" );
            }
        }
    }
}