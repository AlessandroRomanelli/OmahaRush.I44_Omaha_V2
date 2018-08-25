scriptName "fn_loadStatistics";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_loadStatistics.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadStatistics.sqf"
if (isServer && !hasInterface) exitWith {};

// Loading the key the server is using
private _serverKey = getText(missionConfigFile >> "GeneralConfig" >> "serverKey");

// Create a new entry in the player record
private _createNewRecord = {
  // Default data [Key, [Stats], Hash]
  private _data = [_serverKey, [0,0,[0,0,0,0,0],[],["","",""]]];
  private _string = "";
  // Stringify and concatenate all the stats
  {
    _string = _string + (toLower (str _x));
  } forEach (_data select 1);
  // Encrypt stats
  _string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
  // Append hash to the record
  _data pushBack _string;
  diag_log ("DEBUG: Newly created record: " + str _data);
  // Fetch currently stored records array
  private _newRecords = profileNamespace getVariable ["wwr_records", []];
  // Pushback the new recorcd
  if (_newRecords isEqualTo []) then {
    _newRecords = [_data];
  } else {
    _newRecords pushBackUnique _data;
  };
  // Save the modified array
  profileNamespace setVariable ["wwr_records", _newRecords];
  // Return the newly created record
  _data
};

private _updateEntry = {
  private _record = param[0, [],[[]]];
  private _varName = param[1, "", [""]];
  private _key = param[2, "", [""]];
  private _records = profileNamespace getVariable [_varName, []];
  private _idx = _records findIf {(_x select 0) isEqualTo _key};
  diag_log format["DEBUG: Updating %1, index: %2 was matching key: %3", _varName, _idx, _key];
  if !(_idx isEqualTo -1) then {
    _records set [_idx, _record];
  } else {
    if ((count _records) isEqualTo 0) then {
      _records = [_record];
    } else {
      _records pushBack _record;
    };
  };
  profileNamespace setVariable [_varName, _records];
  true;
};

private _encodeStats = {
  private _stats = param[0, [], [[]]];
  private _hash = "";
  // For each statistic, stringify and concatenate
  {_hash = _hash + (toLower (str _x))} forEach _stats;
  // Encrypt stats
  _hash = [1, "rc4", _hash, _serverKey] call client_fnc_encryptData;
  _hash
};

// Searches for the record needed for the current server (serverKey)
private _searchPlayerRecords = {
  // Fetch records array
  private _records = param[0, [], [[]]];
  // Check whether we have a record for the current serverKey in use
  private _idx = _records findIf {(_x select 0) isEqualTo _serverKey};
  if (_idx isEqualTo -1) exitWith {[]};
  diag_log format["Searched the following array: %1", str _records];
  diag_log format["Found the following record: %1", str (_records select _idx)];
  (_records select _idx);
};

// Assigns the selected record to the player's global variables
private _assignVariables = {
  private _record = param[0, [], []];
  cl_total_kills = _record select 0;
  cl_total_deaths = _record select 1;
  cl_exp_assault = (_record select 2) select 0;
  cl_exp_medic = (_record select 2) select 1;
  cl_exp_engineer = (_record select 2) select 2;
  cl_exp_support = (_record select 2) select 3;
  cl_exp_recon = (_record select 2) select 4;
  cl_equipConfigurations = _record select 3;
  cl_equipClassnames = _record select 4;
  cl_statisticsLoaded = true;
};

// Removes a previous entry from the player's records
private _removeOldRecord = {
  // Fetch all records
  private _records = profileNamespace getVariable ["wwr_records", []];
  private _backups = profileNamespace getVariable ["wwr_records_backups", []];
  // Find the index of record with the same serverKey
  private _idx_records = _records findIf {(_x select 0) isEqualTo _serverKey};
  private _idx_backups = _backups findIf {(_x select 0) isEqualTo _serverKey};
  // Delete element at index
  _records deleteAt _idx_records;
  _backups deleteAt _idx_backups;
  profileNamespace setVariable ["wwr_records", _records];
  profileNamespace setVariable ["wwr_records_backups", _backups];
  true;
};

/* if (sv_usingDatabase) then {
  // Fetch data from MySQL database
  [player] remoteExec ["server_fnc_db_getPlayer",2];
} else { */
  // Fetch data from profileNamespace
  private ["_record"];

  // Check if we are resetting
  private _toBeReset = profileNamespace getVariable ["wwr_toBeReset", ""] isEqualTo "v070";
  if (_toBeReset) exitWith {
    profileNamespace setVariable ["wwr_toBeReset", "v070"];
    _record = [] call _createNewRecord;
    [_record select 1] spawn _assignVariables;
    [_record, "wwr_records", _serverKey] call _updateEntry;
    [_record, "wwr_records_backups", _serverKey] call _updateEntry;
  };

  // Search for an already existing record with the serverKey in use
  private _records = profileNamespace getVariable ["wwr_records", []];
  private _backups = profileNamespace getVariable ["wwr_records_backups", []];

  _record = [_records] call _searchPlayerRecords;

  // If we haven't found anything
  if ((count _record) isEqualTo 0) then {
    // Create a fresh record instead
    _record = [_backups] call _searchPlayerRecords;
    if ((count _record) isEqualTo 0) then {
      _record = [] call _createNewRecord;
    };
  };

  private _hash = [_record select 1] call _encodeStats;
  private _storedHash = _record select 2;
  diag_log format["DEBUG: Comparing compiled hash: %1 and stored hash: %2", _hash, _storedHash];

  // Check if the two hashes match
  if (_hash isEqualTo _storedHash) then {
    // Load the variables
    [_record select 1] spawn _assignVariables;
    // Push the loaded record into the backups array
    [_record, "wwr_records_backups", _serverKey] call _updateEntry;
    diag_log "DEBUG: Key accepted: variables assigned, backup updated with current record";
  } else {
    diag_log "DEBUG: Key denied: fallback to backed up data";
    // Search backups array for a record
    _record = [_backups] call _searchPlayerRecords;
    // If we have found a record
    if !(count _record isEqualTo 0) then {
      // Check if this record was valid
      private _hash = [_record select 1] call _encodeStats;
      if (_hash isEqualTo (_record select 2)) then {
        // Assign it to our variables and save it as our current record
        [_record select 1] spawn _assignVariables;
        diag_log "DEBUG: Fallback accepted: variables assigned";
      };
    } else {
      // Remove entry if it existed
      [] call _removeOldRecord;
      // Create new entry
      _record = [] call _createNewRecord;
      // Assign it to players vars
      [_record select 1] spawn _assignVariables;
      diag_log "DEBUG: Fallback denied: corrupted data. Variables reset";
    };
    [_record, "wwr_records", _serverKey] call _updateEntry;
    [_record, "wwr_records_backups", _serverKey] call _updateEntry;
  };
  diag_log format["DEBUG: Records array: %1", _records, _serverKey];
  diag_log format["DEBUG: Backups array: %1", _backups, _serverKey];
/* }; */
