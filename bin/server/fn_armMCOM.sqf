scriptName "fn_armMCOM";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_armMCOM.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_armMCOM.sqf"
#include "..\utils.h"

if (!isServer || IS_OBJ_ARMED) exitWith {};

SET_OBJ_STATUS(OBJ_STATUS_ARMED);
sv_cur_obj setVariable ["times_armed", (sv_cur_obj getVariable ["times_armed", 0]) + 1];
[remoteExecutedOwner] remoteExec ["client_fnc_MCOMarmed", 0];
[] call server_fnc_MCOMarmed;

true;
