scriptName "fn_validateEquipment";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_validateEquipment.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_validateEquipment.sqf"
if (isServer && !hasInterface) exitWith {};

// Inline function to find equip by classname in configuration array
_find = {
	_class = param[0,"",[""]];
	_ret = [];
	{
		if (_x == _class) then {
			_ret = _x;
		};
	} forEach cl_equipConfigurations;

	_ret
};

// Cycle through all unlocked weapons and check if they exit in the equip array, if not, add them
if (count cl_equipConfigurations != 0) then {
	// Get all unlockable weapons
	_configs = "true" configClasses (missionConfigFile >> "Unlocks" >> player getVariable "gameSide");

	// Populate cl_equipConfigurations with all possible weapons
	for "_i" from 0 to (count _configs - 1) step 1 do
	{
		if (getNumber((_configs select _i) >> "exp") <= cl_exp && count ([(configName (_configs select _i))] call _find) == 0) then {
			// Weapon has been unlocked, display it
			/* _item = [
				configName (_configs select _i), // Weapon classname
				["","",""],	// No attachments equipped
				[] // No attachments unlocked
			]; */

			_item = configName (_configs select _i);

			// Pushback into configuration pool
			cl_equipConfigurations pushBack _item;
		};
	};
};

// Cycle through all unlocked weapons and check if they should be unlocked // This prevents users from having weapons which are pushed to a different exp level
if (sv_usingDatabase) then {
	_validatedArray = [];

	{
		_classname = _x;

		// Check if unlocked
		_isConfig = isClass(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _classname);
		_isUnlocked = (getNumber(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _classname >> "exp")) <= cl_exp;
		_isRightClass = cl_class in (getArray(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _classname >> "roles"));

		if (_isConfig && _isUnlocked && _isRightClass) then {
			_validatedArray pushBack _x;
		};
	} forEach cl_equipConfigurations;

	cl_equipConfigurations = _validatedArray;
};
