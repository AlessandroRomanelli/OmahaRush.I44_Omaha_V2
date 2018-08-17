scriptName "fn_moveUnitIntoVehicle";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_moveUnitIntoVehicle.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_moveUnitIntoVehicle.sqf"

params [["_unit", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];

// wow
if (isNull _unit || isNull _vehicle) exitWith {false};

if (_vehicle isKindOf "Air") then {
	private _side = ["Attacker", "Defender"] select ((player getVariable ["gameSide", "defenders"]) isEqualTo "defenders");
	private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> _side);
	_configs = _configs select {(getText(_x >> "className")) isEqualTo (typeOf _vehicle)};
	if (count _configs != 0) then {
		private _fuelTime = getNumber(_configs select 0 >> "fuelTime");
		[format["YOU HAVE %1 SECONDS WORTH OF FUEL, BE QUICK!", _fuelTime]] spawn client_fnc_displayInfo;
	};
};

// try i guess
private _ret = false;

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

_vehicle enableSimulation true;

_ret
