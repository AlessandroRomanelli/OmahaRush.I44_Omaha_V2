scriptName "fn_getAllAmmoVehicles";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getAllAmmoVehicles.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getAllAmmoVehicles.sqf"
if (isServer && !hasInterface) exitWith {};

_configs = "true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles" >> "Attacker");
_configs = _configs + ("true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles" >> "Defender"));

_ret = [];

// Pushback vehicle names into array
{
	if ((_ret find (getText(_x >> "classname"))) == -1) then {
		_ret pushBack (getText(_x >> "classname"));
	};
} forEach _configs;

_ret