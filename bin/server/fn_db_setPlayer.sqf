scriptName "fn_db_setPlayer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_db_setPlayer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_db_setPlayer.sqf"

// Params
private _player = param[0,objNull,[objNull]];
private _playerData = param[1,[],[[]]];

private _pName = name _player;
if (_pName find "'" != -1) then {
	_pName = _pName splitString "";
	{if (_x == "'") then {_pName deleteAt _forEachIndex}} forEach _pName;
	_pName = _pName joinString "";
};

if (isNull _player) exitWith {};
if (count _playerData == 0) exitWith {};

// Save in DB
private _query = format["UPDATE players SET name='%2', kills=%3, deaths=%4, exp=%7, equipConfigurations='%5', equipLoaded='%6' WHERE steamid='%1';", getPlayerUID _player, _pName, _playerData select 0, _playerData select 1, [true, str (_playerData select 2)] call server_fnc_db_prepareString, [true, str (_playerData select 3)] call server_fnc_db_prepareString, _playerData select 4];
[_query,1] call server_fnc_db_asyncCall;
