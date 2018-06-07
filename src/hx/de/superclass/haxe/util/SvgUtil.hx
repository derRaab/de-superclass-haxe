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
	`SvgUtil` provides simple helper methods for svg manipulation.
**/
class SvgUtil {
	
	private static var _ids: Array<String> = [];

	/**
		Prefixes all SVG internal id values and their usages.
	**/
    public static function prefixIds( svgXmlRootNode : Xml, prefix : String ) : Void {

	    _iterateAllElements( svgXmlRootNode.elements(), prefix );
    }

	private static function _iterateAllElements( elements : Iterator<Xml> , prefix : String ) : Void {

		while( elements.hasNext() ){

			var element : Xml = elements.next();

			if ( element.nodeName.toLowerCase() == "style" ) {

				_setPrefixToStyle( element, prefix );
			}
			else {

				if( element.exists( "class" ) ) {

					_prefixAttribute( element , prefix , "class" );
				}

				if( element.exists( "id" ) ) {

					_setPrefixToId( element , prefix ) ;
				}

				if( element.exists( "xlink:href" ) ) {

					_setPrefixToUse( element , prefix ) ;
				}

				if( element.exists( "mask" ) ) {

					_setPrefixToAttribute( element , prefix , "mask" ) ;
				}

				if( element.exists( "filter" ) ) {

					_setPrefixToAttribute( element , prefix , "filter" );
				}

				if( element.exists( "fill" ) ) {

					_setPrefixToAttribute( element , prefix , "fill" );
				}

				if( element.exists( "clip-path" ) ) {

					_setPrefixToAttribute( element , prefix , "clip-path" );
				}
			}

			var childElements = element.elements();
			if( childElements != null ) {

				_iterateAllElements( childElements, prefix );
			}
		}
	}

	private static function _setPrefixToStyle( styleElement : Xml , prefix: String ) : Void {

		var cssStringXml : Xml = styleElement.firstChild();
		if ( cssStringXml == null ) {

			return;
		}

		styleElement.removeChild( cssStringXml );

		var cssString = "" + cssStringXml;

		// Extract all strings between . and {
		var eregClass : EReg = ~/(\.)(.*)(\{)/ig;

		var cssClasses : Array<String> = ERegUtil.getMatchedArray( eregClass, 2, cssString );
		for ( i in 0...cssClasses.length ) {

			var cssClass : String = cssClasses[ i ];
			cssString = StringUtil.replace( cssString, "." + cssClass + "{", "." + prefix + cssClass + "{" );
		}

		styleElement.addChild( Xml.createPCData( cssString ) );
	}

	private static function _setPrefixToId( element : Xml , prefix: String ) : Void {

		var id : String = element.get( "id" );
		var ids : Array<String> = _ids;
			ids[ ids.length ] = id;
		element.set("id", prefix+id);

		_ids = ids;
	}

	private static function _setPrefixToUse( element : Xml , prefix: String ) : Void {

		var attribute : String = element.get( "xlink:href" );

		if( attribute.indexOf("#") == -1 ) {

			return;
		}

		var href : String = attribute.split( "#" )[ 1 ];

		var ids: Array<String> = _ids;

		if( ids.indexOf( href ) != -1 ){

			element.set( "xlink:href",  "#" + prefix + href );
		}
	}

	private static function _setPrefixToAttribute( element : Xml , prefix: String , attribute : String ) : Void {

		var attributeContent : String = element.get( attribute );

		if ( attributeContent.indexOf( "url(#" ) == -1 ) return;

		var splitString  : Array<String> = attributeContent.split( "url(#" );
		var idSplit : String = splitString[ 1 ];
		var	id : String = idSplit.substr( 0, idSplit.length-1 );
		var ids: Array<String> = _ids;

		if( ids.indexOf( id ) != -1 ){

			var value : String = "url(#" + prefix + splitString[ 1 ];
			element.set( attribute ,value );
		}
	}

	private static function _prefixAttribute( element : Xml , prefix: String , attribute : String ) : Void {

		element.set( attribute, prefix + element.get( attribute ) );
	}
}
