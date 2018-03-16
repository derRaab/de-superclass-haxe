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
	`AsciiUtil` provides simple helper methods to work with ascii strings.
	Especially helpfull for handling accents, so this is strongly influenced by the wordpress approach:
	@see https://developer.wordpress.org/reference/functions/remove_accents/ for little more information
**/

class AsciiUtil {

	private static var _accentMap : Map<String,String>;

	public static function hasAccents( string : String ) : Bool {

		if ( StringUtil.hasLength( string ) ) {

			var map : Map<String,String> = _getAccentsMap();
			for ( i in 0...string.length ) {

				var substring : String = string.charAt( i );
				if ( map.exists( substring ) ) {

					return true;
				}
			}
		}
		return false;
	}

	public static function removeAccents( string : String ) : String {

		if ( ! hasAccents( string ) ) return string;

		var map : Map<String,String> = _getAccentsMap();

		for ( key in map.keys() ) {

			if ( string.indexOf( key ) != -1 ) {

				string = string.split( key ).join( map.get( key ) );
			}
		}

		return string;
	}

	private static function _createAccentsMap() : Map<String,String> {

		var map : Map<String,String> = new Map<String,String>();

		// On some platforms (e.g. nodejs) this is found alone
		map.set( "̈", "" );

		// Decompositions for Latin-1 Supplement
		map.set( "ª", "a" );
		map.set( "º", "o" );
		map.set( "À", "A" );
		map.set( "Á", "A" );
		map.set( "Â", "A" );
		map.set( "Ã", "A" );
		map.set( "Ä", "A" );
		map.set( "Å", "A" );
		map.set( "Æ", "AE" );
		map.set( "Ç", "C" );
		map.set( "È", "E" );
		map.set( "É", "E" );
		map.set( "Ê", "E" );
		map.set( "Ë", "E" );
		map.set( "Ì", "I" );
		map.set( "Í", "I" );
		map.set( "Î", "I" );
		map.set( "Ï", "I" );
		map.set( "Ð", "D" );
		map.set( "Ñ", "N" );
		map.set( "Ò", "O" );
		map.set( "Ó", "O" );
		map.set( "Ô", "O" );
		map.set( "Õ", "O" );
		map.set( "Ö", "O" );
		map.set( "Ù", "U" );
		map.set( "Ú", "U" );
		map.set( "Û", "U" );
		map.set( "Ü", "U" );
		map.set( "Ý", "Y" );
		map.set( "Þ", "TH" );
		map.set( "ß", "s" );
		map.set( "à", "a" );
		map.set( "á", "a" );
		map.set( "â", "a" );
		map.set( "ã", "a" );
		map.set( "ä", "a" );
		map.set( "å", "a" );
		map.set( "æ", "ae" );
		map.set( "ç", "c" );
		map.set( "è", "e" );
		map.set( "é", "e" );
		map.set( "ê", "e" );
		map.set( "ë", "e" );
		map.set( "ì", "i" );
		map.set( "í", "i" );
		map.set( "î", "i" );
		map.set( "ï", "i" );
		map.set( "ð", "d" );
		map.set( "ñ", "n" );
		map.set( "ò", "o" );
		map.set( "ó", "o" );
		map.set( "ô", "o" );
		map.set( "õ", "o" );
		map.set( "ö", "o" );
		map.set( "ø", "o" );
		map.set( "ù", "u" );
		map.set( "ú", "u" );
		map.set( "û", "u" );
		map.set( "ü", "u" );
		map.set( "ý", "y" );
		map.set( "þ", "th" );
		map.set( "ÿ", "y" );
		map.set( "Ø", "O" );

		// Decompositions for Latin Extended-A
		map.set( "Ā", "A" );
		map.set( "ā", "a" );
		map.set( "Ă", "A" );
		map.set( "ă", "a" );
		map.set( "Ą", "A" );
		map.set( "ą", "a" );
		map.set( "Ć", "C" );
		map.set( "ć", "c" );
		map.set( "Ĉ", "C" );
		map.set( "ĉ", "c" );
		map.set( "Ċ", "C" );
		map.set( "ċ", "c" );
		map.set( "Č", "C" );
		map.set( "č", "c" );
		map.set( "Ď", "D" );
		map.set( "ď", "d" );
		map.set( "Đ", "D" );
		map.set( "đ", "d" );
		map.set( "Ē", "E" );
		map.set( "ē", "e" );
		map.set( "Ĕ", "E" );
		map.set( "ĕ", "e" );
		map.set( "Ė", "E" );
		map.set( "ė", "e" );
		map.set( "Ę", "E" );
		map.set( "ę", "e" );
		map.set( "Ě", "E" );
		map.set( "ě", "e" );
		map.set( "Ĝ", "G" );
		map.set( "ĝ", "g" );
		map.set( "Ğ", "G" );
		map.set( "ğ", "g" );
		map.set( "Ġ", "G" );
		map.set( "ġ", "g" );
		map.set( "Ģ", "G" );
		map.set( "ģ", "g" );
		map.set( "Ĥ", "H" );
		map.set( "ĥ", "h" );
		map.set( "Ħ", "H" );
		map.set( "ħ", "h" );
		map.set( "Ĩ", "I" );
		map.set( "ĩ", "i" );
		map.set( "Ī", "I" );
		map.set( "ī", "i" );
		map.set( "Ĭ", "I" );
		map.set( "ĭ", "i" );
		map.set( "Į", "I" );
		map.set( "į", "i" );
		map.set( "İ", "I" );
		map.set( "ı", "i" );
		map.set( "Ĳ", "IJ" );
		map.set( "ĳ", "ij" );
		map.set( "Ĵ", "J" );
		map.set( "ĵ", "j" );
		map.set( "Ķ", "K" );
		map.set( "ķ", "k" );
		map.set( "ĸ", "k" );
		map.set( "Ĺ", "L" );
		map.set( "ĺ", "l" );
		map.set( "Ļ", "L" );
		map.set( "ļ", "l" );
		map.set( "Ľ", "L" );
		map.set( "ľ", "l" );
		map.set( "Ŀ", "L" );
		map.set( "ŀ", "l" );
		map.set( "Ł", "L" );
		map.set( "ł", "l" );
		map.set( "Ń", "N" );
		map.set( "ń", "n" );
		map.set( "Ņ", "N" );
		map.set( "ņ", "n" );
		map.set( "Ň", "N" );
		map.set( "ň", "n" );
		map.set( "ŉ", "N" );
		map.set( "Ŋ", "n" );
		map.set( "ŋ", "N" );
		map.set( "Ō", "O" );
		map.set( "ō", "o" );
		map.set( "Ŏ", "O" );
		map.set( "ŏ", "o" );
		map.set( "Ő", "O" );
		map.set( "ő", "o" );
		map.set( "Œ", "OE" );
		map.set( "œ", "oe" );
		map.set( "Ŕ", "R" );
		map.set( "ŕ", "r" );
		map.set( "Ŗ", "R" );
		map.set( "ŗ", "r" );
		map.set( "Ř", "R" );
		map.set( "ř", "r" );
		map.set( "Ś", "S" );
		map.set( "ś", "s" );
		map.set( "Ŝ", "S" );
		map.set( "ŝ", "s" );
		map.set( "Ş", "S" );
		map.set( "ş", "s" );
		map.set( "Š", "S" );
		map.set( "š", "s" );
		map.set( "Ţ", "T" );
		map.set( "ţ", "t" );
		map.set( "Ť", "T" );
		map.set( "ť", "t" );
		map.set( "Ŧ", "T" );
		map.set( "ŧ", "t" );
		map.set( "Ũ", "U" );
		map.set( "ũ", "u" );
		map.set( "Ū", "U" );
		map.set( "ū", "u" );
		map.set( "Ŭ", "U" );
		map.set( "ŭ", "u" );
		map.set( "Ů", "U" );
		map.set( "ů", "u" );
		map.set( "Ű", "U" );
		map.set( "ű", "u" );
		map.set( "Ų", "U" );
		map.set( "ų", "u" );
		map.set( "Ŵ", "W" );
		map.set( "ŵ", "w" );
		map.set( "Ŷ", "Y" );
		map.set( "ŷ", "y" );
		map.set( "Ÿ", "Y" );
		map.set( "Ź", "Z" );
		map.set( "ź", "z" );
		map.set( "Ż", "Z" );
		map.set( "ż", "z" );
		map.set( "Ž", "Z" );
		map.set( "ž", "z" );
		map.set( "ſ", "s" );

		// Decompositions for Latin Extended-B
		map.set( "Ș", "S" );
		map.set( "ș", "s" );
		map.set( "Ț", "T" );
		map.set( "ț", "t" );

		// Euro Sign
		map.set( "€", "E" );

		// GBP (Pound) Sign
		map.set( "£", "" );

		// Vowels with diacritic (Vietnamese)
		// unmarked
		map.set( "Ơ", "O" );
		map.set( "ơ", "o" );
		map.set( "Ư", "U" );
		map.set( "ư", "u" );

		// grave accent
		map.set( "Ầ", "A" );
		map.set( "ầ", "a" );
		map.set( "Ằ", "A" );
		map.set( "ằ", "a" );
		map.set( "Ề", "E" );
		map.set( "ề", "e" );
		map.set( "Ồ", "O" );
		map.set( "ồ", "o" );
		map.set( "Ờ", "O" );
		map.set( "ờ", "o" );
		map.set( "Ừ", "U" );
		map.set( "ừ", "u" );
		map.set( "Ỳ", "Y" );
		map.set( "ỳ", "y" );

		// hook
		map.set( "Ả", "A" );
		map.set( "ả", "a" );
		map.set( "Ẩ", "A" );
		map.set( "ẩ", "a" );
		map.set( "Ẳ", "A" );
		map.set( "ẳ", "a" );
		map.set( "Ẻ", "E" );
		map.set( "ẻ", "e" );
		map.set( "Ể", "E" );
		map.set( "ể", "e" );
		map.set( "Ỉ", "I" );
		map.set( "ỉ", "i" );
		map.set( "Ỏ", "O" );
		map.set( "ỏ", "o" );
		map.set( "Ổ", "O" );
		map.set( "ổ", "o" );
		map.set( "Ở", "O" );
		map.set( "ở", "o" );
		map.set( "Ủ", "U" );
		map.set( "ủ", "u" );
		map.set( "Ử", "U" );
		map.set( "ử", "u" );
		map.set( "Ỷ", "Y" );
		map.set( "ỷ", "y" );

		// tilde
		map.set( "Ẫ", "A" );
		map.set( "ẫ", "a" );
		map.set( "Ẵ", "A" );
		map.set( "ẵ", "a" );
		map.set( "Ẽ", "E" );
		map.set( "ẽ", "e" );
		map.set( "Ễ", "E" );
		map.set( "ễ", "e" );
		map.set( "Ỗ", "O" );
		map.set( "ỗ", "o" );
		map.set( "Ỡ", "O" );
		map.set( "ỡ", "o" );
		map.set( "Ữ", "U" );
		map.set( "ữ", "u" );
		map.set( "Ỹ", "Y" );
		map.set( "ỹ", "y" );

		// acute accent
		map.set( "Ấ", "A" );
		map.set( "ấ", "a" );
		map.set( "Ắ", "A" );
		map.set( "ắ", "a" );
		map.set( "Ế", "E" );
		map.set( "ế", "e" );
		map.set( "Ố", "O" );
		map.set( "ố", "o" );
		map.set( "Ớ", "O" );
		map.set( "ớ", "o" );
		map.set( "Ứ", "U" );
		map.set( "ứ", "u" );

		// dot below
		map.set( "Ạ", "A" );
		map.set( "ạ", "a" );
		map.set( "Ậ", "A" );
		map.set( "ậ", "a" );
		map.set( "Ặ", "A" );
		map.set( "ặ", "a" );
		map.set( "Ẹ", "E" );
		map.set( "ẹ", "e" );
		map.set( "Ệ", "E" );
		map.set( "ệ", "e" );
		map.set( "Ị", "I" );
		map.set( "ị", "i" );
		map.set( "Ọ", "O" );
		map.set( "ọ", "o" );
		map.set( "Ộ", "O" );
		map.set( "ộ", "o" );
		map.set( "Ợ", "O" );
		map.set( "ợ", "o" );
		map.set( "Ụ", "U" );
		map.set( "ụ", "u" );
		map.set( "Ự", "U" );
		map.set( "ự", "u" );
		map.set( "Ỵ", "Y" );
		map.set( "ỵ", "y" );

		// Vowels with diacritic (Chinese; Hanyu Pinyin)
		map.set( "ɑ", "a" );

		// macron
		map.set( "Ǖ", "U" );
		map.set( "ǖ", "u" );

		// acute accent
		map.set( "Ǘ", "U" );
		map.set( "ǘ", "u" );

		// caron
		map.set( "Ǎ", "A" );
		map.set( "ǎ", "a" );
		map.set( "Ǐ", "I" );
		map.set( "ǐ", "i" );
		map.set( "Ǒ", "O" );
		map.set( "ǒ", "o" );
		map.set( "Ǔ", "U" );
		map.set( "ǔ", "u" );
		map.set( "Ǚ", "U" );
		map.set( "ǚ", "u" );

		// grave accent
		map.set( "Ǜ", "U" );
		map.set( "ǜ", "u" );

		return map;
	}

	private static function _getAccentsMap() : Map<String,String> {

		var map : Map<String,String> = _accentMap;
		if ( map == null ) {

			_accentMap = map = _createAccentsMap();
		}
		return map;
	}
}