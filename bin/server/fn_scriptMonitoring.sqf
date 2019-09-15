scriptName "fn_scriptMonitoring";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_scriptMonitoring.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_scriptMonitoring.sqf"

while {true} do {
	uiSleep 60;
	["Currently active scripts"] call server_fnc_log;
	["Amount: " + str (count diag_activeSQFScripts)] call server_fnc_log;
	{
		[str _x] call server_fnc_log;
	} forEach (diag_activeSQFScripts);
};
