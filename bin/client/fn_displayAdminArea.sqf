scriptName "fn_displayAdminArea.sqf";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_displayAdminArea.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayAdminArea.sqf"
if (isServer && !hasInterface) exitWith {};

if !([player] call admin_fnc_isAdmin) exitWith {};

if (isNull (findDisplay 7000)) then {
	createDialog "rr_admin_area";
};
