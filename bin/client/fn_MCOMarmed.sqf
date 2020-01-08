scriptName "fn_MCOMarmed";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_MCOMarmed.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MCOMarmed.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

// Planter
private _planter = param[0,objNull,[objNull]];

WAIT_IF_NOT(cl_init_done);


// Display warning
["EXPLOSIVES HAVE BEEN SET"] call client_fnc_displayObjectiveMessage;
// Info
["EXPLOSIVES ARMED","The objective has been armed. Attackers will not lose tickets while it is."] spawn client_fnc_hint;

// Did we plant? Should be give ourself points?
if (_planter == player) then {
	// Wait until estimated explosion time
	private _objective = sv_cur_obj;
	waitUntil {(_objective getVariable ["status", OBJ_STATUS_UNARMED] == OBJ_STATUS_DONE) || (_objective != sv_cur_obj)};

	// Still the same objective? Looks like we werent successful...
	if (_objective == sv_cur_obj) exitWith {};

	// We made it work yay
	["<t size='1.3' color='#FFFFFF'>OBJECTIVE DESTROYED</t>", 400] call client_fnc_pointfeed_add;
	[400] call client_fnc_addPoints;
};

// PROPER FORMATTING
// 0.6 * ( ( ( ( safezoneW / safezoneH ) min 1.2 ) / 1.2 ) / 25 )
