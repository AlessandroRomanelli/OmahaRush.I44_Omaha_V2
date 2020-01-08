scriptName "fn_armMCOM";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_armMCOM.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_armMCOM.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};
// If the objective is already armed, do nothing!
if (IS_OBJ_ARMED || {!alive player} || {!isNil "cl_action_obj" && {cl_action_obj != sv_cur_obj}}) exitWith {};

// Set armed
sv_cur_obj setVariable ["status", OBJ_STATUS_ARMED, true];

// Give points
["<t size='1.3' color='#FFFFFF'>EXPLOSIVES ARMED</t><br/><t size='1.0' color='#FFFFFF'>Objective Attacker</t>", 225] call client_fnc_pointfeed_add;
[225] call client_fnc_addPoints;

// Inform server that the mcom has been planted
[player] remoteExec ["client_fnc_MCOMarmed", -2];
[player] remoteExec ["server_fnc_MCOMarmed", 2];

true
