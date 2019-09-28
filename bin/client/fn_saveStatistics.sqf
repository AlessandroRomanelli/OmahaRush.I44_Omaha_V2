scriptName "fn_saveStatistics";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_saveStatistics.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_saveStatistics.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};
EXIT_IF_NOT(cl_init_done);
if (isNil "cl_currentRecord") exitWith {};

// SAVE!!
with missionNamespace do {
	private ["_newRecord", "_serverKey", "_records", "_string", "_record", "_factionXPidx", "_validData", "_stats"];
	_newRecord = [];
	_serverKey = getText(missionConfigFile >> "GeneralConfig" >> "serverKey");
	_records = profileNamespace getVariable ["wwr_records", []];
	_string = "";
	// Fetch the currently loaded record
	_record = cl_currentRecord;
	_factionXPidx = (_record select 2) findIf {(_x select 0) isEqualTo cl_faction};
	_validData = true;
	{
		if (isNil _x) then {
			_validData = false;
		};
	} forEach ["cl_total_kills", "cl_total_deaths", "cl_exp_assault", "cl_exp_medic", "cl_exp_engineer", "cl_exp_support", "cl_exp_recon", "cl_equipConfigurations", "cl_equipClassnames"];
	if (_validData) then {
		(_record select 2) set [_factionXPidx, [cl_faction, cl_exp_assault, cl_exp_medic, cl_exp_engineer, cl_exp_support, cl_exp_recon]];
		_stats = [cl_total_kills, cl_total_deaths, (_record select 2), cl_equipConfigurations, cl_equipClassnames];
	};

	_newRecord pushBack _serverKey;
	_newRecord pushBack _stats;
	_string = str (_newRecord select 1);
	_string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
	_newRecord pushBack _string;

	private _oldRecordIdx = _records findIf {(_x select 0) isEqualTo _serverKey};
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
};

true
