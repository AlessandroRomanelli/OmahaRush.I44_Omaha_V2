scriptName "fn_setServerParams";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_setServerParams.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_setServerParams.sqf"
#include "..\utils.h"

MUTEX_INIT(sv_settings_lock);
MUTEX_LOCK(sv_settings_lock);

params [["_settings", [], [[]]]];

if (count _settings == 0) exitWith {};

private _edited = [];
{
	_x params ["_key", "_value"];
	private _setting = format ["sv_setting_%1", _key];
	private _old = profileNamespace getVariable [_setting, nil];
	if (isNil {_old} || {_old != _value}) then {
		profileNamespace setVariable [_setting, _value];
		missionNamespace setVariable [_setting, _value];
		_edited pushBack _x;
	};
} forEach _settings;

if (count _edited > 0) then {
	saveProfileNamespace;
	sv_settings = _edited;
	publicVariable "sv_settings";
};

/* VARIABLE_DEFAULT(sv_settings, []);

if (count _edited > 0) then {
	saveProfileNamespace;
	{
		_x params ["_key1", "_value1"];
		private _found = false;
		{
			_x params ["_key2"];
			if (_key1 == _key2) then {
				sv_settings set [_forEachIndex, [_key1, _value1]];
				_found = true;
			};
		} forEach sv_settings;
		if (!_found) then {
			sv_settings pushBack _x;
		};
	} forEach _edited;
	publicVariable "sv_settings";
}; */

MUTEX_UNLOCK(sv_settings_lock);
