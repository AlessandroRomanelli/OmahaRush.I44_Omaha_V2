scriptName "fn_db_getPlayer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_db_getPlayer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_db_getPlayer.sqf"

// Parameters
_player = param[0,objNull,[objNull]];

// Exceptions
if (isNull _player) exitWith {};

_pName = name _player;
if (_pName find "'" != -1) then {
	_pName = _pName splitString "";
	{if (_x == "'") then {_pName deleteAt _forEachIndex}} forEach _pName;
	_pName = _pName joinString "";
};


// Code
_query = format["SELECT kills, deaths, exp, equipConfigurations, equipLoaded FROM players WHERE steamid='%1'",getPlayerUID _player];
_playerData = [_query,2] call server_fnc_db_asyncCall;

if(count _playerData == 0) then {
	// Player does not exist in DB, create him
	_query = format["INSERT INTO players(name, steamid, kills, deaths, equipConfigurations, equipLoaded, exp) VALUES ('%1',%2,0,0,'[]','%3', 0)", _pName, getPlayerUID _player, [true,str (["","",""])] call server_fnc_db_prepareString];
	[_query,1] call server_fnc_db_asyncCall;
	uisleep 1;

	// Default values
	_playerData = [0,0,0,[],["","",""]];

	// Send to client
	[_playerData] remoteExec ["client_fnc_giveStatistics", _player];
} else {

	{
		if (typeName _x == typeName "") then {
		_playerData set[_forEachIndex,call compile ([false,_x] call server_fnc_prepareString)];
		};
	} forEach _playerData;

	// Send to client
	[_playerData] remoteExec ["client_fnc_giveStatistics", _player];
};
