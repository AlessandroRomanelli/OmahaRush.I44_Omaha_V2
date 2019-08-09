scriptName "fn_validateEquipment";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_validateEquipment.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_validateEquipment.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

// Inline function to find equip by classname in configuration array
private _find = {
	private _class = param[0,"",[""]];
	private _ret = "";
	{
		if (_x == _class) then {
			_ret = _x;
		};
	} forEach cl_equipConfigurations;

	_ret
};

private _exp = missionNamespace getVariable [format["cl_exp_%1", cl_class], 0];
VARIABLE_DEFAULT(sv_setting_DebugMode, 0);
private _isDebug = sv_setting_DebugMode == 1;

// Cycle through all unlocked weapons and check if they exit in the equip array, if not, add them
if (count cl_equipConfigurations != 0) then {
	// Get all unlockable weapons
	private _configs = "true" configClasses (missionConfigFile >> "Unlocks" >> player getVariable "gameSide");
	private _maxExp = selectMax [cl_exp_assault, cl_exp_medic, cl_exp_engineer, cl_exp_support, cl_exp_recon];
	// Populate cl_equipConfigurations with all possible weapons
	if (_isDebug) then {
		cl_equipConfigurations = _configs apply {configName _x};
	} else {
		{
			if ((getNumber(_x >> "exp") <= _exp) || ((getText(_x >> "type") isEqualTo "secondary") && (_maxExp > getNumber(_x >> "exp")))) then {
				// Weapon has been unlocked, display it
				/* _item = [
					configName (_configs select _i), // Weapon classname
					["","",""],	// No attachments equipped
					[] // No attachments unlocked
				]; */
				// Pushback into configuration pool
				cl_equipConfigurations pushBackUnique (configName _x);
			};
		} forEach _configs;
	};
};

// Cycle through all unlocked weapons and check if they should be unlocked // This prevents users from having weapons which are pushed to a different exp level
/* if (sv_usingDatabase) then { */
if (true) then {
	private _validatedArray = [];
	{
		// Check if unlocked
		private _isConfig = isClass(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x);
		private _isUnlocked = (getNumber(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x >> "exp")) <= _exp;
		private _isRightClass = cl_class in (getArray(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x >> "roles"));

		if (_isDebug || {_isConfig && _isUnlocked && _isRightClass}) then {
			_validatedArray pushBackUnique _x;
		};
	} forEach cl_equipConfigurations;

	cl_equipConfigurations = _validatedArray;
};

true
