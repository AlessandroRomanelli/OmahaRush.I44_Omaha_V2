scriptName "fn_getRandomMap";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getRandomMap.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getRandomMap.sqf"

if (isNil "sv_map") then {
	sv_map = "";
};

_newMap = sv_map;

while {sv_map == _newMap} do { // Make sure its not the same map
	_newMap = configName (selectRandom ("true" configClasses (missionConfigFile >> "Maps")));
	if (count ("true" configClasses (missionConfigFile >> "Maps")) == 1) exitWith {
		sv_map = _newMap;
	};
};

// Return
_newMap