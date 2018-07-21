scriptName "fn_db_asyncCall";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_db_asyncCall.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_db_asyncCall.sqf"

private["_tickTime","_queryStmt","_queryResult","_key","_mode","_return","_loop","_multiarr","_keyMode"];

_tickTime = diag_tickTime;

_queryStmt = param [0,"",[""]];
_mode = param [1,1,[0]];
_multiarr = param [2,false,[false]];

_result = "extDB3" callExtension format["%1:%2:%3",_mode, sv_db_id, _queryStmt];

if(_mode == 1) exitWith {
	true;
};

_result = call compile format["%1",_result];
_key = (_result select 1);
_keyMode = (_result select 0);

uisleep (random .03);

// Get Result via 4:x (single message return)  v19 and later
_queryResult = "";
_loop = true;

while{_loop} do
{
	_queryResult = "extDB3" callExtension format["4:%1", _key];
	switch(_queryResult) do {

		case "[5]": {

			// extDB3 returned that result is Multi-Part Message
			_queryResult = "";

			while{true} do {
				_pipe = "extDB3" callExtension format["5:%1", _key];
				if(_pipe == "") exitWith {_loop = false};
				_queryResult = _queryResult + _pipe;
			};
		};

		case "[3]": {
			uisleep 0.3;
		};

		default {
			_loop = false;
		};
	};
};

//diag_log "TEST";
//diag_log _queryResult;

_queryResult = call compile _queryResult;

// Not needed, its SQF Code incase extDB ever returns error message i.e Database Died
if ((_queryResult select 0) == 0) exitWith {
	[];
};

_return = (_queryResult select 1);

if(!_multiarr && count _return > 0) then {
	_return = _return select 0;
};

_return;