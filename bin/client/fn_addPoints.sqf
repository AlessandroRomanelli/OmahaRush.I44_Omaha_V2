scriptName "fn_addPoints";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_addPoints.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_addPoints.sqf"
if (isServer && !hasInterface) exitWith {};

_toAdd = param[0,0,[0]];

// Get list of unlocked weapons before and after exp have been added
_before = +cl_equipConfigurations;

// Add exp
_exp = cl_exp;
cl_points = cl_points + _toAdd; // Round based exp
cl_exp = cl_exp + _toAdd;

// Lets share our stats with the others
player setVariable ["kills",cl_kills,true];
player setVariable ["deaths",cl_deaths,true];
player setVariable ["points",cl_points,true];

// Add exp for validation if we have less than 6 players online
if (count AllPlayers <= 6) then {
	cl_pointsBelowMinimumPlayers = cl_pointsBelowMinimumPlayers + _toAdd;
};

// Validate points earned
[] spawn client_fnc_validatePointsEarned;

// Validate equipment
[] call client_fnc_validateEquipment;
_after = +cl_equipConfigurations;

if (count _before != count _after) then {
	_unlockedWeapons = [];
	{
		_toCheck = _x select 0;
		_found = false;
		{
			if (_toCheck == (_x select 0)) then {
				_found = true;
			};
		} forEach _before;

		// Not found? Unlocked!
		if (!_found) then {
			_unlockedWeapons pushBack _x;
		};
	} forEach _after;

	_unlockedClassnames = [];
	{
		_unlockedClassnames pushBack (_x select 0);
	} forEach _unlockedWeapons;

	// Display unlocked weapons
	{
		[_x] spawn client_fnc_displayUnlockWeapon;
		sleep 5.5;
	} forEach _unlockedClassnames;
};

_unlockedAttachments = [];

// Check if we passed the 5000 points mark to unlock an attachment
for "_i" from _exp to (_exp + _toAdd) step 1 do
{
	if ((_i mod 2300) == 0 && _i != 0) then {
		_unlockedInfo = [] call client_fnc_unlockAttachment;
		if (count _unlockedInfo > 0) then {
			_unlockedAttachments pushBack _unlockedInfo;
		};
	};
};

{
	diag_log str _x;
	[_x] spawn client_fnc_displayUnlockAttachment;
	sleep 5.5;
} forEach _unlockedAttachments;

// Generate timeline event
cl_timelineevents
