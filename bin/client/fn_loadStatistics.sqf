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
  _data = [];
  _data pushBack _serverKey;
  for "_i" from 1 to 3 do {_data pushBack 0};
  _data pushBack [];
  _data pushBack ["", "", ""];
  _string = "";
  {
    _string = _string + (toLower (str _x));
  } forEach _data;
  _string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
  _newRecords = (profileNamespace getVariable ["wwr_records", []]) pushBackUnique _data;
  profileNamespace setVariable ["wwr_records", _newRecords];
  _data
};

_searchPlayerRecord = {
  private ["_records", "_record"];
  _records = profileNamespace getVariable ["wwr_records", []];
  _record = [];
  {if ((_x select 0) isEqualTo _serverKey) exitWith {_record = _x};} forEach _records;
  _record
};

_assignVariables = {
  private ["_record"];
  _record = param[0, [], []];
  cl_total_kills = _record select 1;
  cl_total_deaths = _record select 2;
  cl_exp = _record select 3;
  cl_equipConfigurations = _record select 4;
  cl_equipClassnames = _record select 5;
  true
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
  {if (_forEachIndex > 0 && _forEachIndex < 6) then {_string = _string + (toLower (str _x))};} forEach _record;
  _string = [1, "rc4", _string, _serverKey] call client_fnc_encryptData;
  if (_string isEqualTo (_record select 6)) then {
    [_record] call _assignVariables;
    diag_log "DEBUG: Key accepted: variables assigned";
  } else {
    _record = [] call _createNewRecord;
    [_record] call _assignVariables;
    diag_log "DEBUG: Key denied: corrupted data. Variables reset";
  };
};
