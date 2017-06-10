scriptName "fn_reloadFlares";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_reloadFlares.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_reloadFlares.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

_vehicle = param[0, objNull, [objNull]];

// Check if the flares have already been deployed
if (_vehicle getVariable ["flares_deployed", false]) exitWith {};

// Empty flares
//_vehicle setAmmo ["CMFlareLauncher", 0];
_vehicle setVariable ["flares_deployed", true];
_vehicle setVariable ["tank_rockets", true];

// Show display
285 cutRsc ["rr_reloadingFlares", "PLAIN"];

// Possible missle evaded

// Hide possible "incoming missile" screen
28 cutRsc ["default", "PLAIN"];

// Damage handling initialized in addAirVehicleHandlers

// Message
["Flares reloading"] spawn client_fnc_displayError;

// Get display
_d = uiNamespace getVariable ["rr_reloadingFlares", displayNull];

// Disallow player damage
player allowDamage false;

// Spawn flares
[_vehicle] spawn {
	_t = diag_tickTime;
	while {diag_tickTime - _t < 3.5} do {
		_flare = "CMflare_Chaff_Ammo" createVehicle (position player);
		_flare setVelocity [0,0,-10];
		sleep 0.5;
	};
	(_this select 0) setVariable ["tank_rockets", false];
	player allowDamage true;
};

// Our vehicle is not disabled
_vehicle setVariable ["disabled", false];

// Fill progress bar
_startTime = diag_tickTime;
_time = 30;
_endTime = diag_tickTime + _time;

while {diag_tickTime - _startTime <= _time} do {
	_percentage = (diag_tickTime - _startTime) / _time;
	(_d displayCtrl 0) progressSetPosition _percentage;
};

// Kill display
285 cutRsc ["default", "PLAIN"];

// Give us flares again
_vehicle setVariable ["flares_deployed", nil];

// Ay lmao text
["Flares ready"] spawn client_fnc_displayInfo;