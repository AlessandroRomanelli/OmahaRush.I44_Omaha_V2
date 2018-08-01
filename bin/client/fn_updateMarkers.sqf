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

_objMarkerStatusUpdate = param[0, false, [false]];

if !(_objMarkerStatusUpdate) then {
	_HQPos1 = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> "defenders");
	_HQPos2 = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> "attackers");
	"mobile_respawn_defenders" setMarkerPosLocal _HQPos1;
	"mobile_respawn_attackers" setMarkerPosLocal _HQPos2;

	if (player getVariable "gameSide" == "defenders") then {
		cl_enemySpawnMarker = "";
		"mobile_respawn_defenders" setMarkerTypeLocal "b_unknown";
		"mobile_respawn_defenders" setMarkerTextLocal " Defenders HQ";

		"mobile_respawn_attackers" setMarkerTypeLocal "o_unknown";
		"mobile_respawn_attackers" setMarkerTextLocal " Attackers HQ";
	} else {
		"mobile_respawn_defenders" setMarkerTypeLocal "o_unknown";
		"mobile_respawn_defenders" setMarkerTextLocal " Defenders HQ";

		"mobile_respawn_attackers" setMarkerTypeLocal "b_unknown";
		"mobile_respawn_attackers" setMarkerTextLocal " Attackers HQ";
	};

	"objective" setMarkerPosLocal getPos sv_cur_obj;
} else {
	_status = sv_cur_obj getVariable ["status", -1];
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
