scriptName "fn_refreshSpawnMenu";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_refreshSpawnMenu.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_refreshSpawnMenu.sqf"
#include "..\utils.h"

private _HQPos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> (sv_cur_obj getVariable ["cur_stage", "Stage1"]) >> "Spawns" >> GAMESIDE(player) >> "HQSpawn" >> "positionATL");
private _iconSize = 1.0;

private _makeCurrentSpawn = {
  params ["_pos", "_title"];
  private _progress = diag_tickTime % 1;
  drawIcon3D [WWRUSH_ROOT+"pictures\mark.paa", [0.66,1,0.66,0.5-(0.5*_progress)], _pos, 2+(1*_progress), 2+(1*_progress), 0, "", 0, 0.05, "PuristaMedium"];
  drawIcon3D [WWRUSH_ROOT+"pictures\mark.paa", [1,1,1,1], _pos, _iconSize, _iconSize, 0, "", 0, 0.05, "PuristaMedium"];
  drawIcon3D ["", [1,1,1,1], _pos, _iconSize, _iconSize, 0, _title, 2, 0.05, "PuristaMedium"];
  drawLine3D [_pos, getPos sv_cur_obj, [1,1,1,1]];
  private _leader = leader group player;
  if (player isEqualTo _leader) then {
	{
	  if (alive _x && {_x inArea playArea}) then {
		private _unitPos = _x modelToWorldVisual [0,0,1];
		drawLine3D [_pos, _unitPos, [1,1,1,0.5]];
	  };
	} forEach (units group player);
  } else {
	private _leaderPos = _leader modelToWorldVisual [0,0,1];
	{
	  if (alive _x && {_x inArea playArea}) then {
		private _unitPos = _x modelToWorldVisual [0,0,1];
		drawLine3D [_leaderPos, _unitPos, [1,1,1,0.5]];
	  };
	} forEach (units group player);
  };
  true
};

private _drawCurrentSpawn = {
	private _d = findDisplay 5000;
	private _ctrl = if ((lbCurSel (_d displayCtrl 8)) isEqualTo -1) then { _d displayCtrl 9 } else { _d displayCtrl 8 };
	// Abort if we haven't changed selected unit
	private _value = _ctrl lbValue (lbCurSel _ctrl);
	private _data = _ctrl lbData (lbCurSel _ctrl);
	if (_data isEqualTo "") exitWith {};
	if (_value isEqualTo -1) exitWith {
		private _spawnConfig = missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> sv_cur_obj getVariable ["cur_stage", "Stage1"] >> "Spawns" >> GAMESIDE(player) >> _data;
		private _pos = getArray(_spawnConfig >> "positionATL");
		private _name = getText(_spawnConfig >> "name");
		[_pos, _name] call _makeCurrentSpawn;
	};
	drawIcon3D [WWRUSH_ROOT+"pictures\mark.paa", [1,1,1,0.25], _HQPos, _iconSize, _iconSize, 0, "HQ", 0, 0.05, "PuristaMedium"];
	if (_value isEqualTo -2) exitWith {
		private _vehicle = missionNamespace getVariable [_data, objNull];
		if (isNull _vehicle) exitWith {};
		private _pos = _vehicle modelToWorldVisual [0,0,1];
		private _vehicleName = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
		private _crew = crew _vehicle;
		private _driverName = if (count _crew > 0) then {[_crew select 0] call client_fnc_getUnitName} else {""};
		private _title = [] call {
		if (count _crew isEqualTo 0) exitWith {
			_vehicleName
		};
		if (count _crew isEqualTo 1) exitWith {
			format["%1:%2", _vehicleName, _driverName];
		};
		if (count _crew > 1) exitWith {
			format["%1:%2+%3", _vehicle, _driverName, (count _crew)-1];
		};
		_vehicleName
		};
		[_pos, _title] call _makeCurrentSpawn;
	};
	private _unit = objectFromNetId _data;
	private _pos = _unit modelToWorldVisual [0,0,1];
	private _name = _unit getVariable ["name", name _unit];
	[_pos, _name] call _makeCurrentSpawn;
};

[] call _drawCurrentSpawn;
[] call client_fnc_displaySpawnRestriction;
[] call client_fnc_loadSpawnpoints;
[true] call client_fnc_spawnMenu_loadClasses;

true
