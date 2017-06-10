scriptName "fn_loadSpawnpoints";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadSpawnpoints.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadSpawnpoints.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
_d = findDisplay 5000;

// Clear listbox of any spawnpoints
lbClear (_d displayCtrl 9);

// Load HQ spawnpoint
if (playerSide == WEST) then {
	(_d displayCtrl 9) lbAdd "Defender HQ";
} else {
	(_d displayCtrl 9) lbAdd "Attacker HQ";
};

// HQ Icon
(_d displayCtrl 9) lbSetPicture [(lbSize (_d displayCtrl 9)) - 1, "pictures\teammate.paa"];
(_d displayCtrl 9) lbSetValue [(lbSize (_d displayCtrl 9)) - 1, -1];
(_d displayCtrl 9) lbSetData [(lbSize (_d displayCtrl 9)) - 1, "HQ"];

// Load squad members
_index = -1;
{
	_index = _index + 1;

	if ((isPlayer _x && _x distance sv_cur_obj < 1500 && alive _x) || (_x == player) || (!isNull (_x getVariable ["recon_beacon_obj", objNUll]))) then {
		_add = false;

		if (alive _x) then {
			if (_x != player) then {
				if ((leader group player) == player) then {
					_add = true;
				} else {
					if (_x == (leader group player)) then {
						_add = true;
					};
				};
			};
		};

		_beacon = _x getVariable ["recon_beacon_obj", objNull];
		if (!isNull _beacon) then {
			_add = true;
		};

		if (_add) then {
			if (!isNull _beacon) then {
				// Spawn beacon
				(_d displayCtrl 9) lbAdd ((_x getVariable ["name",""]) + "'s Beacon");
				(_d displayCtrl 9) lbSetData [(lbSize (_d displayCtrl 9)) - 1, "beacon"];
				(_d displayCtrl 9) lbSetValue [(lbSize (_d displayCtrl 9)) - 1, _index];
			} else {
				// Player
				if (_x getVariable ["inCombat", false]) then {
					(_d displayCtrl 9) lbAdd ((_x getVariable ["name",""]) + " (IN COMBAT)");
					(_d displayCtrl 9) lbSetData [(lbSize (_d displayCtrl 9)) - 1, "inCombat"];
					(_d displayCtrl 9) lbSetValue [(lbSize (_d displayCtrl 9)) - 1, _index];
				} else {
					(_d displayCtrl 9) lbAdd (_x getVariable ["name",""]);
					(_d displayCtrl 9) lbSetValue [(lbSize (_d displayCtrl 9)) - 1, _index];
					(_d displayCtrl 9) lbSetData [(lbSize (_d displayCtrl 9)) - 1, ""];
				};
			};

			(_d displayCtrl 9) lbSetPicture [(lbSize (_d displayCtrl 9)) - 1, "pictures\squad.paa"];
		};
	};
} forEach (units group player);

// No selection made? Select 0
if (lbCurSel (_d displayCtrl 9) == -1) then {
	(_d displayCtrl 9) lbSetCurSel 0;
};

// Get configs of vehicles we can spawn at (PERSISTENT ONES)
_configs = [];
if (playerSide == WEST) then {
	_configs append ("true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles" >> "Defender"));
	_configs append ("true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Vehicles" >> "Defender"));
} else {
	_configs append ("true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles" >> "Attacker"));
	_configs append ("true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Vehicles" >> "Attacker"));
};

{
	_pos = getArray(_x >> "positionATL");
	_class = getText(_x >> "classname");
	_displayName = getText(_x >> "displayName");
	_objects = nearestObjects [_pos, [_class], 20];
	_config = _x;
	if (count _objects > 0) then {
		// Check whether this array of found vehicles actually containers our vehicle
		_OK = false;
		{
			if ((_x getVariable ["id", ""]) == (configName _config)) then {
				_OK = true;
			};
		} forEach _objects;

		if (_OK) then {
			(_d displayCtrl 9) lbAdd _displayName;
			(_d displayCtrl 9) lbSetData [(lbSize (_d displayCtrl 9)) - 1, configName _x];
			(_d displayCtrl 9) lbSetValue [(lbSize (_d displayCtrl 9)) - 1, -2];
			(_d displayCtrl 9) lbSetPicture [(lbSize (_d displayCtrl 9)) - 1, "pictures\teammate.paa"];
		};
	};
} forEach _configs;