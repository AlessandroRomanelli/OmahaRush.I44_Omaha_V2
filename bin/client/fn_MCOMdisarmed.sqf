scriptName "fn_MCOMdisarmed";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_MCOMdisarmed.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MCOMdisarmed.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

// Planter
private _netId = param[0,0,[0]];

WAIT_IF_NOT(cl_init_done);

if (clientOwner == _netId || {isServer && !isDedicated && _netId == 0}) then {
	// Give points
	["<t size='1.3' color='#FFFFFF'>EXPLOSIVES DISARMED</t><br/><t size='1.0' color='#FFFFFF'>Objective Defender</t>", 450] call client_fnc_pointfeed_add;
	[450] call client_fnc_addPoints;
};

["THE EXPLOSIVES HAVE BEEN DEFUSED"] remoteExecCall ["client_fnc_displayObjectiveMessage", -2];
