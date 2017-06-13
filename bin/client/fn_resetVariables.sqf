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

// Remove all actions
if (!isNil "cl_actionIDs") then {
	{
		[player, _x] call BIS_fnc_holdActionRemove;
	} forEach cl_actionIDs;
};

// Vars
cl_kills = 0;
cl_deaths = 0;
cl_points = 0;
cl_killfeed = [];
cl_spawn_tick = 0;
cl_timelineevents = [];
cl_revived = false;
cl_inSpawnMenu = false;
cl_beacon_used = 0;
cl_class = "";
cl_assistsInfo = [];
cl_classPerk = "";
cl_squadPerk = "";
cl_actionIDs = [];
cl_mcomDefAtt = 0;
cl_pointsBelowMinimumPlayers = 0;
cl_enemySpawnMarker = if (player getVariable "gameSide" == "defenders") then {"mobile_respawn_attackers"} else {"mobile_respawn_defenders"};
cl_blockTimer = false;
TEMPWARNING = nil;
cl_onEachFrame_squad_members = [];
cl_onEachFrame_squad_beacons = [];
cl_onEachFrame_team_members = [];
cl_onEachFrame_team_reviveable = [];

// Any beacons left?
_beacon = player getVariable ["assault_beacon_obj", objNull];
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
	_d = uiNamespace getVariable ["rr_objective_gui", displayNull];
	(_d displayCtrl 0) ctrlSetText "pictures\objective_defender.paa";
};

// Wait until we have a ticket count
waitUntil {!isNil "sv_tickets" && !isNil "sv_tickets_total"};

