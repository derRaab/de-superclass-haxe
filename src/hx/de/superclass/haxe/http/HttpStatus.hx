package de.superclass.haxe.http;

/**
	`HttpStatus` holds all official codes as listed @see https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
**/
class HttpStatus {

    public static inline var INFO_100_CONTINUE (default, never) : Int = 100;
    public static inline var INFO_101_SWITCHING_PROTOCOLS (default, never) : Int = 101;
    public static inline var INFO_102_PROCESSING (default, never) : Int = 102;

    public static inline var SUCCESS_200_OK (default, never) : Int = 200;
    public static inline var SUCCESS_201_CREATED (default, never) : Int = 201;
    public static inline var SUCCESS_202_ACCEPTED (default, never) : Int = 202;
    public static inline var SUCCESS_203_ON_AUTHORITATIVE_INFORMATION (default, never) : Int = 203;
    public static inline var SUCCESS_204_NO_CONTENT (default, never) : Int = 204;
    public static inline var SUCCESS_205_RESET_CONTENT (default, never) : Int = 205;
    public static inline var SUCCESS_206_PARTIAL_CONTENT (default, never) : Int = 206;
    public static inline var SUCCESS_207_MULTI_STATUS (default, never) : Int = 207;
    public static inline var SUCCESS_208_ALREADY_REPORTED (default, never) : Int = 208;
    public static inline var SUCCESS_226_IM_USED (default, never) : Int = 226;

    public static inline var REDIRECTION_300_MULTIPLE_PURPOSES (default, never) : Int = 300;
    public static inline var REDIRECTION_301_MOVED_PERMANENTLY (default, never) : Int = 301;
    public static inline var REDIRECTION_302_FOUND (default, never) : Int = 302;
    public static inline var REDIRECTION_303_SEE_OTHER (default, never) : Int = 303;
    public static inline var REDIRECTION_304_NOT_MODIFIED (default, never) : Int = 304;
    public static inline var REDIRECTION_305_USE_PROXY (default, never) : Int = 305;
    public static inline var REDIRECTION_306_SWITCH_PROXY (default, never) : Int = 306;
    public static inline var REDIRECTION_307_TEMPORARY_REDIRECT (default, never) : Int = 307;
    public static inline var REDIRECTION_308_PERMANENTY_REDIRECT (default, never) : Int = 308;

    public static inline var CLIENT_ERROR_400_BAD_REQUEST             (default, never) : Int = 400;
    public static inline var CLIENT_ERROR_401_UNAUTHORIZED (default, never) : Int = 401;
    public static inline var CLIENT_ERROR_402_PAYMENT_REQUIRED (default, never) : Int = 402;
    public static inline var CLIENT_ERROR_403_FORBIDDEN (default, never) : Int = 403;
    public static inline var CLIENT_ERROR_404_NOT_FOUND (default, never) : Int = 404;
    public static inline var CLIENT_ERROR_405_METHOD_NOT_ALLOWED (default, never) : Int = 405;
    public static inline var CLIENT_ERROR_406_NOT_ACCEPTABLE (default, never) : Int = 406;
    public static inline var CLIENT_ERROR_407_PROXY_AUTHENTICATION_REQUIRED (default, never) : Int = 407;
    public static inline var CLIENT_ERROR_408_REQUEST_TIMEOUT (default, never) : Int = 408;
    public static inline var CLIENT_ERROR_409_CONFLICT (default, never) : Int = 409;
    public static inline var CLIENT_ERROR_410_GONE (default, never) : Int = 410;
    public static inline var CLIENT_ERROR_411_LENGTH_REQUIRED (default, never) : Int = 411;
    public static inline var CLIENT_ERROR_412_PRECONDITION_FAILED (default, never) : Int = 412;
    public static inline var CLIENT_ERROR_413_PAYLOAD_TOO_LARGE (default, never) : Int = 413;
    public static inline var CLIENT_ERROR_414_URI_TOO_LONG (default, never) : Int = 414;
    public static inline var CLIENT_ERROR_415_UNSUPPORTED_MEDIA_TYPE (default, never) : Int = 415;
    public static inline var CLIENT_ERROR_416_RANGE_NOT_SATISFIABLE (default, never) : Int = 416;
    public static inline var CLIENT_ERROR_417_EXPECTATION_FAILED (default, never) : Int = 417;
    public static inline var CLIENT_ERROR_418_IM_A_TEAPOT (default, never) : Int = 418;
    public static inline var CLIENT_ERROR_421_MISDIRECTED_REQUEST (default, never) : Int = 421;
    public static inline var CLIENT_ERROR_422_UNPROCESSABLE_ENTITY (default, never) : Int = 422;
    public static inline var CLIENT_ERROR_423_LOCKED (default, never) : Int = 423;
    public static inline var CLIENT_ERROR_424_FAILED_DEPENDENCY (default, never) : Int = 424;
    public static inline var CLIENT_ERROR_426_UPGRADE_REQUIRED (default, never) : Int = 426;
    public static inline var CLIENT_ERROR_428_PRECONDITION_REQUIRED (default, never) : Int = 428;
    public static inline var CLIENT_ERROR_429_TOO_MANY_REQUESTS (default, never) : Int = 429;
    public static inline var CLIENT_ERROR_431_REQUEST_HEADER_FIELDS_TOO_LARGE (default, never) : Int = 431;
    public static inline var CLIENT_ERROR_451_UNAVAILABLE_FOR_LEGAL_REASONS (default, never) : Int = 451;

    public static inline var SERVER_ERROR_500_INTERNAL_SERVER_ERROR (default, never) : Int = 500;
    public static inline var SERVER_ERROR_501_NOT_IMPLEMENTED (default, never) : Int = 501;
    public static inline var SERVER_ERROR_502_BAD_GATEWAY (default, never) : Int = 502;
    public static inline var SERVER_ERROR_503_SERVICE_UNAVAILABLE (default, never) : Int = 503;
    public static inline var SERVER_ERROR_504_GATEWAY_TIMEOUT (default, never) : Int = 504;
    public static inline var SERVER_ERROR_505_HTTP_VERSION_NOT_SUPPORTED (default, never) : Int = 505;
    public static inline var SERVER_ERROR_506_VARIANT_ALSO_NEGOTIATES (default, never) : Int = 506;
    public static inline var SERVER_ERROR_507_INSUFFICIENT_STORAGE (default, never) : Int = 507;
    public static inline var SERVER_ERROR_508_LOOP_DETECTED (default, never) : Int = 508;
    public static inline var SERVER_ERROR_510_NOT_EXTENDED (default, never) : Int = 510;
    public static inline var SERVER_ERROR_511_NETWORK_AUTHENTICATION_REQUIRED (default, never) : Int = 511;
}
