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

[] remoteExecCall ["server_fnc_armMCOM", 2];

true
