scriptName "fn_countAssist";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_countAssist.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_countAssist.sqf"
if (isServer && !hasInterface) exitWith {};

private _causedBy = param[0,objNull,[objNull]];
private _inflictedDamage = param[1,0,[0]];

// Make sure the damage isnt small
if (_inflictedDamage < 0.05) exitWith {};

if (_inflictedDamage > 1) then {_inflictedDamage = (_inflictedDamage / 100);};

if (isNull _causedBy) exitWith {};
if (isNil "cl_assistsInfo") exitWith {};

// Check the side
private _side = _causedBy getVariable ["side", sideUnknown];

// Bad side
if (_side == (player getVariable ["side", sideUnknown]) || _side == sideUnknown) exitWith {};

// Damage has to be greater than 15 to be counted as an assist
if (_inflictedDamage < 0.15) exitWith {};

// Iterate through our existing assistsInfo array and check whether this unit has already an entry in it
private _existingEntry = false;
{
	if ((_x select 0) == _causedBy) then {
		_x set [1, (_x select 1) + _inflictedDamage];
		_existingEntry = true;
	};
} forEach cl_assistsInfo;

// Huh?
if (_existingEntry) exitWith {};

// Pushback!
cl_assistsInfo pushBack [_causedBy, _inflictedDamage];
