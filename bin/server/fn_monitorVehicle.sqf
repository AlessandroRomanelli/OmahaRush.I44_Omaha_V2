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
};

// Now wait until all units have left the vehicle
waitUntil {{alive _x} count (crew _vehicle) == 0 || (!alive _vehicle)};

// Wait 45 seconds
private _start = diag_tickTime;
private _exit = false;

while {diag_tickTime - _start < 35 && !_exit && (alive _vehicle)} do {
	uiSleep 1;
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
