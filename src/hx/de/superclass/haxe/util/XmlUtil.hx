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

import Xml.XmlType;

/**
	`XmlUtil` provides simple helper methods to work with xml.
**/
class XmlUtil {

	public static var DOCTYPE_DECLARATION : String = '<?xml version="1.0" encoding="UTF-8"?>';
	public static var CDATA_PREFIX : String = '<![CDATA[';
	public static var CDATA_SUFFIX : String = ']]>';
	public static var SPECIAL_CHARACTERS : Array<String> = [ "<", "&", ">", '"', "'"];

	public static function getChildIndex( parent : Xml, child : Xml ) : Int {

		var index : Int = -1;

		for ( element in parent.elements() ) {

			index++;
			if ( element == child ) {

				return index;
			}
		}

		return index;
	}

	public static function tryParse( xmlString ) : Xml
	{
		var xml : Xml = null;
		try {

			xml = Xml.parse( xmlString );

			// find first opening tag name and check if it's closing tag exists
			var nodeName : String = xml.firstElement().nodeName;
			var endNode : String = "</" + nodeName + ">";

			if ( xmlString.indexOf( endNode ) == -1 ) {

				return null;
			}
		}
		catch( e : Dynamic ) {

			trace( e );
			return null;
		}

		return xml;
	}

	public static function removeChildren( parent : Xml ) : Void {

		for ( node in parent.iterator() ) {

			parent.removeChild( node );
		}
	}

	public static function addCdata( cdata : String ) : String {

		return CDATA_PREFIX + cdata + CDATA_SUFFIX;
	}

	public static function needsCdata( string : String ) : Bool {

		var characters : Array<String> = SPECIAL_CHARACTERS;
		for ( i in 0...characters.length ) {

			if ( string.indexOf( characters[ i ] ) != -1 ) {

				return true;
			}
		}

		return false;
	}

	public static function createCDataIfNeeded( cdata : String ) : Xml {

		if ( needsCdata( cdata ) ) {

			return Xml.createCData( cdata );
		}
		return Xml.createPCData( cdata );
	}

	public static function addCdataIfNeeded( cdata : String ) : String {

		if ( needsCdata( cdata ) ) {

			return CDATA_PREFIX + cdata + CDATA_SUFFIX;
		}
		return cdata;
	}

	public static function removeCdata( cdataString : String ) : String {

		if ( cdataString != null ) {

			var prefix : String = CDATA_PREFIX;
			var startIndex : Int = cdataString.indexOf( prefix );
			if ( startIndex != -1 ) {

				startIndex += prefix.length;

				var suffix : String = CDATA_SUFFIX;
				var endIndex : Int = cdataString.indexOf( suffix, startIndex );
				if ( endIndex != -1 ) {

					cdataString = cdataString.substring( startIndex, endIndex );
				}
			}
		}

		return cdataString;
	}

	public static function getFirstChildNamed( parent : Xml, name : String ) : Xml {

		for ( element in parent.elementsNamed( name ) ) {

			return element;
		}

		return null;
	}

	public static function getChildNodesNamedNested( parent : Xml, names : Array<String> ) :  Array<Xml> {

		var index : Int = 0;
		var count : Int = names.length;
		if ( count == 0 ) {

			return null;
		}

		while ( parent != null && index < count - 1 ) {

			// Get next nestet child
			parent = getFirstChildNamed( parent, names[ index ] );
			// Next index
			index++;
		}

		if ( parent != null ) {

			var nodes : Array<Xml> = getChildNodesNamed( parent, names[ index ] );
			return nodes;
		}

		return null;
	}

	public static function filterElements( parent : Xml, filter : Xml -> Bool ) : Array<Xml> {

		var nodes : Array<Xml> = [];

		for ( element in parent.elements() ) {

			if ( filter( element ) ) {

				nodes[ nodes.length ] = element;
			}
		}

		return nodes;
	}

	public static function filterElementsFirst( parent : Xml, filter : Xml -> Bool ) : Xml {

		for ( element in parent.elements() ) {

			if ( filter( element ) ) {

				return element;
			}
		}

		return null;
	}

	public static function getFirstChildNamedNested( parent : Xml, names : Array<String> ) : Xml {

		var index : Int = 0;
		var count : Int = names.length;
		if ( count == 0 ) {

			return null;
		}

		while ( parent != null && index < count ) {

			// Get next nestet child
			parent = getFirstChildNamed( parent, names[ index ] );
			// Next index
			index++;
		}

		return parent;
	}

