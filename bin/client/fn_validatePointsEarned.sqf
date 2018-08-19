scriptName "fn_validatePointsEarned";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_validatePointsEarned.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_validatePointsEarned.sqf"

if (cl_pointsBelowMinimumPlayers > 15000) then {
	["Your progress has been reset for boosting"] call server_fnc_log;

	// Reset points
	cl_exp = 0;

	// Save to database
	if (sv_usingDatabase) then {
		[player, [
		cl_total_kills,
		cl_total_deaths,
		cl_equipConfigurations,
		cl_equipClassnames,
		cl_exp
		]] remoteExec ["server_fnc_db_setPlayer", 2];
	} else {
		[] spawn client_fnc_saveStatistics;
	};
};
