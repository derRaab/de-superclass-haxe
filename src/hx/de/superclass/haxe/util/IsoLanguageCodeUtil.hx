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
	`IsoLanguageCodeUtil` provides simple helper methods to work with iso language values.
	@see https://www.w3schools.com/tags/ref_language_codes.asp
**/
class IsoLanguageCodeUtil {

    private static var _codeLabelMap : Map<String,String>;
    private static var _labelCodeList : Array<String>;

    public static function isValidCode( code : String ) : Bool {

        var codeLabelMap : Map<String,String> = _getCodeLabelMap();
        return codeLabelMap.exists( code );
    }

    public static function getLabel( code : String ) : String {

        var codeLabelMap : Map<String,String> = _getCodeLabelMap();
        return codeLabelMap.get( code );
    }

    private static function _getCodeLabelMap() : Map<String,String> {

        var codeLabelMap : Map<String,String> = _codeLabelMap;
        if ( codeLabelMap == null ) {

            _codeLabelMap = codeLabelMap = _createCodeLabelMap();
        }
        return codeLabelMap;
    }

    private static function _createCodeLabelMap() : Map<String,String> {

        var codeLabelMap : Map<String,String> = new Map();

        var labelCodeList : Array<String> = _getLabelCodeList();
        var i : Int = 0;
        var c : Int = labelCodeList.length;
        while ( i < c ) {

            var label : String = labelCodeList[ i ];
            var code : String = labelCodeList[ i + 1 ];

            codeLabelMap.set( code, label );

            i += 2;
        }

        return codeLabelMap;
    }

    private static function _getLabelCodeList() : Array<String> {

        var labelCodeList : Array<String> = _labelCodeList;
        if ( labelCodeList == null ) {

            _labelCodeList = labelCodeList = _createLabelCodeList();
        }
        return labelCodeList;
    }

