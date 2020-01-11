scriptName "fn_disarmMCOM";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_disarmMCOM.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_disarmMCOM.sqf"
#include "..\utils.h"

if (!isServer || IS_OBJ_UNARMED) exitWith {};

SET_OBJ_STATUS(OBJ_STATUS_UNARMED);
[remoteExecutedOwner] remoteExec ["client_fnc_MCOMdisarmed", 0];

true;