// Display teammates and objective
if (isNil "rr_iconrenderer_executed") then {
	rr_iconrenderer_executed = true;
	//["rr_spawn_iconrenderer", "onEachFrame"] call bis_fnc_removeStackedEventHandler;
	//["rr_spawn_iconrenderer", "onEachFrame", {
	onEachFrame {
		/*{
			if (side _x == playerSide) then {
				if (alive _x) then {
					if (_x != player) then {
						_pos = getPosATLVisual _x;
						_pos set [2, (_pos select 2) + 1.85];

						if (group _x == group player) then {
							if (cl_inSpawnMenu) then {
								if (_x distance sv_cur_obj < 3500) then {
									// Squad member! Determine picture
									_icon = if (_x getVariable ["class",""] == "medic") then {
										"pictures\assault.paa"
									} else {
										if (_x getVariable ["class",""] == "support") then {
											"pictures\support.paa"
										} else {
											if (_x getVariable ["class",""] == "engineer") then {
												"pictures\engineer.paa"
											} else {
												"pictures\assault.paa"
											};
										};
									};

									// Determine alpha value
									//_alpha = if (_x distance player > 50) then {0.55} else {1};
									_alpha = [1, 0.55] select (_x distance player > 50);
									drawIcon3D[format["%1%2",MISSION_ROOT, _icon], [1,1,1,_alpha], _pos, 1.5, 1.5, 0, (_x getVariable ["name", ""]), 2, 0.04, "PuristaMedium", "center", true];

									// Draw spawn beacons
									_beacon = _x getVariable ["assault_beacon_obj", objNull];
									if (!isNull _beacon) then {
										drawIcon3D[format["%1%2",MISSION_ROOT, _icon], [1,1,1,_alpha], (getPosATLVisual _beacon), 1.5, 1.5, 0, format["%1's Spawnbeacon", (_x getVariable ["name", ""])], 2, 0.04, "PuristaMedium", "center", true];
									};
								};
							} else {
								// Not in the spawn menu, just render the normal squad icons without spawn beacons
								_icon = if (_x getVariable ["class",""] == "medic") then {
									"pictures\assault.paa"
								} else {
									if (_x getVariable ["class",""] == "support") then {
										"pictures\support.paa"
									} else {
										"pictures\assault.paa"
									};
								};

								// Alpha and render
								//_alpha = if (_x distance player > 50) then {0.55} else {1};
								_alpha = [1, 0.55] select (_x distance player > 50);
								drawIcon3D[format["%1%2",MISSION_ROOT, _icon], [1,1,1,_alpha], _pos, 1.5, 1.5, 0, (_x getVariable ["name", ""]), 2, 0.04, "PuristaMedium", "center", true];
							};
						} else {
							// Icon for teammates
							if (!cl_inSpawnMenu) then {
								_d = if ((vehicle player) isKindOf "Air") then {2000} else {50};
								if (_x distance player < _d || _x == (driver vehicle cursorObject) || _x == (driver vehicle cursorTarget)) then {
									drawIcon3D[format["%1pictures\teammate.paa",MISSION_ROOT], [1,1,1,0.8], _pos, 0.5, 0.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
								};
							} else {
								if (_x distance sv_cur_obj < 3500) then {
									drawIcon3D[format["%1pictures\teammate.paa",MISSION_ROOT], [1,1,1,0.8], _pos, 0.5, 0.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
								};
							};
						};
					};
				} else {
					if (cl_inSpawnMenu) then {
						if ((group _x) == (group player)) then {
							_beacon = _x getVariable ["assault_beacon_obj", objNull];
							if (!isNull _beacon) then {
								drawIcon3D["", [1,1,1,_alpha], (getPosATLVisual _beacon), 1.5, 1.5, 0, format["%1's Spawnbeacon", (_x getVariable ["name", ""])], 2, 0.04, "PuristaMedium", "center", true];
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
		};
		*/

		// Objectives
		_pos = getPosATLVisual sv_cur_obj;
		_pos set [2, (_pos select 2) + 0.5];

		if (player getVariable "gameSide" == "defenders") then {
			drawIcon3D [format ["%1pictures\objective_defender.paa",MISSION_ROOT],[1,1,1,1],_pos,1.5,1.5,0,format["Defend (%1m)", round(player distance sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
		} else {
			drawIcon3D [format ["%1pictures\objective_attacker.paa",MISSION_ROOT],[1,1,1,1],_pos,1.5,1.5,0,format["Attack (%1m)", round(player distance sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
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
			_pos = getPosATLVisual (_x select 0);
			_pos set [2, (_pos select 2) + 1.85];
			drawIcon3D[_x select 1, [1,1,1,0.8], _pos, 0.5, 0.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
		} forEach cl_onEachFrame_team_members;

		// Revive icons
		if (cl_class == "medic" && cl_classPerk == "defibrillator") then {
			{
				_pos = getPosATLVisual (_x select 0);
				_pos set [2, (_pos select 2) + 0.1];
				drawIcon3D[_x select 1, [1,1,1,0.8], _pos, 1.5, 1.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
			} forEach cl_onEachFrame_team_reviveable;
		};


		_d = uiNamespace getVariable ["rr_objective_gui", displayNull];
		(_d displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='left'>%1</t>", sv_tickets];
		(_d displayCtrl 4) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='right'>%1</t>", [cl_matchTime, "MM:SS"] call bis_fnc_secondsToString];
		(_d displayCtrl 2) progressSetPosition (sv_tickets / sv_tickets_total);

		// MERGE OF INGAME GUI
		_hud = uiNameSpace getVariable ["playerHUD",displayNull];
		_HUD_currentAmmo = _hud displayCtrl 100;
		_HUD_reserveAmmo = _hud displayCtrl 101;
		_HUD_firemode = _hud displayCtrl 102;
		_HUD_healthPlus = _hud displayCtrl 103;
		_HUD_healthPoints = _hud displayCtrl 104;
		_HUD_grenades = _hud displayCtrl 105;
		_HUD_slashBetweenAmmo = _hud displayCtrl 106;

		_currentAmmo = 0;
		_reserveAmmo = 0;
		_grenades    = 0;
		_fireMode = "";

		_mode = currentWeaponMode gunner vehicle player;
		if (typeName _mode == "STRING") then {
			if (_mode == "Single") then {_fireMode = "SNGL"};
			if (_mode in ["Burst","Burst2rnd"]) then {_fireMode = "BRST"};
			if (_mode == "FullAuto" OR _mode == "manual") then {_fireMode = "AUTO"};
		} else {_fireMode = "---"};

		if (vehicle player == player || ((driver vehicle player != player) && (gunner vehicle player != player) && (commander vehicle player != player))) then {
			{
				if ((_x select 0) == (currentMagazine player) AND (_x select 2)) then
				{
					_currentAmmo = (_x select 1);
				};
				if ((_x select 0) == (currentMagazine player) AND !(_x select 2)) then
				{
					_reserveAmmo = _reserveAmmo + (_x select 1);
				};
				if ((_x select 0) == "HandGrenade") then
				{
					_grenades = _grenades + 1;
				};
			} forEach (magazinesAmmoFull player);
		} else {
			if (driver (vehicle player) == player) then {
				_currentAmmo = (vehicle player) ammo (currentWeapon (vehicle player));
				_reserveAmmo = 0;
			} else {
				_currentAmmo = 0; // TODO
				_reserveAmmo = 0;
			};
		};

		_size = if (_currentAmmo < 1000) then {3.8} else {2.7};

		_HUD_currentAmmo  ctrlSetText format ["%1",_currentAmmo];
		_HUD_reserveAmmo  ctrlSetText format ["%1",_reserveAmmo];
		_HUD_firemode     ctrlSetStructuredText parseText format ["<t align='left' size='1'>[</t><t align='center' size='1'>%1</t><t align='right' size='1'>]</t>",_fireMode];
		_HUD_healthPoints ctrlSetText format ["%1",floor((1-(damage player))*100)];
		_HUD_grenades     ctrlSetText format ["%1m", currentZeroing player];

		// warning if we are too close to the enemy spawn
		if (alive player) then {
			if (player distance (getMarkerPos cl_enemySpawnMarker) < 100) then {
				30 cutRsc ["rr_restrictedArea", "PLAIN"];
				if (isNil "cl_restrictedArea_thread") then {
					cl_restrictedArea_thread = [] spawn client_fnc_restrictedArea;
				};
			};
		};
	};
	//}] call BIS_fnc_addStackedEventHandler;
};

// Pointfeed init
cl_pointfeed_text = "";
cl_pointfeed_points = 0;

// Remove global vars
player setVariable ["kills",nil,true];
player setVariable ["deaths",nil,true];
player setVariable ["points",nil,true];