    private static function _createLabelCodeList() : Array<String> {

        // see https://www.w3schools.com/tags/ref_language_codes.asp
        var labelCodeList : Array<String> = [
            "Abkhazian", "ab",
            "Afar", "aa",
            "Afrikaans", "af",
            "Akan", "ak",
            "Albanian", "sq",
            "Amharic", "am",
            "Arabic", "ar",
            "Aragonese", "an",
            "Armenian", "hy",
            "Assamese", "as",
            "Avaric", "av",
            "Avestan", "ae",
            "Aymara", "ay",
            "Azerbaijani", "az",
            "Bambara", "bm",
            "Bashkir", "ba",
            "Basque", "eu",
            "Belarusian", "be",
            "Bengali (Bangla)", "bn",
            "Bihari", "bh",
            "Bislama", "bi",
            "Bosnian", "bs",
            "Breton", "br",
            "Bulgarian", "bg",
            "Burmese", "my",
            "Catalan", "ca",
            "Chamorro", "ch",
            "Chechen", "ce",
            "Chichewa, Chewa, Nyanja", "ny",
            "Chinese", "zh",
            "Chinese (Simplified)", "zh-Hans",
            "Chinese (Traditional)", "zh-Hant",
            "Chuvash", "cv",
            "Cornish", "kw",
            "Corsican", "co",
            "Cree", "cr",
            "Croatian", "hr",
            "Czech", "cs",
            "Danish", "da",
            "Divehi, Dhivehi, Maldivian", "dv",
            "Dutch", "nl",
            "Dzongkha", "dz",
            "English", "en",
            "Esperanto", "eo",
            "Estonian", "et",
            "Ewe", "ee",
            "Faroese", "fo",
            "Fijian", "fj",
            "Finnish", "fi",
            "French", "fr",
            "Fula, Fulah, Pulaar, Pular", "ff",
            "Galician", "gl",
            "Gaelic (Scottish)", "gd",
            "Gaelic (Manx)", "gv",
            "Georgian", "ka",
            "German", "de",
            "Greek", "el",
            "Greenlandic", "kl",
            "Guarani", "gn",
            "Gujarati", "gu",
            "Haitian Creole", "ht",
            "Hausa", "ha",
            "Hebrew", "he",
            "Herero", "hz",
            "Hindi", "hi",
            "Hiri Motu", "ho",
            "Hungarian", "hu",
            "Icelandic", "is",
            "Ido", "io",
            "Igbo", "ig",
            "Indonesian (id)", "id",
            "Indonesian (in)", "in",
            "Interlingua", "ia",
            "Interlingue", "ie",
            "Inuktitut", "iu",
            "Inupiak", "ik",
            "Irish", "ga",
            "Italian", "it",
            "Japanese", "ja",
            "Javanese", "jv",
            "Kalaallisut, Greenlandic", "kl",
            "Kannada", "kn",
            "Kanuri", "kr",
            "Kashmiri", "ks",
            "Kazakh", "kk",
            "Khmer", "km",
            "Kikuyu", "ki",
            "Kinyarwanda (Rwanda)", "rw",
            "Kirundi", "rn",
            "Kyrgyz", "ky",
            "Komi", "kv",
            "Kongo", "kg",
            "Korean", "ko",
            "Kurdish", "ku",
            "Kwanyama", "kj",
            "Lao", "lo",
            "Latin", "la",
            "Latvian (Lettish)", "lv",
            "Limburgish ( Limburger)", "li",
            "Lingala", "ln",
            "Lithuanian", "lt",
            "Luga-Katanga", "lu",
            "Luganda, Ganda", "lg",
            "Luxembourgish", "lb",
            "Manx", "gv",
            "Macedonian", "mk",
            "Malagasy", "mg",
            "Malay", "ms",
            "Malayalam", "ml",
            "Maltese", "mt",
            "Maori", "mi",
            "Marathi", "mr",
            "Marshallese", "mh",
            "Moldavian", "mo",
            "Mongolian", "mn",
            "Nauru", "na",
            "Navajo", "nv",
            "Ndonga", "ng",
            "Northern Ndebele", "nd",
            "Nepali", "ne",
            "Norwegian", "no",
            "Norwegian bokmål", "nb",
            "Norwegian nynorsk", "nn",
            "Nuosu", "ii",
            "Occitan", "oc",
            "Ojibwe", "oj",
            "Old Church Slavonic, Old Bulgarian", "cu",
            "Oriya", "or",
            "Oromo (Afaan Oromo)", "om",
            "Ossetian", "os",
            "Pāli", "pi",
            "Pashto, Pushto", "ps",
            "Persian (Farsi)", "fa",
            "Polish", "pl",
            "Portuguese", "pt",
            "Punjabi (Eastern)", "pa",
            "Quechua", "qu",
            "Romansh", "rm",
            "Romanian", "ro",
            "Russian", "ru",
            "Sami", "se",
            "Samoan", "sm",
            "Sango", "sg",
            "Sanskrit", "sa",
            "Serbian", "sr",
            "Serbo-Croatian", "sh",
            "Sesotho", "st",
            "Setswana", "tn",
            "Shona", "sn",
            "Sichuan Yi", "ii",
            "Sindhi", "sd",
            "Sinhalese", "si",
            "Siswati", "ss",
            "Slovak", "sk",
            "Slovenian", "sl",
            "Somali", "so",
            "Southern Ndebele", "nr",
            "Spanish", "es",
            "Sundanese", "su",
            "Swahili (Kiswahili)", "sw",
            "Swati", "ss",
            "Swedish", "sv",
            "Tagalog", "tl",
            "Tahitian", "ty",
            "Tajik", "tg",
            "Tamil", "ta",
            "Tatar", "tt",
            "Telugu", "te",
            "Thai", "th",
            "Tibetan", "bo",
            "Tigrinya", "ti",
            "Tonga", "to",
            "Tsonga", "ts",
            "Turkish", "tr",
            "Turkmen", "tk",
            "Twi", "tw",
            "Uyghur", "ug",
            "Ukrainian", "uk",
            "Urdu", "ur",
            "Uzbek", "uz",
            "Venda", "ve",
            "Vietnamese", "vi",
            "Volapük", "vo",
            "Wallon", "wa",
            "Welsh", "cy",
            "Wolof", "wo",
            "Western Frisian", "fy",
            "Xhosa", "xh",
            "Yiddish (yi)", "yi",
            "Yiddish (ji)", "ji",
            "Yoruba", "yo",
            "Zhuang, Chuang", "za",
            "Zulu", "zu"
            ];

        return labelCodeList;
    }
}
