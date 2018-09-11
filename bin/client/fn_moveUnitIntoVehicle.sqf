scriptName "fn_moveUnitIntoVehicle";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_moveUnitIntoVehicle.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_moveUnitIntoVehicle.sqf"

params [["_vehicle", objNull, [objNull]]];

// wow
if (isNull _vehicle) exitWith {false};

if (_vehicle isKindOf "Air") then {
	_vehicle enableSimulation true;
	_vehicle setVectorUp [0,0,1];
	private _dir = getDir _vehicle;
	private _velocity = [(sin _dir)*55, (cos _dir)*55, 0];
	_vehicle setVelocity _velocity;
	private _side = ["Attacker", "Defender"] select ((player getVariable ["gameSide", "defenders"]) isEqualTo "defenders");
	private _config = missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> _side >> str _vehicle;
	private _fuelTime = getNumber(_config >> "fuelTime");
	[format["YOU HAVE %1 SECONDS WORTH OF FUEL, BE QUICK!", _fuelTime]] spawn client_fnc_displayInfo;
};

private ["_return"];
player moveInAny _vehicle;
_vehicle enableSimulation true;

if (vehicle player != _vehicle) then { _return = false } else { _return = true; };

_return
