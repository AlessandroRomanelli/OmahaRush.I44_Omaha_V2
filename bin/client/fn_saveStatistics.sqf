scriptName "fn_saveStatistics";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_saveStatistics.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_saveStatistics.sqf"
if (isServer && !hasInterface) exitWith {};

// SAVE!!
with missionNamespace do {
	// No database no saving!
	if (!sv_usingDatabase) exitWith {};

	[player, [
		cl_total_kills,
		cl_total_deaths,
		cl_equipConfigurations,
		cl_equipClassnames,
		cl_exp
	]] remoteExec ["server_fnc_db_setPlayer", 2];
};