scriptName "fn_resetVariables";
/*--------------------------------------------------------------------
	Authors: Maverick & A.Roman
    File: fn_resetVariables.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_resetVariables.sqf"
if (isServer && !hasInterface) exitWith {};

// Vars
[] call client_fnc_initGlobalVars;

cl_enemySpawnMarker = if (player getVariable "gameSide" == "defenders") then {"mobile_respawn_attackers"} else {"mobile_respawn_defenders"};


// Remove all actions
if (!isNil "cl_actionIDs") then {
	{
		[player, _x] call BIS_fnc_holdActionRemove;
	} forEach cl_actionIDs;
};

// Any beacons left?
private _beacon = player getVariable ["assault_beacon_obj", objNull];
if (!isNull _beacon) then {
	deleteVehicle _beacon;
};

// Start the ingame point feed
301 cutRsc ["rr_pointfeed","PLAIN"];

// Start top objective gui
400 cutRsc ["rr_objective_gui","PLAIN"];

// Setup the objective icon at the top
if (player getVariable "gameSide" == "defenders") then {
	disableSerialization;
	private _d = uiNamespace getVariable ["rr_objective_gui", displayNull];
	(_d displayCtrl 0) ctrlSetText "pictures\objective_defender.paa";
};

// Wait until we have a ticket count
waitUntil {!isNil "sv_tickets" && !isNil "sv_tickets_total"};

// Display teammates and objective
if (isNil "rr_iconrenderer_executed") then {
	rr_iconrenderer_executed = true;
	removeMissionEventHandler["EachFrame", cl_onEachFrameIconRenderedID];
	cl_onEachFrameIconRenderedID = addMissionEventHandler["EachFrame", {
	// onEachFrame {
		private _side = player getVariable ["gameSide", "defenders"];
		// Display the currently selected spawn if in spawn menu
		if (cl_inSpawnMenu) then {
			[] spawn client_fnc_spawnMenu_displaySpawn;
		};

		[] spawn client_fnc_displayCurrentObjective;

		[] spawn client_fnc_display3dIcons;

		[] spawn client_fnc_displayHUD;

		// warning if we are too close to the enemy spawn
		if (alive player && {!(vehicle player isKindOf "Air")} && {player getVariable ["isAlive", false]}) then {
			private _safeSpawnDistance = getNumber(missionConfigFile >> "MapSettings" >> "safeSpawnDistance");
			if (player distance (getMarkerPos cl_enemySpawnMarker) < _safeSpawnDistance) then {
				30 cutRsc ["rr_restrictedAreaSpawn", "PLAIN"];
				if (isNil "cl_restrictedArea_thread") then {
					cl_restrictedArea_thread = [] spawn client_fnc_restrictedArea;
				};
			};
		};

		if (player getVariable ["isAlive", false]) then {
			private _isPlayerAttacking = _side isEqualTo "attackers";
			if !(
					((vehicle player) inArea playArea) ||
					((vehicle player) isKindOf "Air") ||
					(
						(player getVariable ["isFallingBack", false]) &&
						(((getPosATL player) distance2D (getMarkerPos "mobile_respawn_defenders")) < 300)
					)) then {
				30 cutRsc ["rr_restrictedArea", "PLAIN"];
				private _display = uiNamespace getVariable ["rr_restrictedArea", displayNull];
				private _fallBackTime = player getVariable ["fallBackTime", nil];
				if (isNil "_fallBackTime") then {
					_fallBackTime = [] call client_fnc_getFallbackTime;
					player setVariable ["fallBackTime", _fallBackTime];
				};
				private _outOfBoundsTimeout = if (player getVariable ["isFallingBack", false]) then [{_fallBackTime}, {paramsArray#7}];
				if (diag_tickTime - (player getVariable "entryTime") < _outOfBoundsTimeout) then {
					if (!_isPlayerAttacking && player getVariable "isFallingBack") then {
						(_display displayCtrl 0) ctrlSetStructuredText parseText "<t size='3.5' color='#FFFFFF' shadow='2' align='center' font='PuristaBold'>FALL BACK</t><br/><t size='2' color='#FFFFFF' shadow='2' align='center'>YOU ARE BEYOND OUR LAST DEFENCE</t>";
					};
					(_display displayCtrl 1101) ctrlSetStructuredText parseText format ["<t size='5' color='#FFFFFF' shadow='2' align='center' font='PuristaBold'>%1s</t>", ([(_outOfBoundsTimeout + (player getVariable "entryTime")) - diag_tickTime, "MM:SS", true] call bis_fnc_secondsToString) select 1];
				};
				if (isNil "cl_restrictedArea_thread") then {
					cl_restrictedArea_thread = [] spawn client_fnc_restrictedArea;
				};
			};
		};
	// };
	}];
};

// Pointfeed init
cl_pointfeed_text = "";
cl_pointfeed_points = 0;

// Remove global vars
player setVariable ["kills",nil,true];
player setVariable ["deaths",nil,true];
player setVariable ["points",nil,true];
