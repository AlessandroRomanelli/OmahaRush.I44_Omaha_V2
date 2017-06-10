scriptName "fn_PVUpdateAll";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_PVUpdateAll.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_PVUpdateAll.sqf"

_variables = param[0,[],[[]]];

// Broadcast all variables
{
	publicVariable _x;
	[format ["Variable %1 has been updated on all clients", _x]] call server_fnc_log;
} forEach _variables;