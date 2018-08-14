scriptName "fn_loadStatistics";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadStatistics.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadStatistics.sqf"
if (isServer && !hasInterface) exitWith {};


private ["_createNewRecord", "_searchPlayerRecord", "_assignVariables", "_serverKey"];
_serverKey = getText(missionConfigFile >> "GeneralConfig" >> "serverKey");

_createNewRecord = {
  private ["_data", "_string", "_newRecords"];
  _data = [_serverKey, [0,0,0,[],["","",""]]];
  _string = "";
  {
    _string = _string + (toLower (str _x));
  } forEach (_data select 1);
  _string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
  _data pushBack _string;
  diag_log ("DEBUG: Newly created record: " + str _data);
  _newRecords = profileNamespace getVariable ["wwr_records", []];
  _newRecords set [count _newRecords, _data];
  diag_log ("DEBUG: WWR Records now looks like: " + (str _newRecords));
  profileNamespace setVariable ["wwr_records", _newRecords];
  _data
};

_searchPlayerRecord = {
  private ["_records", "_record"];
  _records = profileNamespace getVariable ["wwr_records", []];
  _record = [];
  {
    if ((_x select 0) isEqualTo _serverKey) exitWith {_record = _x};
  } forEach _records;
  diag_log format["Searched the following array: %1", str _records];
  diag_log format["Found the following record: %1", str _record];
  _record
};

_assignVariables = {
  private ["_record"];
  _record = param[0, [], []];
  cl_total_kills = _record select 0;
  cl_total_deaths = _record select 1;
  cl_exp = _record select 2;
  cl_equipConfigurations = _record select 3;
  cl_equipClassnames = _record select 4;
  cl_statisticsLoaded = true;
};

if (sv_usingDatabase) then {
  [player] remoteExec ["server_fnc_db_getPlayer",2];
} else {
  private ["_record", "_string"];
  _record = [] call _searchPlayerRecord;
  if (count _record == 0) then {
    _record = [] call _createNewRecord;
  };
  _string = "";
  {_string = _string + (toLower (str _x))} forEach (_record select 1);
  _string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
  diag_log format["DEBUG: Comparing compiled key: %1 and stored key: %2", _string, (_record select 2)];
  if (_string isEqualTo (_record select 2)) then {
    [_record select 1] spawn _assignVariables;
    diag_log "DEBUG: Key accepted: variables assigned";
  } else {
    _record = [] call _createNewRecord;
    [_record select 1] spawn _assignVariables;
    diag_log "DEBUG: Key denied: corrupted data. Variables reset";
  };
};
