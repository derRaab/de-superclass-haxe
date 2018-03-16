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
	`ReflectUtil` provides simple helper methods for the reflect api.
**/

class ReflectUtil {

	public static function getField( o : Dynamic, fieldName : String ) : Dynamic {

		#if js
			return untyped __js__("o[fieldName]");
		#else
			return Reflect.field( o, fieldName );
		#end
	}

	public static function getNestedField( o : Dynamic, fieldNames : Array<String> ) : Dynamic {

		if ( ArrayUtil.hasLength( fieldNames ) ) {

			for ( i in 0...fieldNames.length ) {

				o = getField( o, fieldNames[ i ] );
				if ( o == null ) {

					break;
				}
			}

			return o;
		}
		return null;
	}

	public static function ensureFieldNamed( o : Dynamic, fieldName : String, value : Dynamic ) : Void {

		var currentValue : Dynamic = getField( o, fieldName );
		if ( currentValue != value ) {

			setField( o, fieldName, value );
		}
	}

	public static function setField( o : Dynamic, fieldName : String, value : Dynamic ) : Void {

		#if js
			untyped __js__("o[fieldName]=value");
		#else
			Reflect.setField( o, fieldName, value );
		#end
	}

	public static function callMethodNamed( o : Dynamic, methodName : String, args : Array<Dynamic> ) : Dynamic {

		var func : Dynamic = Reflect.getProperty( o, methodName );
		return Reflect.callMethod( o, func, args );
	}

	public static function callNestedMethodNamed( o : Dynamic, methodPath : Array<String>, args : Array<Dynamic> ) : Dynamic {

		var index : Int = 0;
		var lastIndex : Int = methodPath.length - 1;

		while ( o != null  ) {

			if ( index < lastIndex ) {

				o = Reflect.getProperty( o, methodPath[ index ] );
				++index;
			}
			else if ( index == lastIndex ) {

				var func : Dynamic = Reflect.getProperty( o, methodPath[ index ] );
				return Reflect.callMethod( o, func, args );
			}
			else {

				return null;
			}
		}

		return null;
	}
}
