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

package de.superclass.haxe.js.html;

import de.superclass.haxe.util.ArrayUtil;
import js.html.Storage;

/**
	`StorageContext` represents an storage context within an storage (represented by an unique prefix).
**/
class StorageContext {

    private static var _prefix : String;
    private static var _storage : Storage;

    public function new( storage : Storage, prefix : String ) {

        _storage = storage;
        _prefix = prefix;
    }

    /**
		Returns the storage specific key prefix.
	**/
    public function getPrefix() : String {

        return _prefix;
    }

    /**
		Creates an list with all existing context keys.
	**/
    public function getKeys() : Array<String> {

        var contextKeys : Array<String> = [];
        var storage : Storage = _storage;

        var c : Int = storage.length;
        if ( 0 < c ) {

            var context : String = _prefix;
            var contextLength : Int = context.length;

            for ( i in 0...c ) {

                var key : String = storage.key( i );
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
    public function getItem( key : String ) : String {

        return _storage.getItem( _prefix + key );
    }

    /**
		Will add that key to the storage, or update that key's value if it already exists.
	**/
    public function setItem( key : String, value : String ) : Void {

        return _storage.setItem( _prefix + key, value );
    }

    /**
		Will remove that key from the storage.
	**/
    public function removeItem( key : String ) : Void {

        return _storage.removeItem( _prefix + key );
    }

    /**
		Will empty all keys out of the storage.
	**/
    public function clearContext() : Void {

        var contextKeys : Array<String> = getKeys();
        var c : Int = contextKeys.length;
        if ( 0 < c ) {

            var context : String = _prefix;
            var storage : Storage = _storage;

            for ( i in 0...c ) {

                storage.removeItem( context + contextKeys[ i ] );
            }
        }
    }

    /**
		Creates a string representation of this instance.
	**/
    public function toString() : String {

        var contextKeys : Array<String> = getKeys();
            contextKeys.sort( ArrayUtil.sortFunctionAscending );

        var c : Int = contextKeys.length;

        var string : String = c + " key value pair(s) for storage context '" + _prefix + "'";

        if ( 0 < c ) {

            var context : String = _prefix;
            var storage : Storage = _storage;

            for ( i in 0...c ) {

                var key : String = contextKeys[ i ];

                string += "\n" +  "'" + key + "' ---> '" + storage.getItem( context + key ) + "'";
            }
        }

        return string;
    }
    }
}
