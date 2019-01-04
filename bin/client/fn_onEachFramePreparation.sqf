scriptName "fn_onEachFramePreparation";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_onEachFramePreparation.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_onEachFramePreparation.sqf"

// Inline function to determine icon
private _getIcon = {
	private _unit = param[0,objNull,[objNull]];
	if (_unit getVariable ["class",""] == "medic") exitWith {WWRUSH_ROOT+"pictures\medic.paa"};
	if (_unit getVariable ["class",""] == "engineer") exitWith {WWRUSH_ROOT+"pictures\engineer.paa"};
	if (_unit getVariable ["class",""] == "support") exitWith {WWRUSH_ROOT+"pictures\support.paa"};
	if (_unit getVariable ["class",""] == "recon") exitWith {WWRUSH_ROOT+"pictures\recon.paa"};
	WWRUSH_ROOT+"pictures\assault.paa";
};

// Variables
cl_onEachFrame_squad_members = [];
cl_onEachFrame_squad_beacons = [];
cl_onEachFrame_team_members = [];
cl_onEachFrame_team_reviveable = [];
cl_onEachFrame_spotted_enemies = [];

removeMissionEventHandler ["EachFrame", cl_onEachFramePreparationID];
cl_onEachFramePreparationID = addMissionEventHandler["EachFrame", {
	// Temp vars
	private _squad_members = [];
	private _squad_beacons = [];
	private _team_members = [];
	private _toBeRevived = [];
	private _spottedTargets = [];

	// Fill with data
	{
		private _name = (_x getVariable ["name", "ERROR: No Name"]);
		if (_x != player) then {
			if (side (group _x) == side (group player)) then {
				if ((group _x) == (group player)) then {
					// Does this unit provide a beacon
					if (cl_inSpawnMenu) then {
						private _beacon = _x getVariable ["assault_beacon_obj", objNull];
						if (!isNull _beacon) then {
							_squad_beacons pushBack [(getPosATLVisual _beacon), format["%1's Spawnbeacon", _name]];
						};
					};

					// Is he alive
					if (alive _x) then {
						// The player should not be on the debug island
						if (_x distance cl_safePos > 200) then {
							private _alpha = [0.75, 0.55] select (_x distance player > 50);
							private _icon = [_x] call _getIcon;
							_squad_members pushBack [_x, _name, (WWRUSH_ROOT+_icon), _alpha];
						};
					};
				} else {
					if (_x distance cl_safePos > 200 && alive _x) then {
						if (cl_inSpawnMenu || ((vehicle player) isKindOf "Air")) then {
							_team_members pushBack [_x, _name, (WWRUSH_ROOT+"pictures\teammate.paa")];
						} else {
							// Only teammates within 100 meters
							if (_x distance player < 100 || _x == (driver vehicle cursorTarget) || _x == (driver vehicle cursorTarget)) then {
								_team_members pushBack [_x, _name, (WWRUSH_ROOT+"pictures\teammate.paa")];
							};
						};
					};
				};
			} else {
				if (_x getVariable ["isSpotted", 0] != 0) then {
					_spottedTargets pushBack [_x, _x getVariable "isSpotted"];
				};
			};
		};
	} forEach AllUnits;

	// Own beacon?
	if (cl_inSpawnMenu) then {
		private _myBeacon = player getVariable ["assault_beacon_obj", objNull];
		if (!isNull _myBeacon) then {
			_squad_beacons pushBack [(getPosATLVisual _myBeacon), format["%1's Spawnbeacon", (player getVariable ["name", "ERROR: No Name"])]];
		};
	};

	// Medics
	if (cl_class == "medic") then {
		{
			if (alive player && {_x distance player < 50} && {isPlayer _x}) then {
				if (_x getVariable ["side", sideUnknown] == playerSide) then {
					_toBeRevived pushBack _x;
				};
			};
		} forEach AllDeadMen;
	};

	// Overwrite variables
	cl_onEachFrame_squad_members = _squad_members;
	cl_onEachFrame_squad_beacons = _squad_beacons;
	cl_onEachFrame_team_members = _team_members;
	cl_onEachFrame_team_reviveable = _toBeRevived;
	cl_onEachFrame_spotted_enemies = _spottedTargets;
}];
