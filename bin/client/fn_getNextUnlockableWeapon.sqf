scriptName "fn_getNextUnlockableWeapon";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getNextUnlockableWeapon.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getNextUnlockableWeapon.sqf"
if (isServer && !hasInterface) exitWith {};

// Get all unlocks
_unlocks = "true" configClasses (missionConfigFile >> "Unlocks" >> player getVariable "gameSide");

// Lets look for the last item we unlocked
_lastUnlock = "";
_highest = 0;
{
	if (((getNumber(_x >> "exp")) > _highest && (getNumber(_x >> "exp")) < cl_exp)) then {
		_highest = (getNumber(_x >> "exp"));
		_lastUnlock = configName _x;
	};
} forEach _unlocks;

// Lets look for the next item we will unlock
_nextUnlock = "";
_lowest = 999999999999999999;
{
	if (((getNumber(_x >> "exp")) < _lowest && (getNumber(_x >> "exp")) > cl_exp)) then {
		_lowest = (getNumber(_x >> "exp"));
		_nextUnlock = configName _x;
	};
} forEach _unlocks;

// Now lets check if we found something
_bottomExp = 0;
if (_lastUnlock != "") then {
	_bottomExp = getNumber(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _lastUnlock >> "exp");
};

_topExp = 0;
if (_nextUnlock != "") then {
	_topExp = getNumber(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _nextUnlock >> "exp");
};

if (_topExp == 0) then {
	_topExp = _bottomExp;
};

// MATH SO COMPLICATED!??!
_expGained = (cl_exp - _bottomExp);
_totalExpRequired = (_topExp - _bottomExp);

[_expGained, _totalExpRequired, _nextUnlock]