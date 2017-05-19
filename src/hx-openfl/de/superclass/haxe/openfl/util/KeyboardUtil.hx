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

package de.superclass.haxe.openfl.util;

import openfl.events.KeyboardEvent;
import openfl.events.IEventDispatcher;

/**
	`KeyboardUtil` provides simple helper methods to work with `Keyboard`.
**/
class KeyboardUtil {

    private static var _keyboardEventDispatcher : IEventDispatcher;
    private static var _keyCodeDownMap : Map<Int,Bool> = new Map();

    public static function setKeyboardEventDispatcher( eventDispatcher : IEventDispatcher ) : Void {

        if ( eventDispatcher == _keyboardEventDispatcher ) {

            return;
        }

        if ( _keyboardEventDispatcher != null ) {

            _keyboardEventDispatcher.removeEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown );
            _keyboardEventDispatcher.removeEventListener( KeyboardEvent.KEY_UP, _onKeyUp );
        }

        _keyboardEventDispatcher = eventDispatcher;

        if ( eventDispatcher != null ) {

            eventDispatcher.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown );
            eventDispatcher.addEventListener( KeyboardEvent.KEY_UP, _onKeyUp );
        }
    }

    public static function keyCodeIsDown( keyCode : Int ) : Bool {

        return _keyCodeDownMap.get( keyCode ) == true;
    }

    private static function _onKeyDown( keyboardEvent : KeyboardEvent ) : Void {

        _keyCodeDownMap.set( keyboardEvent.keyCode, true );
    }

    private static function _onKeyUp( keyboardEvent : KeyboardEvent ) : Void {

        _keyCodeDownMap.set( keyboardEvent.keyCode, false );
    }
}
