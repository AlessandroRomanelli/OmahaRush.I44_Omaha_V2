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
saveProfileNamespace;


// SAVE!!
with missionNamespace do {
	// No database no saving!
	if (!sv_usingDatabase) exitWith {
		private _newRecord = [];
		private _serverKey = getText(missionConfigFile >> "GeneralConfig" >> "serverKey");
		private _records = profileNamespace getVariable ["wwr_records", []];
		private _oldRecordIdx = -1;
		{
			if ((_x select 0) isEqualTo _serverKey) exitWith {
				_oldRecordIdx = _forEachIndex;
			};
		} forEach _records;
		if !(_oldRecordIdx isEqualTo -1) then {
			private _string = "";
			_newRecord pushBack _serverKey;
			_newRecord set [1, [cl_total_kills, cl_total_deaths, cl_exp, cl_equipConfigurations, cl_equipClassnames]];
			{_string = _string + (toLower (str _x))} forEach (_newRecord select 1);
			_string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
			_newRecord pushBack _string;
			_records set [_oldRecordIdx, _newRecord];
		};
		profileNamespace setVariable ["wwr_records", _records];
		diag_log format["Saved entry for key: %1, with the following content: %2", _serverKey, _newRecord];
		diag_log format["New records entry is: %1", _records];
		saveProfileNamespace;
	};

	[player, [
		cl_total_kills,
		cl_total_deaths,
		cl_equipConfigurations,
		cl_equipClassnames,
		cl_exp
	]] remoteExec ["server_fnc_db_setPlayer", 2];
};
