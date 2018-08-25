scriptName "fn_db_connect";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_db_connect.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_db_connect.sqf"

// Connect Server with Database
if("extDB3" callExtension "9:LOCK_STATUS" == "[0]") then {
    sv_db_id = round(random(9999));
    sv_db_id = sv_db_id;
    uiNamespace setVariable ["sv_db_id",sv_db_id];

    //Retrieve extDB version
    private _result = "extDB3" callExtension "9:VERSION";

    if(_result == "") exitWith {

    };
    /*if ((parseNumber _result) < 60) exitWith {
        ["The extDB version is outdated"] spawn server_fnc_log;
    };*/

    private _dbName = getText(missionConfigFile >> "GeneralConfig" >> "databaseName");

    //Initialize connection to Database
    _result = "extDB3" callExtension format["9:ADD_DATABASE:%1", _dbName];

    if(_result != "[1]") then {
        ["Config already loaded"] spawn server_fnc_log;
        //["Please ensure 'RushRedux' is properly configured in your config.ini"] spawn server_fnc_log;
        sv_db_id = uiNamespace getVariable "sv_db_id";
        _result = "extDB3" callExtension format
            ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:ADD_QUOTES",
                _dbName,
                (sv_db_id)
            ];

        sv_db_connected = true;
    } else {
        _result = "extDB3" callExtension format
            ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:ADD_QUOTES",
                _dbName,
                (sv_db_id)
            ];

        if(_result != "[1]") exitWith {
        	["The database could not be loaded"] spawn server_fnc_log;
            ["Failed at enabling raw statements"] spawn server_fnc_log;
        };

        //"extDB3" callExtension "9:LOCK";
        ["No errors"] spawn server_fnc_log;

        sv_db_connected = true;
    };
} else {
	["Warning: Already connected, the extDB extension might be blocked on the system"] spawn server_fnc_log;
	["extDB3" callExtension "9:LOCK_STATUS"] spawn server_fnc_log;

    sv_db_id = uiNamespace getVariable "sv_db_id";

    sv_db_connected = true;
};
