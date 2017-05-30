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

import de.superclass.haxe.css.model.constant.CssPropertyPrefix;
import de.superclass.haxe.util.StringUtil;
import js.html.CSSStyleDeclaration;

/**
	`CssStyleDeclarationUtil` provides simple helper methods to work with `js.html.CSSStyleDeclaration`.
**/
class CssStyleDeclarationUtil {

    private static var _propertyPrefixedMap : Map<String,Array<String>>;

    public static function getPropertyPrefixedList( property : String ) : Array<String> {

        if ( StringUtil.hasLength( property ) ) {

            var propertyPrefixedMap : Map<String,Array<String>> = _propertyPrefixedMap;
            if ( propertyPrefixedMap == null ) {

                _propertyPrefixedMap = propertyPrefixedMap = new Map();
            }

            var propertyPrefixed : Array<String> = propertyPrefixedMap.get( property );
            if ( propertyPrefixed == null ) {

                propertyPrefixed = [ property ];
                propertyPrefixedMap.set( property, propertyPrefixed );

                var browserPrefixes : Array<String> = CssPropertyPrefix.LIST_ALL;
                for ( i in 0...browserPrefixes.length ) {

                    propertyPrefixed[ propertyPrefixed.length ] = browserPrefixes[ i ] + property;
                }
            }

            return propertyPrefixed;
        }
        return null;
    }

    public static function setPropertyPrefixed( cssStyleDeclaration : CSSStyleDeclaration, property : String, value : String, ?priority : String = "" ) : Void {

        var propertyPrefixed : Array<String> = getPropertyPrefixedList( property );
        for ( i in 0...propertyPrefixed.length ) {

            cssStyleDeclaration.setProperty( propertyPrefixed[ i ], value, priority );
        }
    }

    public static function removePropertyPrefixed( cssStyleDeclaration : CSSStyleDeclaration, property : String ) : Void {

        var propertyPrefixed : Array<String> = getPropertyPrefixedList( property );
        for ( i in 0...propertyPrefixed.length ) {

            cssStyleDeclaration.removeProperty( propertyPrefixed[ i ] );
        }
    }

    public static function getPropertyValuePrefixed( cssStyleDeclaration : CSSStyleDeclaration, property : String ) : String {

        var propertyPrefixed : Array<String> = getPropertyPrefixedList( property );
        for ( i in 0...propertyPrefixed.length ) {

            var valueString : String = cssStyleDeclaration.getPropertyValue( propertyPrefixed[ i ] );
            if ( StringUtil.hasLength( valueString ) ) {

                return valueString;
            }
        }
        return null;
    }

    public static function getPropertyPrefixedTimeSeconds( cssStyleDeclaration : CSSStyleDeclaration, property : String ) : Float {

        var valueString : String = getPropertyValuePrefixed( cssStyleDeclaration, property );
        var seconds : Float = getTimeValueSeconds( valueString );
        return seconds;
    }

    public static function getTimeValueSeconds( valueString : String ) : Float {

        // default value
        var seconds : Float = -1;

        if ( StringUtil.hasLength( valueString ) ) {

            // For a weird reason some browsers use comma instead of .
            var commaIndex : Int = valueString.indexOf( "," );
            if ( commaIndex != -1 ) {

                valueString = valueString.substring( 0, commaIndex ) + "." + valueString.substr( commaIndex + 1 );
            }

            var valueFloat : Float = Std.parseFloat( valueString );
            if ( 0 < valueFloat ) {

                if ( valueString.indexOf( "ms" ) != -1 ) {

                    // is milliseconds
                    return valueFloat / 1000;
                }
                else if ( valueString.indexOf( "s" ) != -1 ) {

                    // is seconds
                    return valueFloat;
                }
            }
        }

        // not found!
        return -1;
    }
}
