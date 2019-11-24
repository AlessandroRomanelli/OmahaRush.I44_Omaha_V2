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
  private _data = [_serverKey, [0,0,[["GER",0,0,0,0,0],["US",0,0,0,0,0],["SOV",0,0,0,0,0],["UK",0,0,0,0,0]],[],["","",""]]];
  private _string = str (_data select 1);
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
  if !(_idx isEqualTo -1) then {
    diag_log format["DEBUG: Updating %1, index: %2 was matching key: %3", _varName, _idx, _key];
    _records set [_idx, _record];
  } else {
    diag_log format["DEBUG: No match found, creating new entry in %1", _varName];
    if ((count _records) isEqualTo 0) then {
      _records = [_record];
    } else {
      _records pushBack _record;
    };
  };
  diag_log format ["DEBUG: Updating %1 variable with the following record: %2", _varName, _records];
  profileNamespace setVariable [_varName, _records];
  true;
};

/* private _encodeStats = {
  private _stats = param[0, [], [[]]];
  diag_log format["DEBUG: Encoding the following array: %1", _stats];
  private _hash = "";
  // For each statistic, stringify and concatenate
  {_hash = _hash + (toLower (str _x))} forEach _stats;
  // Encrypt stats
  _hash = [1, "rc4", _hash, _serverKey] call client_fnc_encryptData;
  _hash
}; */

private _decodeHash = {
  private _hash = param[0, "", [""]];
  diag_log format["DEBUG: Decoding the following hash: %1", _hash];
  private _stats = [0, "rc4", _hash, _serverKey] call client_fnc_encryptData;
  _stats
};

// Searches for the record needed for the current server (serverKey)
private _searchPlayerRecords = {
  // Fetch records array
  private _records = param[0, [], [[]]];
  diag_log format["DEBUG: Searched the following array: %1", str _records];
  // Check whether we have a record for the current serverKey in use
  private _idx = _records findIf {(_x select 0) isEqualTo _serverKey};
  if (_idx isEqualTo -1) exitWith {[]};
  diag_log format["DEBUG: Found the following record: %1", str (_records select _idx)];
  (_records select _idx);
};

// Assigns the selected record to the player's global variables
private _assignVariables = {
  private _record = param[0, [], []];
  cl_currentRecord = _record;
  cl_total_kills = _record select 0;
  cl_total_deaths = _record select 1;
  private _side = ["attackers", "defenders"] select (player getVariable ["side", side player] == WEST);
  cl_faction = getText(missionConfigFile >> "Unlocks" >> _side >> "faction");
  private _globalXPs = _record select 2;
  private _factionIdx = _globalXPs findIf {(_x select 0) isEqualTo cl_faction};
  if !(_factionIdx isEqualTo -1) then {
    cl_exp_assault = ((_globalXPs) select _factionIdx) select 1;
    cl_exp_medic = ((_globalXPs) select _factionIdx) select 2;
    cl_exp_engineer = ((_globalXPs) select _factionIdx) select 3;
    cl_exp_support = ((_globalXPs) select _factionIdx) select 4;
    cl_exp_recon = ((_globalXPs) select _factionIdx) select 5;
  } else {
    cl_exp_assault = 0;
    cl_exp_medic = 0;
    cl_exp_engineer =0;
    cl_exp_support = 0;
    cl_exp_recon = 0;
  };
  cl_equipConfigurations = _record select 3;
  cl_equipClassnames = _record select 4;
  true
};

// Removes a previous entry from the player's records
private _removeOldRecord = {
  // Fetch all records
  private _records = profileNamespace getVariable ["wwr_records", []];
  private _backups = profileNamespace getVariable ["wwr_records_backups", []];
  if ((count _records) isEqualTo 0 && (count _backups) isEqualTo 0) exitWith {false};
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

private ["_record"];

diag_log "DEBUG: 1) Checking if data must be reset";
// Check if we are resetting
private _toBeReset = !(profileNamespace getVariable ["wwr_toBeReset", ""] isEqualTo "v075");
if (_toBeReset) then {
  profileNamespace setVariable ["wwr_toBeReset", "v075"];
  [] call _removeOldRecord;
};

// Search for an already existing record with the serverKey in use
private _records = profileNamespace getVariable ["wwr_records", []];
private _backups = profileNamespace getVariable ["wwr_records_backups", []];

diag_log "DEBUG: 2) Looking for a record";
_record = [_records] call _searchPlayerRecords;

// If we haven't found anything
if ((count _record) isEqualTo 0) then {
  diag_log "DEBUG: 3) Record not found, looking for backup";
  // Search in the backups
  _record = [_backups] call _searchPlayerRecords;
  if ((count _record) isEqualTo 0) then {
    diag_log "DEBUG: 4) Backup not found, creating new entry";
    // Create a fresh record instead
    _record = [] call _createNewRecord;
  };
};

private _stats = [_record select 2] call _decodeHash;
diag_log format["DEBUG: 5) Decoding the hash from the given record and comparing to the one stored in the record. Decoded: %1, Stats: %2", _stats, _record select 1];

// Check if the two hashes match
if (_stats isEqualTo (str (_record select 1))) then {
  // Load the variables
  [_record select 1] call _assignVariables;
  // Push the loaded record into the backups array
  private _backup = +_record;
  [_backup, "wwr_records_backups", _serverKey] call _updateEntry;
  diag_log "DEBUG: 7) Key accepted: variables assigned, backup updated with current record";
} else {
  diag_log "DEBUG: 8) Key denied: fallback to backed up data";
  // Search backups array for a record
  _record = [_backups] call _searchPlayerRecords;
  // If we have found a record
  if !(count _record isEqualTo 0) then {
    diag_log "DEBUG: 9) We have found a backup";
    // Check if this record was valid
    private _stats = [_record select 2] call _decodeHash;
    if (_stats isEqualTo (str (_record select 1))) then {
      // Assign it to our variables and save it as our current record
      [_record select 1] call _assignVariables;
      diag_log "DEBUG: 10) Fallback accepted: variables assigned";
    } else {
      diag_log "DEBUG: 11) Fallback refused: resetting data";
      // Remove entry if it existed
      [] call _removeOldRecord;
      // Create new entry
      _record = [] call _createNewRecord;
      // Assign it to players vars
      [_record select 1] call _assignVariables;
    }
  } else {
    diag_log "DEBUG: 12) No backup found: resetting player";
    // Remove entry if it existed
    [] call _removeOldRecord;
    // Create new entry
    _record = [] call _createNewRecord;
    // Assign it to players vars
    [_record select 1] call _assignVariables;
  };

  [_record, "wwr_records", _serverKey] call _updateEntry;
  private _backup = +_record;
  [_backup, "wwr_records_backups", _serverKey] call _updateEntry;
};
diag_log format["DEBUG: Records array: %1", profileNamespace getVariable ["wwr_records", []], _serverKey];
diag_log format["DEBUG: Backups array: %1", profileNamespace getVariable ["wwr_records_backups", []], _serverKey];
