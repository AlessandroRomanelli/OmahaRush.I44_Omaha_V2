scriptName "fn_saveStatistics";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_saveStatistics.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_saveStatistics.sqf"
#define CL_PROPS [cl_total_kills, cl_total_deaths, cl_exp, cl_equipConfigurations, cl_equipClassnames]

if (isServer && !hasInterface) exitWith {};
saveProfileNamespace;


// SAVE!!
with missionNamespace do {
	// No database no saving!
	if (!sv_usingDatabase) exitWith {
		profileNamespace setVariable ["wwr_cl_total_kills", cl_total_kills];
	  profileNamespace setVariable ["wwr_cl_total_deaths", cl_total_deaths];
	  profileNamespace setVariable ["wwr_cl_exp", cl_exp];
	  profileNamespace setVariable ["wwr_cl_equipConfigurations", cl_equipConfigurations];
	  profileNamespace setVariable ["wwr_cl_equipClassnames", cl_equipClassnames];
	  profileNamespace setVariable ["wwr_hasRecord", true];
		_data = "";
		{_data = _data + str _x} forEach CL_PROPS;
		_data = [1, "rc4", _data, getText(missionConfigFile >> "GeneralConfig" >> "serverKey")] call client_fnc_encryptData;
		profileNamespace setVariable ["wwr_cl_key", _data];
		saveProfileNamespace;
		diag_log ("DEBUG: Saved profileNamespace with encryption key: "+_data);
	};

	[player, [
		cl_total_kills,
		cl_total_deaths,
		cl_equipConfigurations,
		cl_equipClassnames,
		cl_exp
	]] remoteExec ["server_fnc_db_setPlayer", 2];
};