	public static function getNodeValueString( node : Xml ) : String {

		if ( node != null ) {

			var xml : Xml = node.firstChild();
			if ( xml == null ) {

				return "";
			}
			return "" + xml;
		}
		return null;
	}

	public static function getChildNodesNamed( parent : Xml, name : String ) : Array<Xml> {

		var nodes : Array<Xml> = [];

		for ( element in parent.elementsNamed( name ) ) {

			nodes[ nodes.length ] = element;
		}

		return nodes;
	}

	public static function getChildNodes( parent : Xml ) : Array<Xml> {

		var nodes : Array<Xml> = [];

		for ( element in parent.elements() ) {

			nodes[ nodes.length ] = element;
		}

		return nodes;
	}

	public static function replace( currentElement : Xml, newElement : Xml ) : Void {

		var parentElement : Xml = currentElement.parent;

		parentElement.insertChild( newElement, getChildIndex( parentElement, currentElement ) );
		parentElement.removeChild( currentElement );
	}

	public static function prettify( xml : Xml, tab : String, lineBreak : String, linePrefix : String, ?maxDepth : Int = -1, ?depth : Int = 0 ) : String {

		switch ( xml.nodeType ) {

			case XmlType.Element:

				var nodeName : String = xml.nodeName;

				// start on new line
				var xmlString : String = lineBreak + linePrefix;

				// open start node
				xmlString += "<" + nodeName;

				// apply attributes in sorted order
				var attributes : Array<String> = null;
				for ( attribute in xml.attributes() ) {

					// create on demmand
					if ( attributes == null ) attributes = [];
					// add
					attributes[ attributes.length ] = attribute;
				}

				if ( attributes != null ) {

					attributes.sort( ArrayUtil.sortFunctionAscending );

					for ( i in 0...attributes.length ) {

						var attribute : String = attributes[ i ];

						xmlString += " " + attribute + "=\"" + xml.get( attribute ) + "\"";
					}
				}

				// close start node
				xmlString += ">";

				// line end node
				var endNodeOnNewLine : Bool = false;
				// iterate on all children
				for ( xmlChild in xml ) {

					if ( xmlChild.nodeType == Xml.Element ) {

						endNodeOnNewLine = true;
					}

					if ( maxDepth < 0 || depth < maxDepth ) {

						xmlString += prettify( xmlChild, tab, lineBreak, linePrefix + tab, maxDepth, depth + 1 );
					}
				}

				// end node
				if ( endNodeOnNewLine ) {

					xmlString += lineBreak + linePrefix;
				}

				xmlString += "</" + nodeName + ">";

				return xmlString;

			case XmlType.PCData:

				var xmlString : String = xml.toString();

				// trim whitespace, tabs and linebreaks
				while ( 0 < xmlString.length ) {

					switch ( xmlString.charAt( 0 ) ) {

						case " ":
						case "\t":
						case "\n":
						case "\r":
						default:

							break;
					}

					xmlString = xmlString.substr( 1 );
				}

				while ( 0 < xmlString.length ) {

					switch ( xmlString.charAt( xmlString.length - 1 ) ) {

						case " ":
						case "\t":
						case "\n":
						case "\r":
						default:

							break;
					}

					xmlString = xmlString.substr( 0, xmlString.length - 1 );
				}

				return xmlString;

			case XmlType.CData:

				return xml.toString();

			case XmlType.Comment:

				// ignore comments
				return "";

			case XmlType.DocType:

				return xml.toString();

			case XmlType.ProcessingInstruction:

				return xml.toString();

			case XmlType.Document:

				// just forward to first element but avoid first linebreak
				var xmlString : String = prettify( xml.firstElement(), tab, lineBreak, linePrefix, maxDepth, depth );
				if ( lineBreak.length <= xmlString.length ) {

					xmlString = xmlString.substr( lineBreak.length );
				}

				return xmlString;
		}

		return "";
	}

	public static inline function prettifyMax( xml : Xml ) : String {

		return prettify( xml, "\t", "\n", "" );
	}

	public static inline function prettifyMin( xml : Xml ) : String {

		return prettify( xml, "", "", "" );
	}

	public static inline function removeAttribute( xml : Xml, att : String, value : String ) : Bool {

		if ( xml.get( att ) == value ) {

			xml.remove( att );
			return true;
		}
		return return false;
	}
}
