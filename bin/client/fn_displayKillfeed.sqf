scriptName "fn_displayKillfeed";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayKillfeed.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayKillfeed.sqf"
if (isServer && !hasInterface) exitWith {};

private _unit = param[0,objNull,[objNull]];
private _killer = param[1,objNull,[objNull]];
private _grenade = param[2,"",[""]];
private _wasMelee = param[3, false, [false]];

if (isNil "cl_killfeed") exitWith {};

// Limit killfeed
if (count cl_killfeed >= 5) then {
	cl_killfeed deleteAt 0;
};

private _reason = "";

if (_grenade != "") then {
	_reason = _grenade;
} else {
	private _possibleTurrentIndex = -2;
	if ((vehicle _killer) != _killer) then {
		private _v = vehicle _killer;

		// Check if we are the driver
		if ((driver _v) == _killer) then {
			_possibleTurrentIndex = -1;
		};

		// Check if we are the gunner
		if ((gunner _v) == _killer) then {
			_possibleTurrentIndex = 0;
		};
	};

	// Pushback into render array
	_reason = if (_possibleTurrentIndex in [-1, 0]) then {
		currentWeapon (vehicle _killer)
	} else {
		currentWeapon _killer
	};

	if ((toLower _reason) in ["put", "throw"]) then {
		_reason = primaryWeapon (vehicle _killer);
	};
};

cl_killfeed pushBack [_killer, _reason, _unit, _wasMelee];

// Render the killfeed and remove it later on again :)
[] call client_fnc_renderKillfeed;
sleep 7;
cl_killfeed deleteAt 0;
[] call client_fnc_renderKillfeed;
