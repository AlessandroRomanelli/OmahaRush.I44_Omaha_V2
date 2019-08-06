scriptName "fn_spectate";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_spectate.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spectate.sqf"
#include "..\utils.h"
#define KEY_ESC 1

disableSerialization;
private _spawnDisplay = findDisplay 5000;
_spawnDisplay closeDisplay 1;

cl_spectating = true;

[ 'Initialize', [ player ] ] call BIS_fnc_EGSpectator;

private "_spectatorDisplay";
waitUntil { _spectatorDisplay = findDisplay 60492; !isNull _spectatorDisplay };

_spectatorDisplay displayAddEventHandler ["KeyDown", {
	private _h = false;
	params ["_display", "_DIKcode"];
	VARIABLE_DEFAULT(cl_spectating, false);
	if (_DIKcode == KEY_ESC && cl_spectating) then {
		_h = true;
		["Terminate"] call BIS_fnc_EGSpectator;
		cl_spectating = false;
		cl_spawnmenu_cam cameraEffect ["Internal", "Back"];
		[] spawn client_fnc_spawn;
	};
	_h
}];
