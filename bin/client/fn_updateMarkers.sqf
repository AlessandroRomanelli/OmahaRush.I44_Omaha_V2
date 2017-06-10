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

_updateRestrictedZonesNow = param[0,false,[false]];

_HQPos1 = getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> "defenders");
_HQPos2 = getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> "attackers");
"mobile_respawn_west" setMarkerPosLocal _HQPos1;
"mobile_respawn_independent" setMarkerPosLocal _HQPos2;
"objective" setMarkerPosLocal getPos sv_cur_obj;

// After 30 seconds update the areas we are not allowed to enter
if (!_updateRestrictedZonesNow && ((side (group player) == WEST))) then {
	sleep (getNumber(missionConfigFile >> "GeneralConfig" >> "FallBackSeconds"));
};

// Update enemy base marker name
cl_enemySpawnMarker = if ((side (group player)) == WEST) then {"mobile_respawn_independent"} else {"mobile_respawn_west"};
