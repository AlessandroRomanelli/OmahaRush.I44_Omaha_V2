scriptName "fn_MCOMdestroyed";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_MCOMdestroyed.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MCOMdestroyed.sqf"

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
	sleep 6.5;

	// Move to old pos
	_c ctrlSetPosition _pos;
	_c ctrlCommit 0.25;
};


// Param is TRUE if the just destroyed mcom was NOT the last one
if (param[0,false,[false]]) then {
	private _fallBackTime = [] call client_fnc_getFallbackTime;

	if (player getVariable ["gameSide", "attackers"] == "attackers") then {
		[] spawn client_fnc_blockSpawn;
	};

	// Update markers
	[] call client_fnc_updateMarkers;

	private _isPlayerAttacking = ((player getVariable "gameSide") isEqualTo "attackers");

	// If we are attacker, block the next mcom for now
	if (_isPlayerAttacking) then {
		cl_enemySpawnMarker = "objective";
	} else {
		// FallingBack flag in order to handle out of bounds kill time
		player setVariable ["isFallingBack", true];
	};

	sleep 3;
	[format["DEFENDERS HAVE %1 SECONDS TO FALL BACK", _fallBackTime]] call client_fnc_displayObjectiveMessage;

	if (!_isPlayerAttacking) then {
		[playArea, (_fallBackTime-3)] call client_fnc_updateRestrictions;
	};

	sleep (_fallBackTime-3);
	if (_isPlayerAttacking) then {
		["NEW OBJECTIVE HAS BEEN ASSIGNED, PUSH!"] call client_fnc_displayObjectiveMessage;
	} else {
		["NEW OBJECTIVE HAS BEEN ASSIGNED, DEFEND!"] call client_fnc_displayObjectiveMessage;
		player setVariable ["isFallingBack", false];
	};

	private _side = player getVariable ["gameSide", "defenders"];
	private _faction = getText(missionConfigFile >> "Unlocks" >> _side >> "faction");
	private _idx = (floor (random 4))+1;
	playSound format["%1Order%2_%3", _side, _faction, _idx];

	// Update markers
	if (_isPlayerAttacking) then {
		[playArea] call client_fnc_updateRestrictions;
	};

	[] call _animate;
};
