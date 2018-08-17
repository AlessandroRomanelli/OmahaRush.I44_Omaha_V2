scriptName "fn_resetVariables";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_resetVariables.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
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
	/* ["rr_spawn_iconrenderer", "onEachFrame"] call bis_fnc_removeStackedEventHandler; */
	/* ["rr_spawn_iconrenderer", "onEachFrame", { */
	onEachFrame {
		/* {
			if (side _x == playerSide) then {
				if (alive _x) then {
					if (_x != player) then {
						_pos = getPosATLVisual _x;
						_pos set [2, (_pos select 2) + 1.85];

						if (group _x == group player) then {
							if (cl_inSpawnMenu) then {
								if (_x distance sv_cur_obj < 3500) then {
									// Squad member! Determine picture
									_icon = call {
										if (_x getVariable ["class",""] == "medic") exitWith {"pictures\medic.paa"};
										if (_x getVariable ["class",""] == "engineer") exitWith {"pictures\engineer.paa"};
										if (_x getVariable ["class",""] == "support") exitWith {"pictures\support.paa"};
										"pictures\assault.paa";
									};

									// Determine alpha value
									//_alpha = if (_x distance player > 50) then {0.55} else {1};
									_alpha = [0.85, 0.35] select (_x distance player > 50);
									drawIcon3D[format["%1%2",MISSION_ROOT, _icon], [1,1,1,_alpha], _pos, 1.5, 1.5, 0, name _x, 2, 0.04, "PuristaMedium", "center", true];

									// Draw spawn beacons
									_beacon = _x getVariable ["assault_beacon_obj", objNull];
									if (!isNull _beacon) then {
										drawIcon3D[format["%1%2",MISSION_ROOT, _icon], [1,1,1,_alpha], (getPosATLVisual _beacon), 1.5, 1.5, 0, format["%1's Spawnbeacon", name _x], 2, 0.04, "PuristaMedium", "center", true];
									};
								};
								} else {
									// Not in the spawn menu, just render the normal squad icons without spawn beacons
									_icon = call {
										if (_x getVariable ["class",""] == "medic") exitWith {"pictures\medic.paa"};
										if (_x getVariable ["class",""] == "engineer") exitWith {"pictures\engineer.paa"};
										if (_x getVariable ["class",""] == "support") exitWith {"pictures\support.paa"};
										"pictures\assault.paa";
									};

									// Alpha and render
									//_alpha = if (_x distance player > 50) then {0.55} else {1};
									_alpha = [0.85, 0.35] select (_x distance player > 50);
									drawIcon3D[format["%1%2",MISSION_ROOT, _icon], [1,1,1,_alpha], _pos, 1.5, 1.5, 0, name _x, 2, 0.04, "PuristaMedium", "center", true];
								};
								} else {
									// Icon for teammates
									if (!cl_inSpawnMenu) then {
										_d = if ((vehicle player) isKindOf "Air") then {2000} else {50};
										if (_x distance player < _d || _x == (driver vehicle cursorObject) || _x == (driver vehicle cursorTarget)) then {
											drawIcon3D[format["%1pictures\teammate.paa",MISSION_ROOT], [1,1,1,0.75], _pos, 0.5, 0.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
										};
										} else {
											if (_x distance sv_cur_obj < 3500) then {
												drawIcon3D[format["%1pictures\teammate.paa",MISSION_ROOT], [1,1,1,0.75], _pos, 0.5, 0.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
											};
										};
									};
								};
								} else {
									if (cl_inSpawnMenu) then {
										if ((group _x) == (group player)) then {
											_beacon = _x getVariable ["assault_beacon_obj", objNull];
											if (!isNull _beacon) then {
												drawIcon3D["", [1,1,1,_alpha], (getPosATLVisual _beacon), 1.5, 1.5, 0, format["%1's Spawnbeacon", name _x], 2, 0.04, "PuristaMedium", "center", true];
											};
										};
									};
								};
							};
							} forEach allPlayers;

							if (cl_class == "medic" && cl_classPerk == "defibrillator") then {
								{
									if (_x distance player < 25) then {
										if (_x getVariable ["side", sideUnknown] == playerSide) then {
											_pos = getPosATLVisual _x;
											_pos set [2, (_pos select 2) + 0.1];
											drawIcon3D[format["%1pictures\revive.paa",MISSION_ROOT], [1,1,1,0.8], _pos, 1.5, 1.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
										};
									};
									} forEach AllDeadMen;
								}; */


		// Objectives
		/* _stage = [] call client_fnc_getCurrentStageString; */

		if (count (sv_cur_obj getVariable ["positionAGL", []]) == 0) then {
			private _pos = ASLToAGL (getPosASL sv_cur_obj);
			_pos set [2, (_pos select 2) + 0.5];
			sv_cur_obj setVariable ["positionAGL", _pos];
		};

		private _pos = sv_cur_obj getVariable "positionAGL";

		private _alpha = 1 - ((((player getRelDir _pos) - 180)/180)^30);

		if ((sv_cur_obj getVariable ["status", -1]) isEqualTo 1) then {
			_alpha = 2/3 + (1/3*cos(100*diag_tickTime*pi));
		};

		private _objIsArmed = sv_cur_obj getVariable ["status", -1] isEqualTo 1;
		if (player getVariable ["gameSide", "defenders"] == "defenders") then {
			if (_objIsArmed) then {
				drawIcon3D [MISSION_ROOT+"pictures\objective_defender_armed.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Defuse (%1m)", round(player distance sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			} else {
				drawIcon3D [MISSION_ROOT+"pictures\objective_defender.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Defend (%1m)", round(player distance sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			};
		} else {
			if (_objIsArmed) then {
				drawIcon3D [MISSION_ROOT+"pictures\objective_attacker_armed.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Protect (%1m)", round(player distance sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			} else {
				drawIcon3D [MISSION_ROOT+"pictures\objective_attacker.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Attack (%1m)", round(player distance sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			};
		};

		// Squad icons
		{
			_pos = getPosATLVisual (_x select 0);
			_pos set [2, (_pos select 2) + 1.85];
			drawIcon3D[_x select 2, [1,1,1, _x select 3], _pos, 1.5, 1.5, 0, _x select 1, 2, 0.04, "PuristaMedium", "center", true];
		} forEach cl_onEachFrame_squad_members;

		// Squad spawn beacons
		{
			drawIcon3D["", [1,1,1,1], _x select 0, 1.5, 1.5, 0, _x select 1, 2, 0.04, "PuristaMedium", "center", true];
		} forEach cl_onEachFrame_squad_beacons;

		// Team icons
		{
			private _unit = _x select 0;
			private _pos = getPosATLVisual _unit;
			_pos set [2, (_pos select 2) + 1.85];
			if (_unit == (driver vehicle cursorObject) || _unit == (driver vehicle cursorTarget)) then {
				drawIcon3D[_x select 2, [1,1,1,0.75], _pos, 0.5, 0.5, 0, _x select 1, 2, 0.03, "PuristaMedium", "center", false];
			} else {
				drawIcon3D[_x select 2, [1,1,1,0.25], _pos, 0.5, 0.5, 0, "", 2, 0.03, "PuristaMedium", "center", false];
			};
		} forEach cl_onEachFrame_team_members;

		// Revive icons
		if (cl_class == "medic") then {
			{
				_pos = getPosATLVisual (_x select 0);
				_pos set [2, (_pos select 2) + 0.1];
				drawIcon3D[_x select 1, [1,1,1,0.8], _pos, 1.5, 1.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
			} forEach cl_onEachFrame_team_reviveable;
		};


		private _d = uiNamespace getVariable ["rr_objective_gui", displayNull];
		(_d displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='left'>%1</t>", sv_tickets];
		(_d displayCtrl 4) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='right'>%1</t>", [cl_matchTime, "MM:SS"] call bis_fnc_secondsToString];
		(_d displayCtrl 2) progressSetPosition (sv_tickets / sv_tickets_total);

		// MERGE OF INGAME GUI
		private _hud = uiNameSpace getVariable ["playerHUD",displayNull];
		private _HUD_currentAmmo = _hud displayCtrl 100;
		private _HUD_reserveAmmo = _hud displayCtrl 101;
		private _HUD_firemode = _hud displayCtrl 102;
		private _HUD_healthPoints = _hud displayCtrl 104;
		private _HUD_zeroing = _hud displayCtrl 105;
		private _HUD_grenades = _hud displayCtrl 107;
		private _HUD_typeGrenade = _hud displayCtrl 108;

		private _currentAmmo = 0;
		private _reserveAmmo = 0;
		private _grenades    = 0;
		private _fireMode = "";

		private _mode = currentWeaponMode (gunner (vehicle player));
		if (_mode isEqualType "STRING") then {
			if (_mode == "Single") then {_fireMode = "SNGL"};
			if (_mode in ["Burst","Burst2rnd"]) then {_fireMode = "BRST"};
			if (_mode == "FullAuto" OR _mode == "manual") then {_fireMode = "AUTO"};
		} else {_fireMode = "---"};

		if ((isNull objectParent player) || {(assignedVehicleRole player select 0) isEqualTo "cargo"}) then {
			{
				if ((_x select 0) == (currentMagazine player) AND (_x select 2)) then
				{
					_currentAmmo = (_x select 1);
				};
				if ((_x select 0) == (currentMagazine player) AND !(_x select 2)) then
				{
					_reserveAmmo = _reserveAmmo + (_x select 1);
				};
				if ((_x select 0) isEqualTo ((currentThrowable player) select 0)) then
				{
					_grenades = _grenades + 1;
				};
			} forEach (magazinesAmmoFull player);
		} else {
			if (driver (vehicle player) == player) then {
				_currentAmmo = format ["%1", abs (floor (speed (vehicle player)))];
				_reserveAmmo = format ["%1°", floor getDir (vehicle player)];
				_fireMode = "KM/H";
			} else {
				_currentAmmo = (vehicle player) ammo (currentWeapon (vehicle player));
				_reserveAmmo = [] call {
					private _ammoLeft = 0 - ((vehicle player) ammo (currentWeapon (vehicle player)));
					{if ((_x select 0) isEqualto (currentMagazine (vehicle player))) then {_ammoLeft = _ammoLeft + (_x select 1)}} forEach magazinesAmmo (vehicle player);
					_ammoLeft
				};
			};
		};

		private _grenadeIcon = if (toLower ((currentThrowable player) select 0) in ["lib_us_mk_2", "lib_shg24", "lib_rg42"]) then {"pictures\frag.paa"} else {"pictures\smoke.paa"};
		if ((currentThrowable player) isEqualto []) then {_grenadeIcon = "";};

		if (_grenades isEqualTo 0) then {_grenades = ""};

		_HUD_currentAmmo  ctrlSetText format ["%1",_currentAmmo];
		_HUD_reserveAmmo  ctrlSetText format ["%1",_reserveAmmo];
		_HUD_firemode     ctrlSetStructuredText parseText format ["<t align='left' size='1'>[</t><t align='center' size='1'>%1</t><t align='right' size='1'>]</t>",_fireMode];
		_HUD_healthPoints ctrlSetText format ["%1",floor((1-(damage player))*100)];
		_HUD_zeroing  		ctrlSetText format ["%1m", currentZeroing player];
		_HUD_typeGrenade	ctrlSetText _grenadeIcon;
		_HUD_grenades			ctrlSetText format ["%1", _grenades];

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
			private _isPlayerAttacking = player getVariable ["gameSide", "attackers"] == "attackers";
			if !(((vehicle player) inArea playArea) || ((vehicle player) isKindOf "Air")) then {
				30 cutRsc ["rr_restrictedArea", "PLAIN"];
				private _display = uiNamespace getVariable ["rr_restrictedArea", displayNull];
				private _outOfBoundsTimeout = if (player getVariable ["isFallingBack", false]) then [{paramsArray#8}, {paramsArray#7}];
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

			if (("swim" in cl_squadPerks) && {player getVariable ["isAlive", false]} && {isNull (objectParent player)} && {!(isTouchingGround player)} && {(surfaceIsWater (getPosWorld player))}) then {
				player setAnimSpeedCoef 3;
			} else {
				player setAnimSpeedCoef 1;
			};
		};
	};
	/* }] call BIS_fnc_addStackedEventHandler; */
};

// Pointfeed init
cl_pointfeed_text = "";
cl_pointfeed_points = 0;

// Remove global vars
player setVariable ["kills",nil,true];
player setVariable ["deaths",nil,true];
player setVariable ["points",nil,true];
