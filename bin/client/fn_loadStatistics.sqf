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
  private _data = [_serverKey, [0,0,0,[],["","",""]]];
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
  diag_log ("DEBUG: WWR Records now looks like: " + (str _newRecords));
  // Save the modified array
  profileNamespace setVariable ["wwr_records", _newRecords];
  // Return the newly created record
  _data
};

// Searches for the record needed for the current server (serverKey)
private _searchPlayerRecord = {
  // Fetch records array
  private _records = profileNamespace getVariable ["wwr_records", []];
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
  cl_exp = _record select 2;
  cl_equipConfigurations = _record select 3;
  cl_equipClassnames = _record select 4;
  cl_statisticsLoaded = true;
};

// Removes a previous entry from the player's records
private _removeOldRecord = {
  // Fetch all records
  private _records = profileNamespace getVariable ["wwr_records", []];
  // Find the index of record with the same serverKey
  private _idx = _records findIf {(_x select 0) isEqualTo _serverKey};
  // Delete element at index
  _records deleteAt _idx;
  true;
};

if (sv_usingDatabase) then {
  // Fetch data from MySQL database
  [player] remoteExec ["server_fnc_db_getPlayer",2];
} else {
  // Fetch data from profileNamespace
  private ["_record", "_string"];
  // Search for an already existing record with the serverKey in use
  _record = [] call _searchPlayerRecord;
  // If we haven't found anything
  if (count _record == 0) then {
    // Create a fresh record instead
    _record = [] call _createNewRecord;
  };
  _string = "";
  // For each statistic, stringify and concatenate
  {_string = _string + (toLower (str _x))} forEach (_record select 1);
  // Encrypt stats
  _string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
  diag_log format["DEBUG: Comparing compiled key: %1 and stored key: %2", _string, (_record select 2)];
  // Check if the two hashes match
  if (_string isEqualTo (_record select 2)) then {
    // Load the variables
    [_record select 1] spawn _assignVariables;
    diag_log "DEBUG: Key accepted: variables assigned";
  } else {
    // Remove previously existing entry
    [] call _removeOldRecord;
    // Create new entry
    _record = [] call _createNewRecord;
    // Assign it to players vars
    [_record select 1] spawn _assignVariables;
    diag_log "DEBUG: Key denied: corrupted data. Variables reset";
  };
};
