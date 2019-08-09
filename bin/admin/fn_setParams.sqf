scriptName "fn_setParams";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_setParams.sqf

  You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_setParams.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

params ["_display", "_exitCode"];

if (_exitCode == 2) exitWith {};

private _getSelected = {
	params ["_ctrl"];
	if !(ctrlShown _ctrl) exitWith {[]};
 	private _idx = lbCurSel _ctrl;
	[_ctrl lbData _idx, _ctrl lbValue _idx]
};

private _settings = [];
for "_i" from 0 to 25 do {
	private _selectCtrl = _display displayCtrl (1100+_i);
	private _param = [_selectCtrl] call _getSelected;
	_param params ["_key", "_value"];
	private _oldValue = missionNamespace getVariable [format["sv_setting_%1",_key], nil];
	if (count _param != 0 && {_value != _oldValue}) then {
		_settings pushBack _param;
	};
};

[_settings] remoteExec ["server_fnc_setParams", 2];
