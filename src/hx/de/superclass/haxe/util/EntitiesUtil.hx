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
	`EntitiesUtil` provides simple helper methods to work with html entities.
	@see http://www.codetable.net/entitiesinhtml
**/
class EntitiesUtil {

    private static var _decimalCodeMap : Map<String,EntityVo>;
    private static var _es : Array<EntityVo>;
    private static var _hexCodeMap : Map<String,EntityVo>;
    private static var _htmlCodeMap : Map<String,EntityVo>;
    private static var _symbolMap : Map<String,EntityVo>;

    public static function encodeHtml( string : String ) : String {

        if ( _symbolMap == null ) {

            _initializeEntities();
        }
        var symbolMap : Map<String,EntityVo> = _symbolMap;

        var encodedString : String = "";

        for ( i in 0...string.length ) {

            var symbol : String = string.charAt( i );
            var htmlEntityVo : EntityVo = symbolMap.get( symbol );
            if ( htmlEntityVo != null ) {

                encodedString += htmlEntityVo.htmlCode;
            }
            else {

                encodedString += symbol;
            }
        }

        return encodedString;
    }

    public static function encodeDecimal( string : String ) : String {

        if ( _symbolMap == null ) {

            _initializeEntities();
        }
        var symbolMap : Map<String,EntityVo> = _symbolMap;

        var encodedString : String = "";

        for ( i in 0...string.length ) {

            var symbol : String = string.charAt( i );
            var htmlEntityVo : EntityVo = symbolMap.get( symbol );
            if ( htmlEntityVo != null ) {

                encodedString += htmlEntityVo.decimalCode;
            }
            else {

                encodedString += symbol;
            }
        }

        return encodedString;
    }

    public static function encodeHex( string : String ) : String {

        if ( _symbolMap == null ) {

            _initializeEntities();
        }
        var symbolMap : Map<String,EntityVo> = _symbolMap;

        var encodedString : String = "";

        for ( i in 0...string.length ) {

            var symbol : String = string.charAt( i );
            var htmlEntityVo : EntityVo = symbolMap.get( symbol );
            if ( htmlEntityVo != null ) {

                encodedString += htmlEntityVo.hexCode;
            }
            else {

                encodedString += symbol;
            }
        }

        return encodedString;
    }

    public static function decode( string : String ) : String {

        if ( _symbolMap == null ) {

            _initializeEntities();
        }

        var symbolMap : Map<String,EntityVo> = _symbolMap;
        var decimalCodeMap : Map<String,EntityVo> = _decimalCodeMap;
        var hexCodeMap : Map<String,EntityVo> = _hexCodeMap;
        var entityCodeMap : Map<String,EntityVo> = _htmlCodeMap;

        var decodedString : String = "";
        var htmlEntityVo : EntityVo = null;

        var index : Int = 0;
        var ampersandIndex : Int = string.indexOf( "&", index );
        while ( ampersandIndex != -1 ) {

            if ( index < ampersandIndex ) {

                // Add everything between last index and ampersand to string and shift index
                decodedString += string.substring( index, ampersandIndex );
                index = ampersandIndex;
            }

            var semicolonIndex : Int = string.indexOf( ";", ampersandIndex );
            if ( semicolonIndex != -1 ) {

                var possibleEntity : String = string.substring( ampersandIndex, semicolonIndex + 1 );
                var possibleEntityLowerCase : String = possibleEntity.toLowerCase();
                var possibleSymbol : String = null;

                if ( possibleEntity.indexOf( "&#x" ) == 0 ) {

                    // Hex code
                    htmlEntityVo = hexCodeMap.get( possibleEntityLowerCase );
                    if ( htmlEntityVo != null ) {

                        possibleSymbol = htmlEntityVo.symbol;
                    }
                }
                else if ( possibleEntity.indexOf( "&#" ) == 0 ) {

                    // Decimal code
                    htmlEntityVo = decimalCodeMap.get( possibleEntityLowerCase );
                    if ( htmlEntityVo != null ) {

                        possibleSymbol = htmlEntityVo.symbol;
                    }
                }
                else {

                    // Entity code
                    htmlEntityVo = entityCodeMap.get( possibleEntityLowerCase );
                    if ( htmlEntityVo != null ) {

                        possibleSymbol = htmlEntityVo.symbol;
                    }
                }

                if ( possibleSymbol != null ) {

                    decodedString += possibleSymbol;
                }
                else {

                    decodedString += possibleEntity;
                }

                index = semicolonIndex + 1;
                ampersandIndex = string.indexOf( "&", index );
            }
            else {

                // Cancel
                ampersandIndex = -1;
            }
        }

        // Add rest
        decodedString += string.substr( index );

        return decodedString;
    }

