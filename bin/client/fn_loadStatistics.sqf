scriptName "fn_loadStatistics";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadStatistics.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadStatistics.sqf"
#define CL_PROPS [cl_total_kills, cl_total_deaths, cl_exp, cl_equipConfigurations, cl_equipClassnames]
if (isServer && !hasInterface) exitWith {};

_serverKey = getText(missionConfigFile >> "GeneralConfig" >> "serverKey");

_resetPlayer = {
  _assignVars = param[0, false, [false]];
  profileNamespace setVariable ["wwr_cl_total_kills", 0];
  profileNamespace setVariable ["wwr_cl_total_deaths", 0];
  profileNamespace setVariable ["wwr_cl_exp", 0];
  profileNamespace setVariable ["wwr_cl_equipConfigurations", []];
  profileNamespace setVariable ["wwr_cl_equipClassnames", ["", "", ""]];
  _data = [1, "rc4", "000[]["""","""",""""]", _serverKey] call client_fnc_encryptData;
  profilenamespace setVariable ["wwr_cl_key", _data];
  profileNamespace setVariable ["wwr_hasRecord", true];
  if (_assignVars) then {
    cl_total_kills = 0;
    cl_total_deaths = 0;
    cl_exp = 0;
    cl_equipConfigurations = [];
    cl_equipClassnames = ["", "", ""];
  };
  _assignVars
};

if (sv_usingDatabase) then {
  [player] remoteExec ["server_fnc_db_getPlayer",2];
} else {
  if !(profileNamespace getVariable ["wwr_hasRecord", false]) then {
    [false] call _resetPlayer;
    diag_log "DEBUG: No record found for player, resetting statistics";
  };
  cl_total_kills = profileNamespace getVariable ["wwr_cl_total_kills", 0];
  cl_total_deaths = profileNamespace getVariable ["wwr_cl_total_deaths", 0];
  cl_exp = profileNamespace getVariable ["wwr_cl_exp", 0];
  cl_equipConfigurations = profileNamespace getVariable ["wwr_cl_equipConfigurations", []];
  cl_equipClassnames = profileNamespace getVariable ["wwr_cl_equipClassnames", ["", "", ""]];
  _key = profileNamespace getVariable ["wwr_cl_key", ""];
  _key = [0, "rc4", _key, _serverKey] call client_fnc_encryptData;
  _data = "";
  {_data = _data + str _x} forEach CL_PROPS;
  if (_key isEqualTo _data) then {
    cl_statisticsLoaded = true;
    diag_log "DEBUG: Key was right";
  } else {
    [true] call _resetPlayer;
    cl_statisticsLoaded = true;
    diag_log "DEBUG: Key was wrong, altered variables detected, player reset";
  };
};
