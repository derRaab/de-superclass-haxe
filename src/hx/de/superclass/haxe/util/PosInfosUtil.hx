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

import haxe.PosInfos;

/**
	`PosInfosUtil` provides simple helper methods to work with `PosInfos` instances.
**/
class PosInfosUtil {

    public static function toString( posInfos : PosInfos ) : String {

        if ( posInfos != null ) {

            return posInfos.className + "." + posInfos.methodName + "() at " + posInfos.fileName + ":" + posInfos.lineNumber;
        }
        return "";
    }

    public static function toStringClassLine( posInfos : PosInfos ) : String {

        if ( posInfos != null ) {

            return posInfos.className + ":" + posInfos.lineNumber;
        }
        return "";
    }

    public static function toStringClassMethodLine( posInfos : PosInfos ) : String {

        if ( posInfos != null ) {

            return posInfos.className + "." + posInfos.methodName + "():" + posInfos.lineNumber;
        }
        return "";
    }
}
