scriptName "fn_updateMarkers";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_updateMarkers.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateMarkers.sqf"
if (isServer && !hasInterface) exitWith {};

private _objMarkerStatusUpdate = param[0, false, [false]];

if !(_objMarkerStatusUpdate) then {
	private _atkMarker = getText(missionConfigFile >> "Vehicles" >> "Attacker" >> "marker");
	private _atkFaction = getText(missionConfigFile >> "Vehicles" >> "Attacker" >> "faction");
	private _defMarker = getText(missionConfigFile >> "Vehicles" >> "Defender" >> "marker");
	private _defFaction = getText(missionConfigFile >> "Vehicles" >> "Defender" >> "faction");
	private _HQposDef = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> "defenders" >> "HQSpawn" >> "positionATL");
	private _HQposAtk = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> "attackers" >> "HQSpawn" >> "positionATL");
	"mobile_respawn_defenders" setMarkerPosLocal _HQposDef;
	"mobile_respawn_attackers" setMarkerPosLocal _HQposAtk;

	if (player getVariable "gameSide" == "defenders") then {
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

	"objective" setMarkerPosLocal getPos sv_cur_obj;
} else {
	private _status = sv_cur_obj getVariable ["status", -1];
	if (_status isEqualTo -1) exitWith {
		"objective" setMarkerColorLocal "ColorBlack";
		"objective" setMarkerTextLocal " Objective";
	};
	if (_status isEqualTo 0) exitWith {
		"objective" setMarkerColorLocal "ColorOrange";
		"objective" setMarkerTextLocal " Objective (ARMING)";
	};
	if (_status isEqualTo 1) exitWith {
		"objective" setMarkerColorLocal "ColorRed";
		"objective" setMarkerTextLocal " Objective (ARMED)";
	};
	"objective" setMarkerColorLocal "ColorBlack";
	"objective" setMarkerTextLocal " Objective";
};
true
