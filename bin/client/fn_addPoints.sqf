scriptName "fn_addPoints";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A. Roman
    File: fn_addPoints.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_addPoints.sqf"
if (isServer && !hasInterface) exitWith {};

private _toAdd = param[0,0,[0]];

// Get list of unlocked weapons before and after exp have been added
private _before = +cl_equipConfigurations;

// Add exp
cl_points = cl_points + _toAdd; // Round based exp
private _class = player getVariable ["class", "assault"];
private _exp = missionNamespace getVariable [format["cl_exp_%1", _class], 0];
missionNamespace setVariable [format["cl_exp_%1", _class], _exp + _toAdd];
/* cl_exp = cl_exp + _toAdd; */

// Lets share our stats with the others
player setVariable ["points",cl_points,true];

// Add exp for validation if we have less than 6 players online
if (count AllPlayers <= 6) then {
	cl_pointsBelowMinimumPlayers = cl_pointsBelowMinimumPlayers + _toAdd;
};

// Validate points earned
[] spawn client_fnc_validatePointsEarned;

// Validate equipment
[] call client_fnc_validateEquipment;
private _after = +cl_equipConfigurations;

if (count _before != count _after) then {
	private _unlockedWeapons = [];
	{
		private _toCheck = _x;
		private _found = _toCheck in _before;

		// Not found? Unlocked!
		if (!_found) then {
			_unlockedWeapons pushBack _x;
		};
	} forEach _after;

	private _unlockedClassnames = _unlockedWeapons;

	// Display unlocked weapons
	{
		[_x] spawn client_fnc_displayUnlockWeapon;
		sleep 5.5;
	} forEach _unlockedClassnames;
};

// Generate timeline event
cl_timelineevents
