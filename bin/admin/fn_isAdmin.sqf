scriptName "fn_isAdmin";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_isAdmin.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_isAdmin.sqf"

params [["_unit", objNull, [objNull]]];

if ((admin (owner _unit)) > 1) exitWith { true };

private _wl = getArray(missionConfigFile >> "enableDebugConsole");

if ((getPlayerUID _unit) in _wl) exitWith { true };

false
