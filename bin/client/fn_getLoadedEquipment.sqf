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

	private _maxExp = selectMax [cl_exp_assault, cl_exp_medic, cl_exp_engineer, cl_exp_support, cl_exp_recon];
	// Populate cl_equipConfigurations with all possible weapons
	{
		private _exp = missionNamespace getVariable [format["cl_exp_%1", cl_class], 0];
		if ((getNumber(_x >> "exp") <= _exp) || (((getText(_x >> "type")) isEqualTo "secondary") && (_maxExp > (getNumber(_x >> "exp"))))) then {

			private _item = configName _x;

			// If no default equipped classname has been set yet
			if ((getText(_x >> "type") == "primary") && {(cl_equipClassnames select 0) == ""} && {cl_class in getArray(_x >> "roles")}) then {
				cl_equipClassnames set[0, configName _x];
			};
			if ((getText(_x >> "type") == "secondary") && {(cl_equipClassnames select 1) == ""}) then {
				cl_equipClassnames set[1, configName _x];
			};

			// Pushback into configuration pool
			cl_equipConfigurations pushBackUnique _item;
		};
	} forEach _configs;
};

// Return
[cl_equipClassnames select 0, cl_equipClassnames select 1];
