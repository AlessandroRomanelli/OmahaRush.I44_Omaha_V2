scriptName "fn_selectNextMap";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_selectNextMap.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_selectNextMap.sqf"

private _valid = params [["_nextMission", "", [""]]];
if (!_valid) exitWith {};

sv_nextMap = _nextMission;

/* private _mapName = getText(configFile >> "CfgWorlds" >> ((_nextMission splitString ".") select 1) >> "description");

if (isRemoteExecuted) then {
	[[_mapName], {
		params [["_mapName", "", [""]]];
		((findDisplay 7000) displayCtrl 1000) ctrlSetText (format ['Next map: %1', _mapName]);
	}] remoteExecCall ["call", remoteExecutedOwner];
}; */
