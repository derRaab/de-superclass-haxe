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

	public static function getChildNodesNamedNested( parent : Xml, names : Array<String>, namesIndex : Int = 0 ) :  Array<Xml> {

		if ( parent != null && names != null ) {

			var namesLength : Int = names.length;
			if ( namesIndex < namesLength ) {

				var indexName : String = names[ namesIndex ];
				if ( StringUtil.hasLength( indexName ) ) {

					var indexNameXmls : Array<Xml> = getChildNodesNamed( parent, indexName );
					if ( ArrayUtil.hasLength( indexNameXmls ) ) {

						var nextNamesIndex : Int = namesIndex + 1;
						if ( nextNamesIndex == namesLength ) {

							// Found nested nodes
							return indexNameXmls;
						}
						else {

							var namedXmls : Array<Xml> = null;

							for ( i in 0...indexNameXmls.length ) {

								var nestedNamedXmls : Array<Xml> = getChildNodesNamedNested( indexNameXmls[ i ], names, nextNamesIndex );
								if ( ArrayUtil.hasLength( nestedNamedXmls ) ) {

									if ( namedXmls == null ) {

										namedXmls = nestedNamedXmls;
									}
									else {

										namedXmls = namedXmls.concat( nestedNamedXmls );
									}
								}
							}

							return namedXmls;
						}
					}
				}
			}
		}

		return null;
	}

