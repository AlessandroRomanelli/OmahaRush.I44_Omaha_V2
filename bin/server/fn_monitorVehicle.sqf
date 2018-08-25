scriptName "fn_monitorVehicle";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_monitorVehicle.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_monitorVehicle.sqf"

private _vehicle = param[0, objNull, [objNull]];

// Wait until a unit is in the vehicle
waitUntil {{alive _x} count (crew _vehicle) > 0 || (!alive _vehicle)};

if (_vehicle isKindOf "Air") then {
	_vehicle enableSimulationGlobal true;
	[_vehicle] spawn {
		private _vehicle = param[0, objNull, [objNull]];
		private _side = ["Attacker", "Defender"] select ((player getVariable ["gameSide", "defenders"]) isEqualTo "defenders");
		private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> _side);
		_configs = _configs select {(getText(_x >> "className")) isEqualTo (typeOf _vehicle)};
		if (count _configs != 0) then {
			private _fuelTime = getNumber((_configs select 0) >> "fuelTime");
			private _time = _fuelTime;
			while {_time >= 0} do {
				_vehicle setFuel (_time/_fuelTime);
				sleep 1;
				_time = _time - 1;
			};
		};
	};
};

// Now wait until all units have left the vehicle
waitUntil {{alive _x} count (crew _vehicle) == 0 || (!alive _vehicle)};

// Wait 45 seconds
private _start = diag_tickTime;
private _exit = false;

while {diag_tickTime - _start < 35 && !_exit && (alive _vehicle)} do {
	sleep 1;
	// Did units get into the vehicle again?
	if ({alive _x} count (crew _vehicle) > 0) then {
		// Units inside the vehicle, relaunch the script and kill this one
		[_vehicle] spawn server_fnc_monitorVehicle;
		_exit = true;
	};
};

// If the vehicle is alive, has no units in it (_exit == false)
if (!_exit && (alive _vehicle)) then {
	deleteVehicle _vehicle;
};
