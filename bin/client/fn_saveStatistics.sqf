scriptName "fn_saveStatistics";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_saveStatistics.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_saveStatistics.sqf"

if (isServer && !hasInterface) exitWith {};
saveProfileNamespace;


// SAVE!!
with missionNamespace do {
	// If server is not using a database
	/* if (!sv_usingDatabase) exitWith { */
		private _newRecord = [];
		private _serverKey = getText(missionConfigFile >> "GeneralConfig" >> "serverKey");
		private _records = profileNamespace getVariable ["wwr_records", []];
		private _string = "";
		// Begin assembling the record array
		_newRecord pushBack _serverKey;
		_newRecord pushBack [cl_total_kills, cl_total_deaths, [cl_exp_assault ,cl_exp_medic ,cl_exp_engineer ,cl_exp_support ,cl_exp_recon], cl_equipConfigurations, cl_equipClassnames];
		// Stringify and concatenate stats
		{_string = _string + (toLower (str _x))} forEach (_newRecord select 1);
		// Encrypt stats
		_string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
		// Push the hash in the record
		_newRecord pushBack _string;
		// Get the index of the old record with the current serverKey
		private _oldRecordIdx = _records findIf {(_x select 0) isEqualTo _serverKey};
		// If the record exists
		if !(_oldRecordIdx isEqualTo -1) then {
			// Overwrite it
			_records set [_oldRecordIdx, _newRecord];
		} else {
			if ((count _records) isEqualTo 0) then {
				_records = [_newRecord];
			} else {
				_records pushBack _newRecord;
			};
		};
		profileNamespace setVariable ["wwr_records", _records];
		diag_log format["Saved entry for key: %1, with the following content: %2", _serverKey, _newRecord];
		diag_log format["New records entry is: %1", _records];
		saveProfileNamespace;
	/* }; */

	/* [player, [
		cl_total_kills,
		cl_total_deaths,
		cl_equipConfigurations,
		cl_equipClassnames,
		cl_exp
	]] remoteExec ["server_fnc_db_setPlayer", 2]; */
};
