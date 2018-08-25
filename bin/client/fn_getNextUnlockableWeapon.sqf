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
private _unlocks = "true" configClasses (missionConfigFile >> "Unlocks" >> player getVariable "gameSide");

private _exp = missionNamespace getVariable [format["cl_exp_%1", cl_class], 0];
private _maxExp = selectMax [cl_exp_assault, cl_exp_medic, cl_exp_engineer, cl_exp_support, cl_exp_recon];

// Lets look for the last item we unlocked
private _lastUnlock = "";
private _highest = 0;
{
	if (((getNumber(_x >> "exp")) > _highest) && ((getNumber(_x >> "exp")) < _exp) && (cl_class in (getArray(_x >> "roles")))) then {
		_highest = (getNumber(_x >> "exp"));
		_lastUnlock = configName _x;
	};
} forEach _unlocks;

// Lets look for the next item we will unlock
private _nextUnlock = "";
private _lowest = 999999999999999999;
{
	if (((getNumber(_x >> "exp")) < _lowest) && ((getNumber(_x >> "exp")) > _exp) && (cl_class in (getArray(_x >> "roles")))) then {
		if !(((getText(_x >> "type")) isEqualTo "secondary") && ((getNumber(_x >> "exp")) < _maxExp)) then {
			_lowest = (getNumber(_x >> "exp"));
			_nextUnlock = configName _x;
		};
	};
} forEach _unlocks;

// Now lets check if we found something
private _bottomExp = 0;
if (_lastUnlock != "") then {
	_bottomExp = getNumber(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _lastUnlock >> "exp");
};

private _topExp = 0;
if (_nextUnlock != "") then {
	_topExp = getNumber(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _nextUnlock >> "exp");
};

if (_topExp == 0) then {
	_topExp = _bottomExp;
};

// MATH SO COMPLICATED!??!
private _expGained = (_exp - _bottomExp);
private _totalExpRequired = (_topExp - _bottomExp);

[_expGained, _totalExpRequired, _nextUnlock]
