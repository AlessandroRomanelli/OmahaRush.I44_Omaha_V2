scriptName "fn_getLoadedEquipment";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A.Roman
    File: fn_getLoadedEquipment.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getLoadedEquipment.sqf"
if (isServer && !hasInterface) exitWith {};

if (isNil "cl_equipConfigurations") then {
	cl_equipConfigurations = [];
};

// Get loaded equipment
// Returns default if nothing was selected
if (count cl_equipConfigurations == 0) then {
	// Get all unlockable weapons
	private _configs = "true" configClasses (missionConfigFile >> "Unlocks" >> player getVariable "gameSide");

	// Populare cl_equipConfigurations with all possible weapons
	for "_i" from 0 to (count _configs - 1) step 1 do
	{
		// All weapons cheat
		private _allWeapons = false;
		/* if (!sv_usingDatabase) then {
			_allWeapons = true;
		}; */

		if (getNumber((_configs select _i) >> "exp") <= cl_exp || _allWeapons) then {

			private _item = configName (_configs select _i);

			// If no default equipped classname has been set yet
			if (getText((_configs select _i) >> "type") == "primary" && (cl_equipClassnames select 0) == "" && cl_class in getArray((_configs select _i) >> "roles")) then {
				cl_equipClassnames set[0, configName (_configs select _i)];
			};
			if (getText((_configs select _i) >> "type") == "secondary" && (cl_equipClassnames select 1) == "") then {
				cl_equipClassnames set[1, configName (_configs select _i)];
			};

			// Pushback into configuration pool
			cl_equipConfigurations pushBack _item;
		};
	};
};

// Return
[cl_equipClassnames select 0, cl_equipClassnames select 1];