    public static function getSymbolHtmlCode( symbol : String ) : String {

        var htmlEntityVo : EntityVo = _getSymbolEntity( symbol );
        if ( htmlEntityVo != null ) {

            return htmlEntityVo.htmlCode;
        }
        return null;
    }

    public static function getSymbolDecimalCode( symbol : String ) : String {

        var htmlEntityVo : EntityVo = _getSymbolEntity( symbol );
        if ( htmlEntityVo != null ) {

            return htmlEntityVo.decimalCode;
        }
        return null;
    }

    public static function getSymbolHexCode( symbol : String ) : String {

        var htmlEntityVo : EntityVo = _getSymbolEntity( symbol );
        if ( htmlEntityVo != null ) {

            return htmlEntityVo.hexCode;
        }
        return null;
    }

    public static function getHtmlCodeSymbol( entityCode : String ) : String {

        var htmlEntityVo : EntityVo = _getEntityCodeEntity( entityCode );
        if ( htmlEntityVo != null ) {

            return htmlEntityVo.symbol;
        }
        return null;
    }

    public static function getDecimalCodeSymbol( decimalCode : String ) : String {

        var htmlEntityVo : EntityVo = _getDecimalCodeEntity( decimalCode );
        if ( htmlEntityVo != null ) {

            return htmlEntityVo.symbol;
        }
        return null;
    }

    public static function getHexCodeSymbol( hexCode : String ) : String {

        var htmlEntityVo : EntityVo = _getHexCodeEntity( hexCode );
        if ( htmlEntityVo != null ) {

            return htmlEntityVo.symbol;
        }
        return null;
    }

    private static inline function _getSymbolEntity( symbol : String ) : EntityVo {

        if ( _symbolMap == null ) {

            _initializeEntities();
        }
        return _symbolMap.get( symbol );
    }

    private static inline function _getEntityCodeEntity( entityCode : String ) : EntityVo {

        if ( _htmlCodeMap == null ) {

            _initializeEntities();
        }
        return _htmlCodeMap.get( entityCode );
    }

    private static inline function _getDecimalCodeEntity( decimalCode : String ) : EntityVo {

        if ( _decimalCodeMap == null ) {

            _initializeEntities();
        }
        return _decimalCodeMap.get( decimalCode );
    }

    private static inline function _getHexCodeEntity( hexCode : String ) : EntityVo {

        if ( _hexCodeMap == null ) {

            _initializeEntities();
        }
        return _hexCodeMap.get( hexCode );
    }

