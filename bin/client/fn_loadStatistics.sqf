scriptName "fn_loadStatistics";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadStatistics.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadStatistics.sqf"
if (isServer && !hasInterface) exitWith {};

// If this is the debug mode, just unlock everything
/*if (getNumber(missionConfigFile >> "GeneralConfig" >> "debug") == 1) then {
	cl_exp = 0; // Overall EXP
	cl_equipClassnames = ["","",""];
	cl_equipConfigurations = []; // equip configurations
	cl_total_kills = 0;
	cl_total_deaths = 0;
	cl_kills = 0;
} else {
	// TODO
};*/

[player] remoteExec ["server_fnc_db_getPlayer",2];