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
	cl_exp_assault = 0;
	cl_exp_medic = 0;
	cl_exp_engineer = 0;
	cl_exp_support = 0;
	cl_exp_recon = 0;

	[] spawn client_fnc_saveStatistics;
};

true
