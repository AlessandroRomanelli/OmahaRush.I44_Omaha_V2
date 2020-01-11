scriptName "fn_disarmMCOM";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_disarmMCOM.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_disarmMCOM.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

// If it wasn't armed, there's nothing to disarm!
private _status = sv_cur_obj getVariable ["status", OBJ_STATUS_UNARMED];
if (IS_OBJ_UNARMED || {_status > OBJ_STATUS_ARMED} || {!alive player} || {cl_action_obj != sv_cur_obj}) exitWith {};

[] remoteExecCall ["server_fnc_disarmMCOM", 2];
true

//Todo Add MLG version
