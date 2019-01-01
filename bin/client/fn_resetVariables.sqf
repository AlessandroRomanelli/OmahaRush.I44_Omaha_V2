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
		private _HQPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> _side);
		// Spawn cam
		if (cl_inSpawnMenu) then {
			private _d = findDisplay 5000;
			private _ctrl = if ((lbCurSel (_d displayCtrl 8)) isEqualTo -1) then { _d displayCtrl 9 } else { _d displayCtrl 8 };
			private _value = _ctrl lbValue (lbCurSel _ctrl);
			private _data = _ctrl lbData (lbCurSel _ctrl);
			private _makeCurrentSpawn = {
				params ["_pos", "_title"];
				private _progress = diag_tickTime % 1;
				drawIcon3D [MISSION_ROOT+"pictures\mark.paa", [0.66,1,0.66,0.5-(0.5*_progress)], _pos, 2+(1*_progress), 2+(1*_progress), 0, "", 0, 0.05, "PuristaMedium"];
				drawIcon3D [MISSION_ROOT+"pictures\mark.paa", [1,1,1,1], _pos, 1.5, 1.5, 0, _title, 0, 0.05, "PuristaMedium"];
				drawLine3D [_pos, getPos sv_cur_obj, [1,1,1,1]];
				private _leader = leader group player;
				if (player isEqualTo _leader) then {
					{
						if (_x getVariable ["isAlive", false]) then {
							private _unitPos = _x modelToWorldVisual [0,0,1];
							drawLine3D [_pos, _unitPos, [1,1,1,0.5]];
						};
					} forEach (units group player);
				} else {
					private _leaderPos = _leader modelToWorldVisual [0,0,1];
					{
						if (_x getVariable ["isAlive", false]) then {
							private _unitPos = _x modelToWorldVisual [0,0,1];
							drawLine3D [_leaderPos, _unitPos, [1,1,1,0.5]];
						};
					} forEach (units group player);
				};
				true
			};
			[] call {
				if (_data isEqualTo "") exitWith {};
				if (_value isEqualTo -1) exitWith {
					[_HQPos, "HQ"] call _makeCurrentSpawn;
				};
				drawIcon3D [MISSION_ROOT+"pictures\mark.paa", [1,1,1,0.25], _HQPos, 1.5, 1.5, 0, "HQ", 0, 0.05, "PuristaMedium"];
				if (_value isEqualTo -2) exitWith {
					private _vehicle = missionNamespace getVariable [_data, objNull];
					if (isNull _vehicle) exitWith {};
					private _pos = _vehicle modelToWorldVisual [0,0,1];
					private _vehicleName = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
					private _crew = crew _vehicle;
					private _driverName = if (count _crew > 0) then {(_crew select 0) getVariable ["name", "ERROR: No Name"]} else {""};
					private _title = [] call {
						if (count _crew isEqualTo 0) exitWith {
							_vehicleName
						};
						if (count _crew isEqualTo 1) exitWith {
							format["%1:%2", _vehicleName, _driverName];
						};
						if (count _crew > 1) exitWith {
							format["%1:%2+%3", _vehicle, _driverName, (count _crew)-1];
						};
						_vehicleName
					};
					[_pos, _title] call _makeCurrentSpawn;
				};
			};

		};


		// Objectives
		private _pos = sv_cur_obj getVariable ["positionAGL", []];
		if (count _pos == 0) then {
		 	_pos = sv_cur_obj modelToWorldVisual [0,0,0.5];
			sv_cur_obj setVariable ["positionAGL", _pos];
		};

		private _alpha = [_pos] call {
			private _pos = param [0, [], [[]]];
			if (count _pos == 0) exitWith {1};
			private _relDir = player getRelDir _pos;
			if (_relDir < 10) exitWith {
				0.25 + (3*_relDir/40)
			};
			if (_relDir >= 10 && _relDir <= 350) exitWith {
				1
			};
			if (_relDir > 350) exitWith {
				1 - (3/40*_relDir) + 26.25
			};
			1
		};

		if ((sv_cur_obj getVariable ["status", -1]) isEqualTo 1) then {
			_alpha = 2/3 + (1/3*cos(100*diag_tickTime*pi));
		};

		private _objIsArmed = sv_cur_obj getVariable ["status", -1] isEqualTo 1;
		private _origin = if (cl_inSpawnMenu) then {_HQPos} else {getPos player};
		if (_side isEqualTo "defenders") then {
			if (_objIsArmed) then {
				drawIcon3D [MISSION_ROOT+"pictures\objective_defender_armed.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Defuse (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			} else {
				drawIcon3D [MISSION_ROOT+"pictures\objective_defender.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Defend (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			};
		} else {
			if (_objIsArmed) then {
				drawIcon3D [MISSION_ROOT+"pictures\objective_attacker_armed.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Protect (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			} else {
				drawIcon3D [MISSION_ROOT+"pictures\objective_attacker.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Attack (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
			};
		};

		private _ammoBoxes = (getPos player) nearObjects ["LIB_AmmoCrates_NoInteractive_Large", 7];
		{
			private _pos = getPosASL _x;
			_pos set [2, (_pos select 2) + 0.5];
			private _distance = player distance _x;
			private _alpha = if (_distance < 5) then {1} else {1-(1/2*_distance)+2.5};
			drawIcon3D [MISSION_ROOT+"pictures\support.paa", [1,1,1,_alpha], ASLtoAGL _pos, 1.5, 1.5, 0, format["Rearm (%1m)", round _distance], 2, 0.04, "PuristaLight", "center", true];
		} forEach _ammoBoxes;

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

		// 3D Spotted enemies
		{
			private _unit = _x select 0;
			private _time = _x select 1;
			private _pos = getPosATLVisual _unit;
			_pos set [2, (_pos select 2) + 1];
			if (serverTime - _time > 10) then {
				/* systemChat format ["Expired 3D spot for unit: %1 because %2s passed since spotting.", name _unit, serverTime - _time]; */
				_unit setVariable ["isSpotted", nil];
				_unit setVariable ["3dspotted", false];
			} else {
				if (_unit getVariable ["3dspotted", false]) then {
					private _alpha = ((10 + _time - serverTime)/10)*0.66;
					if (_alpha < 0 || ([player, "VIEW", _unit] checkVisibility [eyePos player, eyePos _unit] < 0.2)) then {
						_alpha = 0;
					};
					drawIcon3D [MISSION_ROOT+"pictures\enemy.paa", [1,1,1,_alpha], _pos, 0.3, 0.3, 0, "", 2, 0.03, "PuristaMedium", "center", false];
				};
			};
		} forEach cl_onEachFrame_spotted_enemies;

		// Revive icons
		if (cl_class == "medic") then {
			{
				_pos = getPosATLVisual _x;
				_pos set [2, (_pos select 2) + 0.1];
				drawIcon3D [MISSION_ROOT+"pictures\revive.paa", [1,1,1,0.8], _pos, 1.5, 1.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
			} forEach cl_onEachFrame_team_reviveable;
		};


		private _d = uiNamespace getVariable ["rr_objective_gui", displayNull];
		(_d displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='left'>%1</t>", sv_tickets];
		(_d displayCtrl 4) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='right'>%1</t>", [sv_matchTime, "MM:SS"] call bis_fnc_secondsToString];
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
		private _HUD_weaponName = _hud displayCtrl 1100;

		private _groupUnits = units (group player);

		private _getHUDTextColor = {
			private _unit = param [0, objNull, [objNull]];
			if (_unit getVariable ["inCombat", false]) exitWith {
				["#ffcc99", "#66513d"]
			};
			if (_unit getVariable ["isAlive", true]) exitWith {
				["#aaffaa", "#446644"]
			};
			["#ffaaaa", "#664444"]
		};

		private _getHUDArrayColor = {
			private _unit = param [0, objNull, [objNull]];
			if (_unit getVariable ["inCombat", false]) exitWith {
				[[1, 0.8, 0.6, 1], [0.4, 0.32, 0.24]]
			};
			if (_unit getVariable ["isAlive", true]) exitWith {
				[[0.66, 1, 0.66, 1], [0.26, 0.4, 0.26, 1]]
			};
			[[1, 0.66, 0.66, 1], [0.4, 0.26, 0.26, 1]]
		};

		private _getTeamIcon = {
			private _unit = param [0, objNull, [objNull]];
			private _perkIdx = _unit getVariable ["squadPerk", -1];
			if (_perkIdx isEqualTo -1) exitWith {"pictures\noperk.paa"};
			private _availableSquadPerks = (missionConfigFile >> "CfgPerks" >> "SquadPerks") call bis_fnc_getCfgSubClasses;
			private _squadPerk = _availableSquadPerks select _perkIdx;
			private _icon = "pictures\"+_squadPerk+".paa";
			_icon
		};

		for "_i" from 0 to 4 do {
			private _teamMateName = _hud displayCtrl (2100 + _i);
			private _teamMateIcon = _hud displayCtrl (2200 + _i);
			private _teamMateLeader = _hud displayCtrl (2300 + _i);
			if (_i < count _groupUnits) then {
				private _unit = _groupUnits select _i;
				private _colors = [_unit] call _getHUDTextColor;
				private _name = _unit getVariable["name", "ERROR: No Name"];
				_teamMateName ctrlSetStructuredText parseText (format ["<t size='1.15' shadow='1' shadowColor='%1' color='%2' font='PuristaLight' align='right'>%3</t>", _colors select 1, _colors select 0, _name]);
				private _arrayColors = [_unit] call _getHUDArrayColor;
				_teamMateIcon ctrlSetText ([_unit] call _getTeamIcon);
				_teamMateIcon ctrlSetTextColor (_arrayColors select 0);
				if (_unit isEqualTo (leader (group player))) then {
					_teamMateLeader ctrlSetTextColor (_arrayColors select 0);
				} else {
					_teamMateLeader ctrlSetTextColor [0,0,0,0];
				}
			} else {
				_teamMateName ctrlSetStructuredText parseText "";
				_teamMateIcon ctrlSetText "pictures\noperk.paa";
				_teamMateIcon ctrlSetTextColor [0,0,0,0.25];
				_teamMateLeader ctrlSetTextColor [0,0,0,0];
			};
		};

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
			if (driver (vehicle player) == player && {!((vehicle player) isKindOf "Air")}) then {
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

		private _grenadeIcon = if (toLower ((currentThrowable player) select 0) in ["lib_us_mk_2", "lib_shg24", "lib_rg42"]) then {"pictures\grenade.paa"} else {"pictures\smoke.paa"};
		if ((currentThrowable player) isEqualto []) then {_grenadeIcon = "";};

		if (_grenades isEqualTo 0) then {_grenades = ""};

		private _weaponName = getText(configFile >> "cfgWeapons" >> currentWeapon (vehicle player) >> "displayName");

		_HUD_currentAmmo  ctrlSetText format ["%1",_currentAmmo];
		_HUD_reserveAmmo  ctrlSetText format ["%1",_reserveAmmo];
		_HUD_firemode     ctrlSetStructuredText parseText format ["<t align='left' size='1'>[</t><t align='center' size='1'>%1</t><t align='right' size='1'>]</t>",_fireMode];
		_HUD_healthPoints ctrlSetText format ["%1",floor((1-(damage player))*100)];
		_HUD_zeroing  		ctrlSetText format ["%1m", currentZeroing player];
		_HUD_typeGrenade	ctrlSetText _grenadeIcon;
		_HUD_grenades			ctrlSetText format ["%1", _grenades];
		_HUD_weaponName		ctrlSetText _weaponName;

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
