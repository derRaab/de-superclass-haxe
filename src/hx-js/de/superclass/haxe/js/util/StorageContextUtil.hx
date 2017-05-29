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
	`StorageContextUtil` provides simple helper methods to work with `Browser.window.localStorage`.
**/
import de.superclass.haxe.js.html.StorageContext;
import de.superclass.haxe.util.UrlUtil;
import js.Browser;

class StorageContextUtil {

    private static var _localStorageContext : StorageContext;
    private static var _sessionStorageContext : StorageContext;

    /**
		Sets the local storage context used.
	**/
    public static function setLocalStorageContext( storageContext : StorageContext ) : Void {

        _localStorageContext = storageContext;
    }

    /**
		Returns the local storage context used.
	**/
    public static function getLocalStorageContext() : StorageContext {

        return _localStorageContext;
    }

    /**
		Sets the session storage context used.
	**/
    public static function setSessionStorageContext( storageContext : StorageContext ) : Void {

        _sessionStorageContext = storageContext;
    }

    /**
		Returns the session storage context used.
	**/
    public static function getSessionStorageContext() : StorageContext {

        return _sessionStorageContext;
    }

    /**
		Creates an context of `Browser.location.href` without vars and hash.
	**/
    public static function createPageContextPrefix() : String {

        return UrlUtil.removeVars(  UrlUtil.removeHash( Browser.location.href ) ).toLowerCase();
    }
}