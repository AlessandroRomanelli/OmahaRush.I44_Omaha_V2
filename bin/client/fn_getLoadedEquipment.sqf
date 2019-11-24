scriptName "fn_getLoadedEquipment";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A.Roman
    File: fn_getLoadedEquipment.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getLoadedEquipment.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

cl_equipConfigurations = [];

// Get loaded equipment
// Returns default if nothing was selected

// Get all unlockable weapons
private _side = ["attackers", "defenders"] select (player getVariable ["side", side player] == WEST);
private _configs = "true" configClasses (missionConfigFile >> "Unlocks" >> _side);
{
	private _weapon = _x;
	private _valid = _configs findIf {(configName _x) isEqualTo _weapon};
	if (_valid < 0) then {
		cl_equipClassnames set [_forEachIndex, ""];
	};
} forEach cl_equipClassnames;

private _maxExp = selectMax [cl_exp_assault, cl_exp_medic, cl_exp_engineer, cl_exp_support, cl_exp_recon];
// Populate cl_equipConfigurations with all possible weapons
VARIABLE_DEFAULT(sv_setting_DebugMode, 0);
private _isDebug = sv_setting_DebugMode == 1;
if (_isDebug) then {
	cl_equipConfigurations = _configs apply {configName _x};
} else {
	{
		private _exp = missionNamespace getVariable [format["cl_exp_%1", cl_class], 0];
		if ((getNumber(_x >> "exp") <= _exp) || (((getText(_x >> "type")) isEqualTo "secondary") && (_maxExp > (getNumber(_x >> "exp"))))) then {

			private _item = configName _x;

			// If no default equipped classname has been set yet
			if ((getText(_x >> "type") == "primary") && {(cl_equipClassnames select 0) == ""} && {cl_class in getArray(_x >> "roles")}) then {
				cl_equipClassnames set [0, _item];
			};
			if ((getText(_x >> "type") == "secondary") && {(cl_equipClassnames select 1) == ""}) then {
				cl_equipClassnames set [1, _item];
			};

			// Pushback into configuration pool
			cl_equipConfigurations pushBackUnique _item;
		};
	} forEach _configs;
};

player setVariable ["loaded_equipment", [cl_equipClassnames select 0, cl_equipClassnames select 1]];

// Return
[cl_equipClassnames select 0, cl_equipClassnames select 1];
