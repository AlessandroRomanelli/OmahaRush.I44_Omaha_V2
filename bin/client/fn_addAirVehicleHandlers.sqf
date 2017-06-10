scriptName "fn_addAirVehicleHandlers";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_addAirVehicleHandlers.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_addAirVehicleHandlers.sqf"

_vehicle = param[0,objNull,[objNull]];
if (isNull _vehicle) exitWith {};

// Incoming missles
_vehicle addEventHandler ["IncomingMissile", {
	//cl_incoming_missle = (position player) nearestObject "M_Titan_AA"; // now handled via godmode :x
	[] spawn client_fnc_incomingMissile;
}];

// Damage when flares are deployed
_vehicle addEventHandler ["HandleDamage", {
	_projectileName = _this select 4;
	_damage = _this select 2;

	if (_projectileName == "M_Titan_AA" && ((_this select 0) getVariable ["tank_rockets", false])) then {
		_damage = damage (_this select 0);
	};

	// Return damage
	_damage
}];