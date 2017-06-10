scriptName "fn_remoteExecution";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_remoteExecution.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_remoteExecution.sqf"
if (isServer && !hasInterface) exitWith {};

_code = param[0,{},[{}]];

if (isNil "cl_lastRemoteExecManual") then {
	cl_lastRemoteExecManual = 0;
};

// Not too fast execution
if (diag_tickTime - cl_lastRemoteExecManual < 5) exitWith {};
cl_lastRemoteExecManual = diag_tickTime;

// Spawn local
[] spawn _code;