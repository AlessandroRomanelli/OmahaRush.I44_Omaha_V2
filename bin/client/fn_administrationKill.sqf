scriptName "fn_administrationKill";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_administrationKill.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_administrationKill.sqf"
if (isServer && !hasInterface) exitWith {};

// Reason
private _reason = param[0,"",[""]];

// Kill me
player setDamage 1;
player setVariable ["isAlive", false];

// Display the reason
[_reason] call client_fnc_displayError;

true
