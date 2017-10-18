package de.superclass.haxe.http;

/**
	`HttpStatus` holds all official codes as listed @see https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
**/
class HttpStatus {

    public static inline var INFO_100_CONTINUE : Int = 100;
    public static inline var INFO_101_SWITCHING_PROTOCOLS : Int = 101;
    public static inline var INFO_102_PROCESSING : Int = 102;

    public static inline var SUCCESS_200_OK : Int = 200;
    public static inline var SUCCESS_201_CREATED : Int = 201;
    public static inline var SUCCESS_202_ACCEPTED : Int = 202;
    public static inline var SUCCESS_203_ON_AUTHORITATIVE_INFORMATION : Int = 203;
    public static inline var SUCCESS_204_NO_CONTENT : Int = 204;
    public static inline var SUCCESS_205_RESET_CONTENT : Int = 205;
    public static inline var SUCCESS_206_PARTIAL_CONTENT : Int = 206;
    public static inline var SUCCESS_207_MULTI_STATUS : Int = 207;
    public static inline var SUCCESS_208_ALREADY_REPORTED : Int = 208;
    public static inline var SUCCESS_226_IM_USED : Int = 226;

    public static inline var REDIRECTION_300_MULTIPLE_PURPOSES : Int = 300;
    public static inline var REDIRECTION_301_MOVED_PERMANENTLY : Int = 301;
    public static inline var REDIRECTION_302_FOUND : Int = 302;
    public static inline var REDIRECTION_303_SEE_OTHER : Int = 303;
    public static inline var REDIRECTION_304_NOT_MODIFIED : Int = 304;
    public static inline var REDIRECTION_305_USE_PROXY : Int = 305;
    public static inline var REDIRECTION_306_SWITCH_PROXY : Int = 306;
    public static inline var REDIRECTION_307_TEMPORARY_REDIRECT : Int = 307;
    public static inline var REDIRECTION_308_PERMANENTY_REDIRECT : Int = 308;

    public static inline var CLIENT_ERROR_400_BAD_REQUEST             : Int = 400;
    public static inline var CLIENT_ERROR_401_UNAUTHORIZED : Int = 401;
    public static inline var CLIENT_ERROR_402_PAYMENT_REQUIRED : Int = 402;
    public static inline var CLIENT_ERROR_403_FORBIDDEN : Int = 403;
    public static inline var CLIENT_ERROR_404_NOT_FOUND : Int = 404;
    public static inline var CLIENT_ERROR_405_METHOD_NOT_ALLOWED : Int = 405;
    public static inline var CLIENT_ERROR_406_NOT_ACCEPTABLE : Int = 406;
    public static inline var CLIENT_ERROR_407_PROXY_AUTHENTICATION_REQUIRED : Int = 407;
    public static inline var CLIENT_ERROR_408_REQUEST_TIMEOUT : Int = 408;
    public static inline var CLIENT_ERROR_409_CONFLICT : Int = 409;
    public static inline var CLIENT_ERROR_410_GONE : Int = 410;
    public static inline var CLIENT_ERROR_411_LENGTH_REQUIRED : Int = 411;
    public static inline var CLIENT_ERROR_412_PRECONDITION_FAILED : Int = 412;
    public static inline var CLIENT_ERROR_413_PAYLOAD_TOO_LARGE : Int = 413;
    public static inline var CLIENT_ERROR_414_URI_TOO_LONG : Int = 414;
    public static inline var CLIENT_ERROR_415_UNSUPPORTED_MEDIA_TYPE : Int = 415;
    public static inline var CLIENT_ERROR_416_RANGE_NOT_SATISFIABLE : Int = 416;
    public static inline var CLIENT_ERROR_417_EXPECTATION_FAILED : Int = 417;
    public static inline var CLIENT_ERROR_418_IM_A_TEAPOT : Int = 418;
    public static inline var CLIENT_ERROR_421_MISDIRECTED_REQUEST : Int = 421;
    public static inline var CLIENT_ERROR_422_UNPROCESSABLE_ENTITY : Int = 422;
    public static inline var CLIENT_ERROR_423_LOCKED : Int = 423;
    public static inline var CLIENT_ERROR_424_FAILED_DEPENDENCY : Int = 424;
    public static inline var CLIENT_ERROR_426_UPGRADE_REQUIRED : Int = 426;
    public static inline var CLIENT_ERROR_428_PRECONDITION_REQUIRED : Int = 428;
    public static inline var CLIENT_ERROR_429_TOO_MANY_REQUESTS : Int = 429;
    public static inline var CLIENT_ERROR_431_REQUEST_HEADER_FIELDS_TOO_LARGE : Int = 431;
    public static inline var CLIENT_ERROR_451_UNAVAILABLE_FOR_LEGAL_REASONS : Int = 451;

    public static inline var SERVER_ERROR_500_INTERNAL_SERVER_ERROR : Int = 500;
    public static inline var SERVER_ERROR_501_NOT_IMPLEMENTED : Int = 501;
    public static inline var SERVER_ERROR_502_BAD_GATEWAY : Int = 502;
    public static inline var SERVER_ERROR_503_SERVICE_UNAVAILABLE : Int = 503;
    public static inline var SERVER_ERROR_504_GATEWAY_TIMEOUT : Int = 504;
    public static inline var SERVER_ERROR_505_HTTP_VERSION_NOT_SUPPORTED : Int = 505;
    public static inline var SERVER_ERROR_506_VARIANT_ALSO_NEGOTIATES : Int = 506;
    public static inline var SERVER_ERROR_507_INSUFFICIENT_STORAGE : Int = 507;
    public static inline var SERVER_ERROR_508_LOOP_DETECTED : Int = 508;
    public static inline var SERVER_ERROR_510_NOT_EXTENDED : Int = 510;
    public static inline var SERVER_ERROR_511_NETWORK_AUTHENTICATION_REQUIRED : Int = 511;

    public static function isInfo( status : Int ) : Bool {

        return ( INFO_100_CONTINUE <= status && status < SUCCESS_200_OK );
    }

    public static function isSuccess( status : Int ) : Bool {

        return ( SUCCESS_200_OK <= status && status < REDIRECTION_300_MULTIPLE_PURPOSES );
    }

    public static function isRedirection( status : Int ) : Bool {

        return ( REDIRECTION_300_MULTIPLE_PURPOSES <= status && status < CLIENT_ERROR_400_BAD_REQUEST );
    }

    public static function isClientError( status : Int ) : Bool {

        return ( CLIENT_ERROR_400_BAD_REQUEST <= status && status < SERVER_ERROR_500_INTERNAL_SERVER_ERROR );
    }

    public static function isServerError( status : Int ) : Bool {

        return ( SERVER_ERROR_500_INTERNAL_SERVER_ERROR <= status && status < 600 );
    }
}
