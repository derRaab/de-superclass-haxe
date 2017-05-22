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

package de.superclass.haxe.flash.io;

import de.superclass.haxe.util.PosInfosUtil;
import de.superclass.haxe.io.ILogger;
import de.superclass.haxe.util.DateUtil;
import de.superclass.haxe.util.ReflectUtil;
import flash.data.SQLConnection;
import flash.data.SQLStatement;
import flash.filesystem.File;

/**
	`SqliteLogger` maps the logger api to Adobe Air sqlite output.
**/
class SqliteLogger implements ILogger {

    private static var _SQL_CREATE : String = "
        CREATE TABLE IF NOT EXISTS log (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            date TEXT NOT NULL DEFAULT '',
            type TEXT NOT NULL DEFAULT '',
            message TEXT NOT NULL DEFAULT '',
            version TEXT NOT NULL DEFAULT '',
            position TEXT NOT NULL DEFAULT ''
        );";

    private static var _SQL_INJECT : String = "
        INSERT INTO log (
	        date,
	        type,
	        message,
	        version,
	        position
        ) VALUES (
	        @date,
	        @type,
	        @message,
	        @version,
	        @position
        );";

    private var _dbFile : File;
    private var _sqlConnection : SQLConnection;
    private var _version : String;

    public function new( dbFile : File, version : String ) {

        _dbFile = dbFile;
        _version = version;
    }

    public function log( msg : Dynamic, ?infos:haxe.PosInfos ) : Void {

        _write( "", "" + msg, null );
    }

    public function warn( msg : Dynamic, ?infos:haxe.PosInfos ) : Void {

        _write( "WARN", "" + msg, infos );

    }
    public function error( msg : Dynamic, ?infos:haxe.PosInfos ) : Void {

        _write( "ERROR", "" + msg, infos );
    }

    private function _write( type : String, message : String, ?infos:haxe.PosInfos ) : Void {

        var date : String = DateUtil.getLocalTimeStampSecondsW3cDtf( Date.now().getTime() / 1000 );

        var sqlConnection = _getSqlConnection();

        var sqlStatement : SQLStatement = new SQLStatement();
            sqlStatement.sqlConnection = sqlConnection;
            sqlStatement.text = _SQL_INJECT;

        var posInfos : String = "";
        var version : String = _version;

        if ( infos != null ) {

            posInfos = PosInfosUtil.toString( infos );
        }

        ReflectUtil.setField( sqlStatement.parameters, "@date", date );
        ReflectUtil.setField( sqlStatement.parameters, "@type", type );
        ReflectUtil.setField( sqlStatement.parameters, "@message", message );
        ReflectUtil.setField( sqlStatement.parameters, "@position", posInfos );
        ReflectUtil.setField( sqlStatement.parameters, "@version", version );

        sqlStatement.execute();
    }

    private function _getSqlConnection() : SQLConnection {

        var sqlConnection : SQLConnection = _sqlConnection;
        if ( sqlConnection == null ) {

            _sqlConnection = sqlConnection = _createSqlConnection( _dbFile );
        }
        return sqlConnection;
    }

    private function _createSqlConnection( file : File ) : SQLConnection
    {
        var sqlConnection : SQLConnection = new SQLConnection();
            sqlConnection.open( file );

        _ensureSqlStructure( sqlConnection );

        return sqlConnection;
    }

    private function _ensureSqlStructure( sqlConnection : SQLConnection ) : Void
    {
        var sqlStatement : SQLStatement = new SQLStatement();
            sqlStatement.sqlConnection = sqlConnection;
            sqlStatement.text = _SQL_CREATE;
            sqlStatement.execute();
    }
}