//	public static function getChildNodesNamedNested( parent : Xml, names : Array<String> ) :  Array<Xml> {
//
//		var index : Int = 0;
//		var count : Int = names.length;
//		if ( count == 0 ) {
//
//			return null;
//		}
//
//		while ( parent != null && index < count - 1 ) {
//
//			// Get next nestet child
//			parent = getFirstChildNamed( parent, names[ index ] );
//			// Next index
//			index++;
//		}
//
//		if ( parent != null ) {
//
//			var nodes : Array<Xml> = getChildNodesNamed( parent, names[ index ] );
//			return nodes;
//		}
//
//		return null;
//	}

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

	public static function getNodeValueString( nodeXml : Xml ) : String {

		if ( nodeXml != null ) {

			var stringValue : String = "";

			for ( childXml in nodeXml.iterator() ) {

				switch ( childXml.nodeType ) {

					case XmlType.CData:

						stringValue += childXml.nodeValue;

					case XmlType.PCData:

						var nodeValue : String = childXml.nodeValue;
						if ( nodeValue != null && 0 < nodeValue.length ) {

							var r = ~/\n\r\t/g;
							nodeValue = r.replace( nodeValue, "" );
							nodeValue = StringTools.trim( nodeValue );
						}

						stringValue += nodeValue;

					default:
				}
			}

			return stringValue;
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

	public static function prettify( xml : Xml, tab : String, lineBreak : String, linePrefix : String, ?maxDepth : Int = -1, ?depth : Int = 0, ?selfClosingTagSupported : Bool = false ) : String {

		switch ( xml.nodeType ) {

			case XmlType.Element:

				// Create opening element tag
				var nodeName : String = xml.nodeName;

				// Start on new line
				var xmlString : String = lineBreak + linePrefix;

				// Open start node
				xmlString += "<" + nodeName;

				// Force every child content on single line if any text content child is detected
				var inlineChildren : Bool = false;
				for ( xmlChild in xml ) {

					if ( xmlChild.nodeType == Xml.PCData && 0 < xmlChild.nodeValue.length ) {

						tab = "";
						lineBreak = "";
						linePrefix = "";

						inlineChildren = true;
						// Inline tags always allowed to self close! (HTML)
						selfClosingTagSupported = true;
						break;
					}
				}

				var endNodeOnNewLine : Bool = false;

				// Prettify children
				var xmlChildrenString : String = "";
				for ( xmlChild in xml ) {

					if ( xmlChild.nodeType == Xml.Element ) {

						endNodeOnNewLine = true;
					}

					if ( maxDepth < 0 || depth < maxDepth ) {

						xmlChildrenString += prettify( xmlChild, tab, lineBreak, linePrefix + tab, maxDepth, depth + 1, selfClosingTagSupported );
					}
				}

				// Apply attributes in sorted order
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

				var hasChildren : Bool = StringUtil.hasLength( xmlChildrenString );

				var isSelfClosingTag : Bool = ( selfClosingTagSupported && ! hasChildren );
				if ( isSelfClosingTag ) {

					xmlString += "/>";
				}
				else {

					var useSingleLine : Bool = ( inlineChildren || ! hasChildren || ! endNodeOnNewLine );
					if ( inlineChildren || ! hasChildren ) {

						xmlString += ">" + xmlChildrenString + "</" + nodeName + ">";
					}
					else {

						xmlString += ">" + xmlChildrenString + lineBreak + linePrefix + "</" + nodeName + ">";
					}
				}

				return xmlString;

			case XmlType.PCData:

				var xmlString : String = xml.toString();

				// Trim tabs and linebreaks
				while ( 0 < xmlString.length ) {

					switch ( xmlString.charAt( 0 ) ) {

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
				var xmlString : String = prettify( xml.firstElement(), tab, lineBreak, linePrefix, maxDepth, depth, selfClosingTagSupported );
				if ( lineBreak.length <= xmlString.length ) {

					xmlString = xmlString.substr( lineBreak.length );
				}

				return xmlString;
		}

		return "";
	}

	public static inline function prettifyMaxString( xmlString : String, ?selfClosingTagSupported : Bool = false ) : String {

		return prettify( Xml.parse( xmlString ), "\t", "\n", "", -1, 0, selfClosingTagSupported );
	}

	public static inline function prettifyMax( xml : Xml, ?selfClosingTagSupported : Bool = false ) : String {

		return prettify( xml, "\t", "\n", "", -1, 0, selfClosingTagSupported );
	}

	public static inline function prettifyMin( xml : Xml, ?selfClosingTagSupported : Bool = false ) : String {

		return prettify( xml, "", "", "", -1, 0, selfClosingTagSupported );
	}

	public static inline function removeAttribute( xml : Xml, att : String, value : String ) : Bool {

		if ( xml.get( att ) == value ) {

			xml.remove( att );
			return true;
		}
		return return false;
	}

	public static function clone( xml : Xml ) : Xml {

		var xmlString : String = xml.toString();
		var xml2 : Xml = Xml.parse( xmlString );

		if ( xml.nodeType != xml2.nodeType ) {

			xml2 = xml2.firstElement();
		}

		return xml2;
	}

	public static function prettify2( xml : Xml, tab : String, lineBreak : String, linePrefix : String, ?maxDepth : Int = -1, ?depth : Int = 0, ?selfClosingTagSupported : Bool = false, ?commentsSupported : Bool = false ) : String {

		switch ( xml.nodeType ) {

			case XmlType.Element:

				var nodeName : String = xml.nodeName;

				// OPEN TAG - maybe new line
				var xmlString : String = lineBreak + linePrefix + "<" + nodeName;

				// APPLY ATTRIBUTES in sorted order
				var attributes : Array<String> = null;
				for ( attribute in xml.attributes() ) {

					if ( attributes == null ) attributes = [];
					attributes[ attributes.length ] = attribute;
				}

				if ( attributes != null ) {

					attributes.sort( ArrayUtil.sortFunctionAscending );

					for ( i in 0...attributes.length ) {

						var attribute : String = attributes[ i ];

						xmlString += " " + attribute + "=\"" + xml.get( attribute ) + "\"";
					}
				}

				var closeTagOnNewLine : Bool = true;


				// PRETTIFY CHILDREN
				var xmlChildrenString : String = "";
				if ( maxDepth < 0 || depth < maxDepth ) {

					var childCount : Int = 0;
					var pcChildCount : Int = 0;

					for ( xmlChild in xml ) {

						var xmlChildString : String =  prettify2( xmlChild, tab, lineBreak, linePrefix + tab, maxDepth, depth + 1, selfClosingTagSupported, commentsSupported );
						if ( StringUtil.hasLength( xmlChildString ) ) {

							childCount++;

							if ( xmlChild.nodeType != Xml.Element ) {

								if ( xmlChild.nodeType == Xml.PCData ) {

									pcChildCount++;
								}

								// Put all other nodes on new line
								xmlChildrenString += lineBreak + linePrefix + tab;
							}

							xmlChildrenString += xmlChildString;
						}
					}

					if ( childCount == 1 && pcChildCount == 1 ) {

						xmlChildrenString = xmlChildrenString.substr( Std.string( lineBreak + linePrefix + tab ).length );
						closeTagOnNewLine = false;
					}
				}

				var hasChildren : Bool = StringUtil.hasLength( xmlChildrenString );
				var closeTagItself : Bool = ( selfClosingTagSupported && ! hasChildren );

				// CLOSE TAG
				if ( closeTagItself ) {

					xmlString += "/>";
				}
				else {

					xmlString += ">";

					if ( hasChildren ) {

						xmlString += xmlChildrenString;

						if ( closeTagOnNewLine ) {

							xmlString += lineBreak + linePrefix;
						}
					}

					xmlString += "</" + nodeName + ">";
				}

				return xmlString;

			case XmlType.PCData:

				var xmlString : String = xml.nodeValue;

				xmlString = StringUtil.replace( xmlString, "\n", " " );
				xmlString = StringUtil.replace( xmlString, "\r", " " );
				xmlString = StringUtil.replace( xmlString, "\t", " " );
				xmlString = StringUtil.trim( xmlString, " " );

				return xmlString;

			case XmlType.CData:

				return xml.toString();

			case XmlType.Comment:

				return ( commentsSupported ) ? xml.toString() : "";

			case XmlType.DocType:

				return xml.toString();

			case XmlType.ProcessingInstruction:

				return xml.toString();

			case XmlType.Document:

				// Just forward to first element but avoid first linebreak
				var xmlString : String = prettify2( xml.firstElement(), tab, lineBreak, linePrefix, maxDepth, depth, selfClosingTagSupported );
				if ( lineBreak.length <= xmlString.length ) {

					xmlString = xmlString.substr( lineBreak.length );
				}

				return xmlString;
		}

		return "";
	}

	public static inline function prettify2Max( xml : Xml, ?selfClosingTagSupported : Bool = false, ?commentsSupported : Bool = false ) : String {

		return prettify2( xml, "\t", "\n", "", -1, 0, selfClosingTagSupported, commentsSupported );
	}

	public static inline function prettify2Min( xml : Xml, ?selfClosingTagSupported : Bool = false, ?commentsSupported : Bool = false ) : String {

		return prettify2( xml, "", "", "", -1, 0, selfClosingTagSupported, commentsSupported );
	}
}
