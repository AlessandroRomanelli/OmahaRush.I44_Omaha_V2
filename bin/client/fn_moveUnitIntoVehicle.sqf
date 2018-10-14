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

private ["_return"];
player moveInAny _vehicle;

_return = if (vehicle player == _vehicle) then {true} else {true};

_return