    private static function _initializeEntities() : Void {

        var symbolMap : Map<String,EntityVo> = new Map();
        var entityCodeMap : Map<String,EntityVo> = new Map();
        var decimalCodeMap : Map<String,EntityVo> = new Map();
        var hexCodeMap : Map<String,EntityVo> = new Map();
        var es : Array<EntityVo> = [];

        _symbolMap = symbolMap;
        _htmlCodeMap = entityCodeMap;
        _decimalCodeMap = decimalCodeMap;
        _hexCodeMap = hexCodeMap;
        _es = es;

        es[ es.length ] = new EntityVo( "\"", "&quot;", "&#34;", "&#x22;" );
        es[ es.length ] = new EntityVo( "&", "&amp;", "&#38;", "&#x26;" );
        es[ es.length ] = new EntityVo( "'", "&apos;", "&#39;", "&#x27;" );
        es[ es.length ] = new EntityVo( "<", "&lt;", "&#60;", "&#x3c;" );
        es[ es.length ] = new EntityVo( ">", "&gt;", "&#62;", "&#x3e;" );
        es[ es.length ] = new EntityVo( "", "&nbsp;", "&#160;", "&#xa0;" );
        es[ es.length ] = new EntityVo( "¡", "&iexcl;", "&#161;", "&#xa1;" );
        es[ es.length ] = new EntityVo( "¢", "&cent;", "&#162;", "&#xa2;" );
        es[ es.length ] = new EntityVo( "£", "&pound;", "&#163;", "&#xa3;" );
        es[ es.length ] = new EntityVo( "¤", "&curren;", "&#164;", "&#xa4;" );
        es[ es.length ] = new EntityVo( "¥", "&yen;", "&#165;", "&#xa5;" );
        es[ es.length ] = new EntityVo( "¦", "&brvbar;", "&#166;", "&#xa6;" );
        es[ es.length ] = new EntityVo( "§", "&sect;", "&#167;", "&#xa7;" );
        es[ es.length ] = new EntityVo( "¨", "&uml;", "&#168;", "&#xa8;" );
        es[ es.length ] = new EntityVo( "©", "&copy;", "&#169;", "&#xa9;" );
        es[ es.length ] = new EntityVo( "ª", "&ordf;", "&#170;", "&#xaa;" );
        es[ es.length ] = new EntityVo( "«", "&laquo;", "&#171;", "&#xab;" );
        es[ es.length ] = new EntityVo( "¬", "&not;", "&#172;", "&#xac;" );
        // TODO - copy from somewherees[ es.length ] = new HtmlEntityVo( "¬", &shy;	&#173;	&#xad; );
        es[ es.length ] = new EntityVo( "®", "&reg;", "&#174;", "&#xae;" );
        es[ es.length ] = new EntityVo( "¯", "&macr;", "&#175;", "&#xaf;" );
        es[ es.length ] = new EntityVo( "°", "&deg;", "&#176;", "&#xb0;" );
        es[ es.length ] = new EntityVo( "±", "&plusmn;", "&#177;", "&#xb1;" );
        es[ es.length ] = new EntityVo( "²", "&sup2;", "&#178;", "&#xb2;" );
        es[ es.length ] = new EntityVo( "³", "&sup3;", "&#179;", "&#xb3;" );
        es[ es.length ] = new EntityVo( "´", "&acute;", "&#180;", "&#xb4;" );
        es[ es.length ] = new EntityVo( "µ", "&micro;", "&#181;", "&#xb5;" );
        es[ es.length ] = new EntityVo( "¶", "&para;", "&#182;", "&#xb6;" );
        es[ es.length ] = new EntityVo( "·", "&middot;", "&#183;", "&#xb7;" );
        es[ es.length ] = new EntityVo( "¸", "&cedil;", "&#184;", "&#xb8;" );
        es[ es.length ] = new EntityVo( "¹", "&sup1;", "&#185;", "&#xb9;" );
        es[ es.length ] = new EntityVo( "º", "&ordm;", "&#186;", "&#xba;" );
        es[ es.length ] = new EntityVo( "»", "&raquo;", "&#187;", "&#xbb;" );
        es[ es.length ] = new EntityVo( "¼", "&frac14;", "&#188;", "&#xbc;" );
        es[ es.length ] = new EntityVo( "½", "&frac12;", "&#189;", "&#xbd;" );
        es[ es.length ] = new EntityVo( "¾", "&frac34;", "&#190;", "&#xbe;" );
        es[ es.length ] = new EntityVo( "¿", "&iquest;", "&#191;", "&#xbf;" );
        es[ es.length ] = new EntityVo( "À", "&Agrave;", "&#192;", "&#xc0;" );
        es[ es.length ] = new EntityVo( "Á", "&Aacute;", "&#193;", "&#xc1;" );
        es[ es.length ] = new EntityVo( "Â", "&Acirc;", "&#194;", "&#xc2;" );
        es[ es.length ] = new EntityVo( "Ã", "&Atilde;", "&#195;", "&#xc3;" );
        es[ es.length ] = new EntityVo( "Ä", "&Auml;", "&#196;", "&#xc4;" );
        es[ es.length ] = new EntityVo( "Å", "&Aring;", "&#197;", "&#xc5;" );
        es[ es.length ] = new EntityVo( "Æ", "&AElig;", "&#198;", "&#xc6;" );
        es[ es.length ] = new EntityVo( "Ç", "&Ccedil;", "&#199;", "&#xc7;" );
        es[ es.length ] = new EntityVo( "È", "&Egrave;", "&#200;", "&#xc8;" );
        es[ es.length ] = new EntityVo( "É", "&Eacute;", "&#201;", "&#xc9;" );
        es[ es.length ] = new EntityVo( "Ê", "&Ecirc;", "&#202;", "&#xca;" );
        es[ es.length ] = new EntityVo( "Ë", "&Euml;", "&#203;", "&#xcb;" );
        es[ es.length ] = new EntityVo( "Ì", "&Igrave;", "&#204;", "&#xcc;" );
        es[ es.length ] = new EntityVo( "Í", "&Iacute;", "&#205;", "&#xcd;" );
        es[ es.length ] = new EntityVo( "Î", "&Icirc;", "&#206;", "&#xce;" );
        es[ es.length ] = new EntityVo( "Ï", "&Iuml;", "&#207;", "&#xcf;" );
        es[ es.length ] = new EntityVo( "Ð", "&ETH;", "&#208;", "&#xd0;" );
        es[ es.length ] = new EntityVo( "Ñ", "&Ntilde;", "&#209;", "&#xd1;" );
        es[ es.length ] = new EntityVo( "Ò", "&Ograve;", "&#210;", "&#xd2;" );
        es[ es.length ] = new EntityVo( "Ó", "&Oacute;", "&#211;", "&#xd3;" );
        es[ es.length ] = new EntityVo( "Ô", "&Ocirc;", "&#212;", "&#xd4;" );
        es[ es.length ] = new EntityVo( "Õ", "&Otilde;", "&#213;", "&#xd5;" );
        es[ es.length ] = new EntityVo( "Ö", "&Ouml;", "&#214;", "&#xd6;" );
        es[ es.length ] = new EntityVo( "×", "&times;", "&#215;", "&#xd7;" );
        es[ es.length ] = new EntityVo( "Ø", "&Oslash;", "&#216;", "&#xd8;" );
        es[ es.length ] = new EntityVo( "Ù", "&Ugrave;", "&#217;", "&#xd9;" );
        es[ es.length ] = new EntityVo( "Ú", "&Uacute;", "&#218;", "&#xda;" );
        es[ es.length ] = new EntityVo( "Û", "&Ucirc;", "&#219;", "&#xdb;" );
        es[ es.length ] = new EntityVo( "Ü", "&Uuml;", "&#220;", "&#xdc;" );
        es[ es.length ] = new EntityVo( "Ý", "&Yacute;", "&#221;", "&#xdd;" );
        es[ es.length ] = new EntityVo( "Þ", "&THORN;", "&#222;", "&#xde;" );
        es[ es.length ] = new EntityVo( "ß", "&szlig;", "&#223;", "&#xdf;" );
        es[ es.length ] = new EntityVo( "à", "&agrave;", "&#224;", "&#xe0;" );
        es[ es.length ] = new EntityVo( "á", "&aacute;", "&#225;", "&#xe1;" );
        es[ es.length ] = new EntityVo( "â", "&acirc;", "&#226;", "&#xe2;" );
        es[ es.length ] = new EntityVo( "ã", "&atilde;", "&#227;", "&#xe3;" );
        es[ es.length ] = new EntityVo( "ä", "&auml;", "&#228;", "&#xe4;" );
        es[ es.length ] = new EntityVo( "å", "&aring;", "&#229;", "&#xe5;" );
        es[ es.length ] = new EntityVo( "æ", "&aelig;", "&#230;", "&#xe6;" );
        es[ es.length ] = new EntityVo( "ç", "&ccedil;", "&#231;", "&#xe7;" );
        es[ es.length ] = new EntityVo( "è", "&egrave;", "&#232;", "&#xe8;" );
        es[ es.length ] = new EntityVo( "é", "&eacute;", "&#233;", "&#xe9;" );
        es[ es.length ] = new EntityVo( "ê", "&ecirc;", "&#234;", "&#xea;" );
        es[ es.length ] = new EntityVo( "ë", "&euml;", "&#235;", "&#xeb;" );
        es[ es.length ] = new EntityVo( "ì", "&igrave;", "&#236;", "&#xec;" );
        es[ es.length ] = new EntityVo( "í", "&iacute;", "&#237;", "&#xed;" );
        es[ es.length ] = new EntityVo( "î", "&icirc;", "&#238;", "&#xee;" );
        es[ es.length ] = new EntityVo( "ï", "&iuml;", "&#239;", "&#xef;" );
        es[ es.length ] = new EntityVo( "ð", "&eth;", "&#240;", "&#xf0;" );
        es[ es.length ] = new EntityVo( "ñ", "&ntilde;", "&#241;", "&#xf1;" );
        es[ es.length ] = new EntityVo( "ò", "&ograve;", "&#242;", "&#xf2;" );
        es[ es.length ] = new EntityVo( "ó", "&oacute;", "&#243;", "&#xf3;" );
        es[ es.length ] = new EntityVo( "ô", "&ocirc;", "&#244;", "&#xf4;" );
        es[ es.length ] = new EntityVo( "õ", "&otilde;", "&#245;", "&#xf5;" );
        es[ es.length ] = new EntityVo( "ö", "&ouml;", "&#246;", "&#xf6;" );
        es[ es.length ] = new EntityVo( "÷", "&divide;", "&#247;", "&#xf7;" );
        es[ es.length ] = new EntityVo( "ø", "&oslash;", "&#248;", "&#xf8;" );
        es[ es.length ] = new EntityVo( "ù", "&ugrave;", "&#249;", "&#xf9;" );
        es[ es.length ] = new EntityVo( "ú", "&uacute;", "&#250;", "&#xfa;" );
        es[ es.length ] = new EntityVo( "û", "&ucirc;", "&#251;", "&#xfb;" );
        es[ es.length ] = new EntityVo( "ü", "&uuml;", "&#252;", "&#xfc;" );
        es[ es.length ] = new EntityVo( "ý", "&yacute;", "&#253;", "&#xfd;" );
        es[ es.length ] = new EntityVo( "þ", "&thorn;", "&#254;", "&#xfe;" );
        es[ es.length ] = new EntityVo( "ÿ", "&yuml;", "&#255;", "&#xff;" );
        es[ es.length ] = new EntityVo( "Œ", "&OElig;", "&#338;", "&#x152;" );
        es[ es.length ] = new EntityVo( "œ", "&oelig;", "&#339;", "&#x153;" );
        es[ es.length ] = new EntityVo( "Š", "&Scaron;", "&#352;", "&#x160;" );
        es[ es.length ] = new EntityVo( "š", "&scaron;", "&#353;", "&#x161;" );
        es[ es.length ] = new EntityVo( "Ÿ", "&Yuml;", "&#376;", "&#x178;" );
        es[ es.length ] = new EntityVo( "ƒ", "&fnof;", "&#402;", "&#x192;" );
        es[ es.length ] = new EntityVo( "ˆ", "&circ;", "&#710;", "&#x2c6;" );
        es[ es.length ] = new EntityVo( "˜", "&tilde;", "&#732;", "&#x2dc;" );
        es[ es.length ] = new EntityVo( "Α", "&Alpha;", "&#913;", "&#x391;" );
        es[ es.length ] = new EntityVo( "Β", "&Beta;", "&#914;", "&#x392;" );
        es[ es.length ] = new EntityVo( "Γ", "&Gamma;", "&#915;", "&#x393;" );
        es[ es.length ] = new EntityVo( "Δ", "&Delta;", "&#916;", "&#x394;" );
        es[ es.length ] = new EntityVo( "Ε", "&Epsilon;", "&#917;", "&#x395;" );
        es[ es.length ] = new EntityVo( "Ζ", "&Zeta;", "&#918;", "&#x396;" );
        es[ es.length ] = new EntityVo( "Η", "&Eta;", "&#919;", "&#x397;" );
        es[ es.length ] = new EntityVo( "Θ", "&Theta;", "&#920;", "&#x398;" );
        es[ es.length ] = new EntityVo( "Ι", "&Iota;", "&#921;", "&#x399;" );
        es[ es.length ] = new EntityVo( "Κ", "&Kappa;", "&#922;", "&#x39a;" );
        es[ es.length ] = new EntityVo( "Λ", "&Lambda;", "&#923;", "&#x39b;" );
        es[ es.length ] = new EntityVo( "Μ", "&Mu;", "&#924;", "&#x39c;" );
        es[ es.length ] = new EntityVo( "Ν", "&Nu;", "&#925;", "&#x39d;" );
        es[ es.length ] = new EntityVo( "Ξ", "&Xi;", "&#926;", "&#x39e;" );
        es[ es.length ] = new EntityVo( "Ο", "&Omicron;", "&#927;", "&#x39f;" );
        es[ es.length ] = new EntityVo( "Π", "&Pi;", "&#928;", "&#x3a0;" );
        es[ es.length ] = new EntityVo( "Ρ", "&Rho;", "&#929;", "&#x3a1;" );
        es[ es.length ] = new EntityVo( "Σ", "&Sigma;", "&#931;", "&#x3a3;" );
        es[ es.length ] = new EntityVo( "Τ", "&Tau;", "&#932;", "&#x3a4;" );
        es[ es.length ] = new EntityVo( "Υ", "&Upsilon;", "&#933;", "&#x3a5;" );
        es[ es.length ] = new EntityVo( "Φ", "&Phi;", "&#934;", "&#x3a6;" );
        es[ es.length ] = new EntityVo( "Χ", "&Chi;", "&#935;", "&#x3a7;" );
        es[ es.length ] = new EntityVo( "Ψ", "&Psi;", "&#936;", "&#x3a8;" );
        es[ es.length ] = new EntityVo( "Ω", "&Omega;", "&#937;", "&#x3a9;" );
        es[ es.length ] = new EntityVo( "α", "&alpha;", "&#945;", "&#x3b1;" );
        es[ es.length ] = new EntityVo( "β", "&beta;", "&#946;", "&#x3b2;" );
        es[ es.length ] = new EntityVo( "γ", "&gamma;", "&#947;", "&#x3b3;" );
        es[ es.length ] = new EntityVo( "δ", "&delta;", "&#948;", "&#x3b4;" );
        es[ es.length ] = new EntityVo( "ε", "&epsilon;", "&#949;", "&#x3b5;" );
        es[ es.length ] = new EntityVo( "ζ", "&zeta;", "&#950;", "&#x3b6;" );
        es[ es.length ] = new EntityVo( "η", "&eta;", "&#951;", "&#x3b7;" );
        es[ es.length ] = new EntityVo( "θ", "&theta;", "&#952;", "&#x3b8;" );
        es[ es.length ] = new EntityVo( "ι", "&iota;", "&#953;", "&#x3b9;" );
        es[ es.length ] = new EntityVo( "κ", "&kappa;", "&#954;", "&#x3ba;" );
        es[ es.length ] = new EntityVo( "λ", "&lambda;", "&#955;", "&#x3bb;" );
        es[ es.length ] = new EntityVo( "μ", "&mu;", "&#956;", "&#x3bc;" );
        es[ es.length ] = new EntityVo( "ν", "&nu;", "&#957;", "&#x3bd;" );
        es[ es.length ] = new EntityVo( "ξ", "&xi;", "&#958;", "&#x3be;" );
        es[ es.length ] = new EntityVo( "ο", "&omicron;", "&#959;", "&#x3bf;" );
        es[ es.length ] = new EntityVo( "π", "&pi;", "&#960;", "&#x3c0;" );
        es[ es.length ] = new EntityVo( "ρ", "&rho;", "&#961;", "&#x3c1;" );
        es[ es.length ] = new EntityVo( "ς", "&sigmaf;", "&#962;", "&#x3c2;" );
        es[ es.length ] = new EntityVo( "σ", "&sigma;", "&#963;", "&#x3c3;" );
        es[ es.length ] = new EntityVo( "τ", "&tau;", "&#964;", "&#x3c4;" );
        es[ es.length ] = new EntityVo( "υ", "&upsilon;", "&#965;", "&#x3c5;" );
        es[ es.length ] = new EntityVo( "φ", "&phi;", "&#966;", "&#x3c6;" );
        es[ es.length ] = new EntityVo( "χ", "&chi;", "&#967;", "&#x3c7;" );
        es[ es.length ] = new EntityVo( "ψ", "&psi;", "&#968;", "&#x3c8;" );
        es[ es.length ] = new EntityVo( "ω", "&omega;", "&#969;", "&#x3c9;" );
        es[ es.length ] = new EntityVo( "ϑ", "&thetasym;", "&#977;", "&#x3d1;" );
        es[ es.length ] = new EntityVo( "ϒ", "&upsih;", "&#978;", "&#x3d2;" );
        es[ es.length ] = new EntityVo( "ϖ", "&piv;", "&#982;", "&#x3d6;" );
        es[ es.length ] = new EntityVo( " ", "&ensp;", "&#8194;", "&#x2002;" );
        es[ es.length ] = new EntityVo( " ", "&emsp;", "&#8195;", "&#x2003;" );
        es[ es.length ] = new EntityVo( " ", "&thinsp;", "&#8201;", "&#x2009;" );
        es[ es.length ] = new EntityVo( "‌", "&zwnj;", "&#8204;", "&#x200c;" );
        es[ es.length ] = new EntityVo( "‍", "&zwj;", "&#8205;", "&#x200d;" );
        es[ es.length ] = new EntityVo( "‎", "&lrm;", "&#8206;", "&#x200e;" );
        es[ es.length ] = new EntityVo( "‏", "&rlm;", "&#8207;", "&#x200f;" );
        es[ es.length ] = new EntityVo( "–", "&ndash;", "&#8211;", "&#x2013;" );
        es[ es.length ] = new EntityVo( "—", "&mdash;", "&#8212;", "&#x2014;" );
        es[ es.length ] = new EntityVo( "‘", "&lsquo;", "&#8216;", "&#x2018;" );
        es[ es.length ] = new EntityVo( "’", "&rsquo;", "&#8217;", "&#x2019;" );
        es[ es.length ] = new EntityVo( "‚", "&sbquo;", "&#8218;", "&#x201a;" );
        es[ es.length ] = new EntityVo( "“", "&ldquo;", "&#8220;", "&#x201c;" );
        es[ es.length ] = new EntityVo( "”", "&rdquo;", "&#8221;", "&#x201d;" );
        es[ es.length ] = new EntityVo( "„", "&bdquo;", "&#8222;", "&#x201e;" );
        es[ es.length ] = new EntityVo( "†", "&dagger;", "&#8224;", "&#x2020;" );
        es[ es.length ] = new EntityVo( "‡", "&Dagger;", "&#8225;", "&#x2021;" );
        es[ es.length ] = new EntityVo( "•", "&bull;", "&#8226;", "&#x2022;" );
        es[ es.length ] = new EntityVo( "…", "&hellip;", "&#8230;", "&#x2026;" );
        es[ es.length ] = new EntityVo( "‰", "&permil;", "&#8240;", "&#x2030;" );
        es[ es.length ] = new EntityVo( "′", "&prime;", "&#8242;", "&#x2032;" );
        es[ es.length ] = new EntityVo( "″", "&Prime;", "&#8243;", "&#x2033;" );
        es[ es.length ] = new EntityVo( "‹", "&lsaquo;", "&#8249;", "&#x2039;" );
        es[ es.length ] = new EntityVo( "›", "&rsaquo;", "&#8250;", "&#x203a;" );
        es[ es.length ] = new EntityVo( "‾", "&oline;", "&#8254;", "&#x203e;" );
        es[ es.length ] = new EntityVo( "⁄", "&frasl;", "&#8260;", "&#x2044;" );
        es[ es.length ] = new EntityVo( "€", "&euro;", "&#8364;", "&#x20ac;" );
        es[ es.length ] = new EntityVo( "ℑ", "&image;", "&#8465;", "&#x2111;" );
        es[ es.length ] = new EntityVo( "℘", "&weierp;", "&#8472;", "&#x2118;" );
        es[ es.length ] = new EntityVo( "ℜ", "&real;", "&#8476;", "&#x211c;" );
        es[ es.length ] = new EntityVo( "™", "&trade;", "&#8482;", "&#x2122;" );
        es[ es.length ] = new EntityVo( "ℵ", "&alefsym;", "&#8501;", "&#x2135;" );
        es[ es.length ] = new EntityVo( "←", "&larr;", "&#8592;", "&#x2190;" );
        es[ es.length ] = new EntityVo( "↑", "&uarr;", "&#8593;", "&#x2191;" );
        es[ es.length ] = new EntityVo( "→", "&rarr;", "&#8594;", "&#x2192;" );
        es[ es.length ] = new EntityVo( "↓", "&darr;", "&#8595;", "&#x2193;" );
        es[ es.length ] = new EntityVo( "↔", "&harr;", "&#8596;", "&#x2194;" );
        es[ es.length ] = new EntityVo( "↵", "&crarr;", "&#8629;", "&#x21b5;" );
        es[ es.length ] = new EntityVo( "⇐", "&lArr;", "&#8656;", "&#x21d0;" );
        es[ es.length ] = new EntityVo( "⇑", "&uArr;", "&#8657;", "&#x21d1;" );
        es[ es.length ] = new EntityVo( "⇒", "&rArr;", "&#8658;", "&#x21d2;" );
        es[ es.length ] = new EntityVo( "⇓", "&dArr;", "&#8659;", "&#x21d3;" );
        es[ es.length ] = new EntityVo( "⇔", "&hArr;", "&#8660;", "&#x21d4;" );
        es[ es.length ] = new EntityVo( "∀", "&forall;", "&#8704;", "&#x2200;" );
        es[ es.length ] = new EntityVo( "∂", "&part;", "&#8706;", "&#x2202;" );
        es[ es.length ] = new EntityVo( "∃", "&exist;", "&#8707;", "&#x2203;" );
        es[ es.length ] = new EntityVo( "∅", "&empty;", "&#8709;", "&#x2205;" );
        es[ es.length ] = new EntityVo( "∇", "&nabla;", "&#8711;", "&#x2207;" );
        es[ es.length ] = new EntityVo( "∈", "&isin;", "&#8712;", "&#x2208;" );
        es[ es.length ] = new EntityVo( "∉", "&notin;", "&#8713;", "&#x2209;" );
        es[ es.length ] = new EntityVo( "∋", "&ni;", "&#8715;", "&#x220b;" );
        es[ es.length ] = new EntityVo( "∏", "&prod;", "&#8719;", "&#x220f;" );
        es[ es.length ] = new EntityVo( "∑", "&sum;", "&#8721;", "&#x2211;" );
        es[ es.length ] = new EntityVo( "−", "&minus;", "&#8722;", "&#x2212;" );
        es[ es.length ] = new EntityVo( "∗", "&lowast;", "&#8727;", "&#x2217;" );
        es[ es.length ] = new EntityVo( "√", "&radic;", "&#8730;", "&#x221a;" );
        es[ es.length ] = new EntityVo( "∝", "&prop;", "&#8733;", "&#x221d;" );
        es[ es.length ] = new EntityVo( "∞", "&infin;", "&#8734;", "&#x221e;" );
        es[ es.length ] = new EntityVo( "∠", "&ang;", "&#8736;", "&#x2220;" );
        es[ es.length ] = new EntityVo( "∧", "&and;", "&#8743;", "&#x2227;" );
        es[ es.length ] = new EntityVo( "∨", "&or;", "&#8744;", "&#x2228;" );
        es[ es.length ] = new EntityVo( "∩", "&cap;", "&#8745;", "&#x2229;" );
        es[ es.length ] = new EntityVo( "∪", "&cup;", "&#8746;", "&#x222a;" );
        es[ es.length ] = new EntityVo( "∫", "&int;", "&#8747;", "&#x222b;" );
        es[ es.length ] = new EntityVo( "∴", "&there4;", "&#8756;", "&#x2234;" );
        es[ es.length ] = new EntityVo( "∼", "&sim;", "&#8764;", "&#x223c;" );
        es[ es.length ] = new EntityVo( "≅", "&cong;", "&#8773;", "&#x2245;" );
        es[ es.length ] = new EntityVo( "≈", "&asymp;", "&#8776;", "&#x2248;" );
        es[ es.length ] = new EntityVo( "≠", "&ne;", "&#8800;", "&#x2260;" );
        es[ es.length ] = new EntityVo( "≡", "&equiv;", "&#8801;", "&#x2261;" );
        es[ es.length ] = new EntityVo( "≤", "&le;", "&#8804;", "&#x2264;" );
        es[ es.length ] = new EntityVo( "≥", "&ge;", "&#8805;", "&#x2265;" );
        es[ es.length ] = new EntityVo( "⊂", "&sub;", "&#8834;", "&#x2282;" );
        es[ es.length ] = new EntityVo( "⊃", "&sup;", "&#8835;", "&#x2283;" );
        es[ es.length ] = new EntityVo( "⊄", "&nsub;", "&#8836;", "&#x2284;" );
        es[ es.length ] = new EntityVo( "⊆", "&sube;", "&#8838;", "&#x2286;" );
        es[ es.length ] = new EntityVo( "⊇", "&supe;", "&#8839;", "&#x2287;" );
        es[ es.length ] = new EntityVo( "⊕", "&oplus;", "&#8853;", "&#x2295;" );
        es[ es.length ] = new EntityVo( "⊗", "&otimes;", "&#8855;", "&#x2297;" );
        es[ es.length ] = new EntityVo( "⊥", "&perp;", "&#8869;", "&#x22a5;" );
        es[ es.length ] = new EntityVo( "⋅", "&sdot;", "&#8901;", "&#x22c5;" );
        es[ es.length ] = new EntityVo( "⌈", "&lceil;", "&#8968;", "&#x2308;" );
        es[ es.length ] = new EntityVo( "⌉", "&rceil;", "&#8969;", "&#x2309;" );
        es[ es.length ] = new EntityVo( "⌊", "&lfloor;", "&#8970;", "&#x230a;" );
        es[ es.length ] = new EntityVo( "⌋", "&rfloor;", "&#8971;", "&#x230b;" );
        es[ es.length ] = new EntityVo( "◊", "&loz;", "&#9674;", "&#x25ca;" );
        es[ es.length ] = new EntityVo( "♠", "&spades;", "&#9824;", "&#x2660;" );
        es[ es.length ] = new EntityVo( "♣", "&clubs;", "&#9827;", "&#x2663;" );
        es[ es.length ] = new EntityVo( "♥", "&hearts;", "&#9829;", "&#x2665;" );
        es[ es.length ] = new EntityVo( "♦", "&diams;", "&#9830;", "&#x2666;" );
        es[ es.length ] = new EntityVo( "⟨", "&lang;", "&#10216;", "&#x27e8;" );
        es[ es.length ] = new EntityVo( "⟩", "&rang;", "&#10217;", "&#x27e9;" );

        for ( i in 0...es.length ) {

            var htmlEntityVo : EntityVo = es[ i ];

            symbolMap.set( htmlEntityVo.symbol, htmlEntityVo );
            entityCodeMap.set( htmlEntityVo.htmlCode, htmlEntityVo );
            decimalCodeMap.set( htmlEntityVo.decimalCode, htmlEntityVo );
            hexCodeMap.set( htmlEntityVo.hexCode, htmlEntityVo );
        }
    }
}

class EntityVo {

    public var symbol : String;
    public var htmlCode : String;
    public var decimalCode : String;
    public var hexCode : String;

    public inline function new( symbol : String, htmlCode : String, decimalCode : String, hexCode : String ) {

        this.symbol = symbol;
        this.htmlCode = htmlCode;
        this.decimalCode = decimalCode;
        this.hexCode = hexCode;
    }
}
