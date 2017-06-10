scriptName "fn_moveUnitIntoVehicle";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_moveUnitIntoVehicle.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_moveUnitIntoVehicle.sqf"

_unit = param[0,objNull,[objNull]];
_vehicle = param[1,objNull,[objNull]];

// wow
if (isNull _unit || isNull _vehicle) exitWith {false};

// try i guess
_ret = false;

if (!_ret) then {
	_unit moveInDriver _vehicle;
	sleep 0.1;
	if (vehicle _unit != _unit) then {_ret = true};
};
if (!_ret) then {
	_unit moveInGunner _vehicle;
	sleep 0.1;
	if (vehicle _unit != _unit) then {_ret = true};
};
if (!_ret) then {
	_unit moveInCommander _vehicle;
	sleep 0.1;
	if (vehicle _unit != _unit) then {_ret = true};
};
if (!_ret) then {
	_unit moveInCargo _vehicle;
	sleep 0.1;
	if (vehicle _unit != _unit) then {_ret = true};
};

_ret