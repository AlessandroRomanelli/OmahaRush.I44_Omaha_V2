scriptName "fn_updateVars";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_updateVars.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateVars.sqf"

private _variables = param[0,[],[[]]];

// Broadcast all variables
{
	publicVariable _x;
	[format ["Variable %1 has been updated on all clients", _x]] call server_fnc_log;
} forEach _variables;
true
