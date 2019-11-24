scriptName "fn_MCOMdestroyed";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_MCOMarmed.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MCOMdestroyed.sqf"
#include "..\utils.h"

WAIT_IF_NOT(cl_init_done);


if (isServer && !hasInterface) exitWith {};

// Warning
["THE OBJECTIVE HAS BEEN DESTROYED"] call client_fnc_displayObjectiveMessage;

// Clean our spawnbeacons
private _beacon = player getVariable ["assault_beacon_obj", objNull];
if (!isNull _beacon) then {
	deleteVehicle _beacon;
};

// Update spawn cam
[] call client_fnc_updateSpawnMenuCam;

// Animation
private _animate = {
	disableSerialization;
	private _c = (uiNamespace getVariable ["rr_objective_gui",displayNull]) displayCtrl 0;

	// Get pos
	private _pos = ctrlPosition _c;

	// Move to new position
	_c ctrlSetPosition [0.443281 * safezoneW + safezoneX, 0.203 * safezoneH + safezoneY, 0.108281 * safezoneW, 0.187 * safezoneH];
	_c ctrlCommit 0.25;
	uiSleep 6.5;

	// Move to old pos
	_c ctrlSetPosition _pos;
	_c ctrlCommit 0.25;
};

params [["_moreMcoms", false, [false]]];
// Param is TRUE if the just destroyed mcom was NOT the last one
if (_moreMcoms) then {
	private _fallBackTime = [] call client_fnc_getFallbackTime;

	// Update markers
	[] call client_fnc_updateMarkers;

	private _side = player getVariable ["side", side player];
	private _isPlayerAttacking = (_side isEqualTo EAST);

	// If we are attacker, block the next mcom for now
	if (_isPlayerAttacking) then {
		cl_enemySpawnMarker = "objective";
	} else {
		// FallingBack flag in order to handle out of bounds kill time
		player setVariable ["isFallingBack", true];
	};

	uiSleep 3;
	[format["DEFENDERS HAVE %1 SECONDS TO FALL BACK", _fallBackTime]] call client_fnc_displayObjectiveMessage;

	if (!_isPlayerAttacking) then {
		[playArea, (_fallBackTime-3)] call client_fnc_updateRestrictions;
	};

	uiSleep (_fallBackTime-3);
	if (_isPlayerAttacking) then {
		["NEW OBJECTIVE HAS BEEN ASSIGNED, PUSH!"] call client_fnc_displayObjectiveMessage;
	} else {
		["NEW OBJECTIVE HAS BEEN ASSIGNED, DEFEND!"] call client_fnc_displayObjectiveMessage;
		player setVariable ["isFallingBack", false];
	};

	private _gameSide = ["defenders", "attackers"] select _isPlayerAttacking;
	private _faction = getText(missionConfigFile >> "Unlocks" >> _gameSide >> "faction");
	private _idx = (floor (random 4))+1;
	playSound format["%1Order%2_%3", _gameSide, _faction, _idx];

	// Update markers
	if (_isPlayerAttacking) then {
		[playArea] call client_fnc_updateRestrictions;
	};

	[] call _animate;
};
