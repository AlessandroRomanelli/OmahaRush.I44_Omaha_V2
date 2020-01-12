scriptName "fn_updateMarkers";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_updateMarkers.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateMarkers.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};


private _objMarkerStatusUpdate = param[0, false, [false]];

private _spawnsConfig = (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> (sv_cur_obj getVariable ["cur_stage", "Stage1"]) >> "Spawns");
private _spawns = "true" configClasses (_spawnsConfig >> GAMESIDE(player));

private _idx = _spawns findIf {configName _x == "HQSpawn"};
_spawns deleteAt _idx;

if (!isNil "cl_spawnMarkers") then {
	{ deleteMarkerLocal _x } forEach cl_spawnMarkers;
};
cl_spawnMarkers = [];

if (!isNil "cl_ammoboxMarkers") then {
	{ deleteMarkerLocal _x } forEach cl_ammoboxMarkers;
};

cl_ammoboxMarkers = [];
{
	private _marker = "";
	if (_x inArea playArea) then {
		_marker = createMarkerLocal [format["ammobox_%1", _forEachIndex], getPos _x];
		_marker setMarkerTypeLocal "o_Ordnance";
		_marker setMarkerTextLocal "Ammo";
		_marker setMarkerColorLocal "ColorWhiteAlpha";
		_marker setMarkerSizeLocal [0.66, 0.66];
		cl_ammoboxMarkers pushBack _marker;
	};

} forEach allMissionObjects AMMOBOX_CLASSNAME;

{
	private _markerName = configName _x;
	createMarkerLocal [_markerName, getArray(_x >> "positionATL")];
	_markerName setMarkerTypeLocal "respawn_inf";
	_markerName setMarkerTextLocal (getText(_x >> "name"));
	_markerName setMarkerSizeLocal [0.75, 0.75];
	cl_spawnMarkers pushBack _markerName;
} forEach _spawns;

if !(_objMarkerStatusUpdate) exitWith {
	private _atkMarker = getText(missionConfigFile >> "Vehicles" >> "Attacker" >> "marker");
	private _atkFaction = getText(missionConfigFile >> "Vehicles" >> "Attacker" >> "faction");
	private _defMarker = getText(missionConfigFile >> "Vehicles" >> "Defender" >> "marker");
	private _defFaction = getText(missionConfigFile >> "Vehicles" >> "Defender" >> "faction");
	private _HQposDef = getArray(_spawnsConfig >> DEFEND_STR >> "HQSpawn" >> "positionATL");
	private _HQposAtk = getArray(_spawnsConfig >> ATTACK_STR >> "HQSpawn" >> "positionATL");
	"mobile_respawn_defenders" setMarkerPosLocal _HQposDef;
	"mobile_respawn_attackers" setMarkerPosLocal _HQposAtk;

	if (IS_DEFENDING(player)) then {
		cl_enemySpawnMarker = "";
		"mobile_respawn_defenders" setMarkerTypeLocal _defMarker;
		"mobile_respawn_defenders" setMarkerTextLocal (format[" Defenders HQ (%1)", _defFaction]);

		"mobile_respawn_attackers" setMarkerTypeLocal _atkMarker;
		"mobile_respawn_attackers" setMarkerTextLocal (format[" Attackers HQ (%1)", _atkFaction]);
	} else {
		"mobile_respawn_defenders" setMarkerTypeLocal _defMarker;
		"mobile_respawn_defenders" setMarkerTextLocal (format[" Defenders HQ (%1)", _defFaction]);

		"mobile_respawn_attackers" setMarkerTypeLocal _atkMarker;
		"mobile_respawn_attackers" setMarkerTextLocal (format[" Attackers HQ (%1)", _atkFaction]);
	};
	"mobile_respawn_defenders" setMarkerSizeLocal [2, 1];
	"mobile_respawn_attackers" setMarkerSizeLocal [2, 1];

	"objective" setMarkerPosLocal (getPos sv_cur_obj);
	true
};

"objective" setMarkerColorLocal "ColorBlack";
"objective" setMarkerTextLocal " Objective";

private _status = sv_cur_obj getVariable ["status", OBJ_STATUS_UNARMED];
if (_status isEqualTo OBJ_STATUS_IN_USE) then {
	"objective" setMarkerColorLocal "ColorOrange";
	"objective" setMarkerTextLocal " Objective (ARMING)";
};
if (_status isEqualTo OBJ_STATUS_ARMED) then {
	"objective" setMarkerColorLocal "ColorRed";
	"objective" setMarkerTextLocal " Objective (ARMED)";
};


true
