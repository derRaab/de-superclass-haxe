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

package de.superclass.haxe.io;

/**
	`Log` provides a static logger api which forwards calls to actual implementations added using `addLogger`.
**/
class Log {

    private static var _loggers : Array<ILogger>;

    public static function addLogger( logger : ILogger ) : Void {

        if ( logger != null ) {

            var loggers : Array<ILogger> = _loggers;
            if ( loggers == null ) {

                _loggers = loggers = [];
            }
            loggers[ loggers.length ] = logger;
        }
    }

    #if (!debug)
    public static function log( msg : Dynamic ) : Void {

        var loggers : Array<ILogger> = _loggers;
        if ( loggers != null ) {

            for ( i in 0...loggers.length ) {

                loggers[ i ].log( msg, null );
            }
        }
    }

    public static function warn( msg : Dynamic ) : Void {

        var loggers : Array<ILogger> = _loggers;
        if ( loggers != null ) {

            for ( i in 0...loggers.length ) {

                loggers[ i ].warn( msg, null );
            }
        }
    }

    public static function error( msg : Dynamic ) : Void {

        var loggers : Array<ILogger> = _loggers;
        if ( loggers != null ) {

            for ( i in 0...loggers.length ) {

                loggers[ i ].error( msg, null );
            }
        }
    }

    public static function errorThrow( msg : Dynamic ) : Dynamic {

        error( msg );
        throw msg;
    }
    #else

    public static function log( msg : Dynamic, ?infos:haxe.PosInfos ) : Void {

        var loggers : Array<ILogger> = _loggers;
        if ( loggers != null ) {

            for ( i in 0...loggers.length ) {

                loggers[ i ].log( msg, infos );
            }
        }
    }

    public static function warn( msg : Dynamic, ?infos:haxe.PosInfos ) : Void {

        var loggers : Array<ILogger> = _loggers;
        if ( loggers != null ) {

            for ( i in 0...loggers.length ) {

                loggers[ i ].warn( msg, infos );
            }
        }
    }

    public static function error( msg : Dynamic, ?infos:haxe.PosInfos ) : Void {

        var loggers : Array<ILogger> = _loggers;
        if ( loggers != null ) {

            for ( i in 0...loggers.length ) {

                loggers[ i ].error( msg, infos );
            }
        }
    }

    public static function errorThrow( msg : Dynamic, ?infos:haxe.PosInfos ) : Dynamic {

        error( msg, infos );
        throw msg;
    }
    #end
}
