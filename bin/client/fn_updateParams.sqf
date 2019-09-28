scriptName "fn_updateParams";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_updateParams.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateParams.sqf"

private _valid = params ["_var", "_settings"];

diag_log ("Params updated: " +  str _this);

if (!_valid || {_var != "sv_settings"}) exitWith {};

{
	_x params ["_varName", "_value"];
	missionNamespace setVariable [format["sv_setting_%1",_varName], _value];
} forEach _settings;
