scriptName "fn_setupEventHandlers";
/*--------------------------------------------------------------------
	Author:  A. Roman
    File: fn_setupEventHandlers.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_setupEventHandlers.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

// Remove all handlers
[missionNamespace, "groupPlayerChanged"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "switchedToExtCamera"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "playAreaChanged"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "objStatusChanged"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "playerSwimChanged"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "newEnemiesNearby"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "weaponChanged"] call BIS_fnc_removeAllScriptedEventHandlers;

// Custom Event Handler for Group Change
cl_groupSize = -1;
cl_playAreaPos = [0,0,0];
cl_obj_status = -1;
cl_playerSwimming = !(isTouchingGround player) && (surfaceIsWater (getPosATL player));
cl_enemiesNearby = 0;
cl_currentWeapon = "";
cl_currentWeaponMode = "";
REMOVE_EXISTING_MEH("Map", cl_mapObserverID);
cl_mapObserverID = addMissionEventHandler["Map", {
		params ["_mapIsOpened"];
		if (_mapIsOpened && !cl_mapSetup) then {
			cl_mapSetup = true;
			private _fullScreenMapCtrl = (findDisplay 12) displayCtrl 51;
			_fullScreenMapCtrl ctrlMapAnimAdd [0, 0.075, getPosATL sv_cur_obj];
			ctrlMapAnimCommit _fullScreenMapCtrl;
		};
		if (_mapIsOpened) then {
			300 cutText ["", "PLAIN"];
		} else {
			300 cutRsc ["playerHUD", "PLAIN"];
		};
}];

REMOVE_EXISTING_MEH("EachFrame", cl_eventObserverID);
cl_eventObserverID = addMissionEventHandler["EachFrame", {
		private ["_data"];
		_data = count (units group player);
		if !(_data isEqualTo cl_groupSize) then {
			[missionNamespace, "groupPlayerChanged"] call BIS_fnc_callScriptedEventHandler;
			cl_groupSize = _data;
		};

		_data = cameraView;
		if (_data isEqualTo "EXTERNAL") then {
			[missionNamespace, "switchedToExtCamera"] call BIS_fnc_callScriptedEventHandler;
		};

		_data = getPosATL playArea;
		if !(_data isEqualTo cl_playAreaPos) then {
			[missionNamespace, "playAreaChanged"] call BIS_fnc_callScriptedEventHandler;
			cl_playAreaPos = _data;
		};

		_data = sv_cur_obj getVariable ["status", -1];
		if !(_data isEqualTo cl_obj_status) then {
			[missionNamespace, "objStatusChanged", [_data]] call BIS_fnc_callScriptedEventHandler;
			cl_obj_status = _data;
		};

		_data = !(isTouchingGround player) && (surfaceIsWater (getPosATL player));
		if !(_data isEqualTo cl_playerSwimming) then {
			[missionNamespace, "playerSwimChanged"] call BIS_fnc_callScriptedEventHandler;
			cl_playerSwimming = _data;
		};

		private _enemiesNearby = (player nearEntities ["Man", 10]) select {alive _x && {(_x getVariable ["side", side _x]) != (player getVariable ["side", sideUnknown])}};
		_data =  count _enemiesNearby;
		if !(_data isEqualTo cl_enemiesNearby) then {
			[missionNamespace, "newEnemiesNearby", [_enemiesNearby]] call BIS_fnc_callScriptedEventHandler;
			cl_enemiesNearby = _data;
		};

		private _data = currentWeaponMode player;
		if !(_data isEqualTo cl_currentWeaponMode) then {
			[missionNamespace, "weaponChanged"] call BIS_fnc_callScriptedEventHandler;
			cl_currentWeaponMode = _data;
		};

		private _data = currentWeapon player;
		if !(_data isEqualTo cl_currentWeapon) then {
			[missionNamespace, "weaponChanged"] call BIS_fnc_callScriptedEventHandler;
			cl_currentWeapon = _data;
		};
}];

// If the group size changes (either we left or some other people joined) update the perks
[missionNamespace, "groupPlayerChanged", {
	[] call client_fnc_getSquadPerks;
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "playAreaChanged", {
	["playArea"] call client_fnc_updateLine;
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "playerSwimChanged", {
	if (("swim" in cl_squadPerks) && {player getVariable ["isAlive", false]} && {isNull (objectParent player)} && {!(isTouchingGround player)} && {(surfaceIsWater (getPosATL player))}) then {
		player setAnimSpeedCoef 3;
	} else {
		if ("sprint" in cl_squadPerks) then {
			player setAnimSpeedCoef 1.3;
		} else {
			player setAnimSpeedCoef 1.15;
		};
	};
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "objStatusChanged", {
	// Update objective marker to reflect status
		private _status = param [0, -1, [0]];
		[true] call client_fnc_updateMarkers;
		if (_status isEqualTo 1) then {
			// Make the UI at the top blink
			[] spawn client_fnc_objectiveArmedGUIAnimation;
		};
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "weaponChanged", {
	if (!isNull(objectParent player) || {!((currentWeapon player) isEqualTo (primaryWeapon player))}) exitWith {
		player setVariable ["bayo_equipped", false];
		player setVariable ["gl_equipped", false];
	};

	player setVariable ["bayo_equipped", (currentWeaponMode player) isEqualTo "LIB_Bayonet_Muzzle"];

	private _gl = ["LIB_ACC_GW_SB_Empty", "LIB_ACC_GL_Enfield_CUP_Empty", "LIB_ACC_GL_M7", "LIB_ACC_GL_DYAKONOV_Empty"];
	private _hasGL = (primaryWeaponItems player select 0) in _gl;
	player setVariable ["gl_equipped", _hasGL];
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "switchedToExtCamera", {
	private _infFP = (["InfantryFPOnly", 1] call BIS_fnc_getParamValue) isEqualTo 1;
	private _vehFP = (["VehicleFPOnly", 0] call BIS_fnc_getParamValue) isEqualTo 1;
	if (isNull objectParent player) then {
		if (_infFP) then {
			player switchCamera "INTERNAL";
		};
	} else {
		if (_vehFP) then {
			player switchCamera "INTERNAL";
			["Third person view for vehicles is disabled"] call client_fnc_displayError;
		};
	};
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "newEnemiesNearby", {
	params [["_enemiesNearby", [], []]];
	{
		if (_x getVariable ["melee_action", -1] != -1) then {
			[_x, _x getVariable "melee_action"] call BIS_fnc_holdActionRemove;
		};
		private _id = [
		/* 0 object */							_x,
		/* 1 action title */					"Melee Kill",
		/* 2 idle icon */						WWRUSH_ROOT+"pictures\support.paa",
		/* 3 progress icon */					WWRUSH_ROOT+"pictures\support.paa",
		/* 4 condition to show */				"(_this distance _target) < 2.5 && {alive _target} && {side _this != side _target} && {(_target getRelDir _this) > 90 && (_target getRelDir _this) < 270}",
		/* 5 condition for action */			"(_this distance _target) < 2.5 && {alive _target} && {side _this != side _target} && {(_target getRelDir _this) > 90 && (_target getRelDir _this) < 270}",
		/* 6 code executed on start */			{},
		/* 7 code executed per tick */			{},
		/* 8 code executed on completion */		{
			params ["_target", "_caller"];
			[_caller] remoteExecCall ["client_fnc_meleeTakedown", _target];
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */						[],
		/* 11 action duration */				0.5,
		/* 12 priority */						500,
		/* 13 remove on completion */			false,
		/* 14 show unconscious */				false
		] call BIS_fnc_holdActionAdd;
		_x setVariable ["melee_action", _id];
	} forEach _enemiesNearby;
}] call bis_fnc_addScriptedEventHandler;

// Automatic magazine recombination
REMOVE_EXISTING_PEH("Take", cl_take_eh);
cl_take_eh = player addEventHandler ["Take", {
	private _magInfo = magazinesAmmoFull player;
	private _curMag = currentMagazine player;
	private _bulletCount = 0;
	{
		if ((_x select 0) == _curMag AND !(_x select 2)) then {
			_bulletCount = _bulletCount + (_x select 1);
			player removeMagazine _curMag;
		};
	} forEach _magInfo;

	if (_bulletCount == 0) exitWith {};

	private _maxBulletCountPerMag = getNumber(configfile >> "CfgMagazines" >> _curMag >> "count");
	private _fillMags = true;
	while {_fillMags} do
	{
		if (_bulletCount > _maxBulletCountPerMag) then
		{
			_bulletCount = _bulletCount - _maxBulletCountPerMag;
			player addMagazine [_curMag, _maxBulletCountPerMag];
		} else {
			player addMagazine [_curMag, _bulletCount];
			_fillMags = false;
		};
	};
}];

// Direction indicators and inventory blocker
REMOVE_EXISTING_PEH("InventoryOpened", cl_inv_open_eh);
cl_inv_open_eh = player addEventHandler ["InventoryOpened", {closeDialog 0;true;}];

REMOVE_EXISTING_PEH("Hit", cl_hit_dir_eh);
cl_hit_dir_eh = player addEventHandler ["Hit",{
	private _d = [_this select 0, _this select 1] call BIS_fnc_relativeDirTo;
	if (_d >= 315 || _d <= 45) then {351 cutRsc ["cu","PLAIN"];};
	if (_d >= 45 AND _d <= 135) then {352 cutRsc ["cr","PLAIN"];};
	if (_d >= 135 AND _d <= 225) then {353 cutRsc ["cd","PLAIN"];};
	if (_d >= 225 AND _d <= 315) then {354 cutRsc ["cl","PLAIN"];};
	if ((_this select 1) == player) then {
		351 cutRsc ["cu","PLAIN"];
		352 cutRsc ["cr","PLAIN"];
		353 cutRsc ["cd","PLAIN"];
		354 cutRsc ["cl","PLAIN"];
	};
}];

// Hit
REMOVE_EXISTING_PEH("Hit", cl_hit_hp_regen_eh);
cl_hit_hp_regen_eh = player addEventHandler ["Hit", {
	// Stop any hp regeneration thread
	TERMINATE_SCRIPT(client_hpregeneration_thread);

	// Did we get hit by a player? Add it to our assist-array
	private _causedBy = _this select 1;
	if (!isNull _causedBy && isPlayer _causedBy) then {
		["Assists detected 0"] call server_fnc_log;
		[_causedBy, _this select 2] call client_fnc_countAssist;
	};

	// Hp regeneration
	client_hpregeneration_thread = [] spawn client_fnc_regenerateHP;
}];

// Killed
REMOVE_EXISTING_PEH("Killed", cl_killed_eh);
cl_killed_eh = player addEventHandler ["Killed", {
	private _victim = _this select 0;
	private _lastDeath = _victim getVariable ["lastDeath", 0];

	if (cl_inSpawnMenu || missionNamespace getVariable ["cl_forceSwitch", false]) exitWith {
		setPlayerRespawnTime 0;
	};
 	//Avoiding more than one time each 1/10 of a second
	if (diag_tickTime - _lastDeath > 0.1) then {
		_victim setVariable ["lastDeath", diag_tickTime];
		_victim setVariable ["wwr_unit_loadout", getUnitLoadout _victim];
		private _killer = _this select 1;
		private _instigator = _this select 2;
		// Increase deaths
		cl_deaths = cl_deaths + 1;
		cl_total_deaths = cl_total_deaths + 1;

		_victim setVariable ["deaths",cl_deaths,true];

		if (!isNull _instigator) then {
			_killer = _instigator;
		};

		if (_killer != player) then {
			_killer setVariable ["killed_by", (_killer getVariable ["killed_by", 0]) + 1];
			_killer setVariable ["health", 1 - (damage _killer)];
			private _weapon = _killer getVariable ["lastWeaponFired", ""];
			if (_weapon isEqualTo "") then {
				_weapon = currentWeapon _killer;
			};
			_killer setVariable ["weapon", _weapon];
		};

		[format ["You have been killed by killer %1", str _killer]] call server_fnc_log;
		[format ["You have been killed by instigator %1", str _instigator]] call server_fnc_log;

		// Attempt to retrieve the grenade that killed the unit
		private _grenade = _victim getVariable ["grenade_kill", ""];
		// Check if the player was killed via melee takedown
		private _meleeKiller = _victim getVariable ["melee_killer", objNull];
		private _wasMelee = false;
		if (!isNull _meleeKiller) then {
			_killer = _meleeKiller;
			_wasMelee = true;
			_victim setVariable ["melee_killer", nil];
		};
		// Send message to killer that he killed someone
		if ((!isNull _victim) && {!isNull _killer} && {_victim != _killer}) then {
			if (_victim getVariable ["isAlive", false]) then {
        private _wasHS = _victim getVariable ["wasHS", false];
				[_victim, _wasHS, _grenade, _wasMelee] remoteExecCall ["client_fnc_kill", _killer];
				_victim setVariable ["isAlive", false];
			};
			// you have been killed by message - DONE BY KILLCAM
			// [format ["You have been killed by<br/>%1", _killer getVariable ["name", name _killer]]] call client_fnc_displayInfo;

		};
		// Send message to all units that we are reviveable
		// As this package gets send to all clients we might aswell use it to share our information regarding assists (damage that was inflicted on us)
		[_victim, _killer, cl_assistsInfo, _grenade, _wasMelee] remoteExec ["client_fnc_medic_unitDied", 0];
		// Disable hud
		["rr_spawn_bottom_right_hud_renderer", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		300 cutRsc ["default","PLAIN"];

		TERMINATE_SCRIPT(rr_respawn_thread);
		rr_respawn_thread = [_killer] spawn client_fnc_killed;

		_victim setVariable ["isAlive", false];

		private _spawnSafeDistance = (getNumber (missionConfigFile >> "MapSettings" >> sv_mapSize >> "safeSpawnDistance"));
		private _spawnSafeTime = ["SpawnSafeTime", 5] call BIS_fnc_getParamValue;
		private _spawnMarker = format ["mobile_respawn_%1", _victim getVariable "gameSide"];
		if (_killer getVariable ["gameSide", "attackers"] != (_victim getVariable ["gameSide", "defenders"]) &&
				{(diag_tickTime - cl_spawn_tick) < _spawnSafeTime} &&
				{(_victim distance (getMarkerPos _spawnMarker)) < _spawnSafeDistance}) exitWith {
			// Info
			["Your killer has been punished for spawn camping, your death will not be counted"] call client_fnc_displayError;
			cl_deaths = cl_deaths - 1;
			cl_total_deaths = cl_total_deaths - 1;

			// Revive us
			[objNull, true] spawn client_fnc_revive;

			// Kill the killer
			["You have been killed for spawn camping"] remoteExecCall ["client_fnc_administrationKill",_killer];
		};
	};
}];

// Assign current weapon to player when firing (to avoid PUT and THROW)
REMOVE_EXISTING_PEH("Fired", cl_fired_eh);
cl_fired_eh = player addEventHandler ["Fired", {
  params ["_unit", "_weapon"];
  private _lastWepon = _unit getVariable ["lastWeaponFired", ""];
  if !(_weapon isEqualTo _lastWepon) then
  {
    _unit setVariable ["lastWeaponFired", _weapon,true];
  };
}];

// Handledamage
REMOVE_EXISTING_PEH("HandleDamage", cl_handledmg_eh);
cl_handledmg_eh = player addEventHandler ["HandleDamage", {
	params ["_unit", "_hitSelection", "_damage", "_shooter", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	// Instigator is defined? If yes, it's more accurate than shooter
	if (!isNull _instigator) then {
		_shooter = _instigator;
	};
	// If the shooter is still unknown, highly reduce damage
	if (isNull _shooter) exitWith {_damage/10};
	private _shooterSide = _shooter getVariable ["gameSide", "attackers"];
	private _unitSide = _unit getVariable ["gameSide", "defenders"];
	private _grenades = ["lib_us_mk_2", "lib_shg24", "lib_rg42", "lib_millsbomb"];
	_projectile = toLower _projectile;
	// If the damage
	if (_damage >= 1 && {isNil {_unit getVariable "grenade_kill"}} && {_projectile in _grenades}) then {
		_unit setVariable ["grenade_kill", _projectile];
		[_unit] spawn {
			params ["_unit"];
			uiSleep 0.25;
			_unit setVariable ["grenade_kill", nil];
		};
	} else {
		// Is the shooter on the opposite side of the victim and is the victim alive?
		if ((_shooterSide != _unitSide) && _unit getVariable ["isAlive", true]) then {
			private _isExplosive = (getNumber(configFile >> "CfgAmmo" >> _projectile >> "explosive")) > 0;
			//If critical damage to the head kill the victim and reward the shooter with HS bonus
			if (_damage >= 0.3 && {_hitSelection in ["head", "face_hub"]} && {_projectile != ""} && {!_isExplosive}) then {
				// Has the HS kill already been awarded?
				if (!(_unit getVariable ["wasHS", false])) then {
					_unit setVariable ["wasHS", true];
	        _damage = 1 + _damage;
				};
			} else {
				// Get the last weapon the shooter fired
				private _shooterWeapon = _shooter getVariable ["lastWeaponFired", ""];
				// Was it not defined? Get the current one, we might be lucky
				if (_shooterWeapon isEqualTo "") then {
					_shooterWeapon = currentWeapon _shooter;
				};
				// Is it not a listed weapon?
				private _isWeaponListed = isClass(missionConfigFile >> "Unlocks" >> _shooterSide >> _shooterWeapon);
				// If it is listed, get the multiplier, else don't do anything and use 1
				private _damageMultiplier = if (_isWeaponListed) then {
					getNumber(missionConfigFile >> "Unlocks" >> _shooterSide >> _shooterWeapon >> "damageMultiplier")
				} else {1};
				// Handle only the global hit part
				if (_hitSelection isEqualTo "") then {
					// Set the damage we are dealing according to the weapon that got us
					private _dmgPrev = damage _unit;
					private _hitDealt = _damage - _dmgPrev;
					_damage = _dmgPrev + (_hitDealt * _damageMultiplier);
					if (_projectile isEqualTo "lib_b_bayonet") then {
						_damage = 1 + _damage;
					};
					// If the damage is non fatal
					if (_damage > 0 && _damage < 1) then {
						// Display hit marker
						_damage remoteExec ["client_fnc_MPHit", _shooter];
					};
				} else {
					// Don't damage the part if it's not the global hit part
					_damage = _unit getHit _hitSelection;
				};
			};
		};
	};

	// If instead the shooter is on the same side as the victim (friendly fire) and it's not suicide
	if (((_shooterSide == _unitSide) && {_shooter != _unit})) then {
		// Disable damage
		_damage = damage _unit;
	};
 _damage
}];

// Getin Eventhandler for vehicles
REMOVE_EXISTING_PEH("GetInMan", cl_get_in_man_eh);
cl_get_in_man_eh = player addEventHandler ["GetInMan", {
	private _unit = param[0, objNull, [objNull]];
	private _vehicle = param[2, objNull, [objNull]];
	_vehicle allowDamage true;

	_vehicle enableSimulation true;

	if (_vehicle isKindOf "Air") then {
		if ((typeOf _vehicle) isEqualTo "NonSteerable_Parachute_F") then {
			[_vehicle] spawn {
				private _vehicle = param[0, objNull, [objNull]];
				waitUntil{(getPosATL _vehicle) select 2 < 3};
				deleteVehicle _vehicle;
			};
		} else {
			setObjectViewDistance 1500;
			setViewDistance 3000;
			if ((getPos _vehicle) select 2 > 5) then {
				_vehicle setVectorUp [0,0,1];
				_vehicle setVelocityModelSpace [0, 60, 10];
			};
			[_vehicle] spawn {
				private _vehicle = param[0, objNull, [objNull]];
				private _fuelTime = getNumber(missionConfigFile >> "Vehicles" >> "Plane" >> "fuelTime");
				uiSleep (_fuelTime - 10);
				private _timeLeft = diag_tickTime + 10;
				while {_timeLeft > diag_tickTime && ((vehicle player) isEqualTo _vehicle)} do {
					[format["YOU'LL RUN OUT OF FUEL IN %1 SECONDS<br /><t size='1.25'>PREPARE TO BAIL OUT!</t>", round (_timeLeft - diag_tickTime)]] call client_fnc_displayError;
					uiSleep 1;
				};
				if (local _vehicle) then {
					_vehicle setFuel 0;
				};
			};
		};
	};

	/* if ((count (crew _vehicle) > 0) && {_vehicle getVariable ["last_man", objNull] != objNull}) then {
		_vehicle setVariable ["last_man", objNull, true];
	}; */

	_vehicle removeAllEventHandlers "Killed";
	_vehicle addEventHandler ["Killed", {
		params ["_vehicle", "_killer", "_instigator"];

		if (!isNull _instigator) then {
			_killer = _instigator;
		};

		if (!isPlayer _killer) then {
			_killer = _vehicle getVariable ["last_hit_source", objNull];
		};

		if (isNull _killer) exitWith {};

		private _isKindOfInArray = {
			params ["_target", "_array"];
			private _result = false;
			{
			  if (_target isKindOf _x) exitWith {
					_result = true
				};
			} forEach _array;
			_result
		};

		if ((local _vehicle) && {player getVariable ["side", sideUnknown] != _killer getVariable ["side", sideUnknown]}) exitWith {
			private _vehType = typeOf _vehicle;
			private _isPlane = _vehType isKindOf "Air";
			if (_isPlane) exitWith {
				[500, true, "AIRPLANE"] remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			private _isAPC = _vehType isKindOf "Wheeled_APC_F" && {[_vehType, getArray(missionConfigFile >> "Vehicles" >> "apc")] call _isKindOfInArray};
			private _isIFV = _vehType isKindOf "LIB_WheeledTracked_APC_base" && {[_vehType, getArray(missionConfigFile >> "Vehicles" >> "ifv")] call _isKindOfInArray};
			if (_isAPC || _isIFV) exitWith {
				[200, true, "ARMORED CAR"] remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			private _isLight = _vehType isKindOf "LIB_Tank_base" && {[_vehType, getArray(missionConfigFile >> "Vehicles" >> "ltanks")] call _isKindOfInArray};
			if (_isLight) exitWith {
				[300, true, "LIGHT TANK"] remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			private _isHeavy = _vehType isKindOf "LIB_Tank_base" && {[_vehType, getArray(missionConfigFile >> "Vehicles" >> "htanks")] call _isKindOfInArray};
			if (_isHeavy) exitWith {
				[500, true, "HEAVY TANK"] remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			[100, true, "VEHICLE"] remoteExec ["client_fnc_vehicleDisabled", _killer];
		};
 }];

	// Always make sure we have an hit eventhandler
	_vehicle removeAllEventHandlers "HandleDamage";
	_vehicle addEventHandler ["HandleDamage", {
		params ["_vehicle", "_hitSelection", "_damage", "_shooter", "_projectile"];
  	private _rockets = ["LIB_60mm_M6", "LIB_R_88mm_RPzB", "LIB_1Rnd_89m_PIAT"];
		if (_projectile in _rockets) then {
			_damage = damage _vehicle + (_damage*2);
		};
		_damage
	}];

	_vehicle removeAllEventHandlers "Hit";
	_vehicle addEventHandler ["Hit", {
		params ["_vehicle", "_source", "_damage", "_shooter"];
		if (!isNull _shooter) then {
			_source = _shooter;
		};
		if ((!isNull _source) && (_damage > 0.1) && {_source != player}) then {
			0.1 remoteExec ["client_fnc_MPHit", _source];
		};

		if (_vehicle getVariable ["disabled", false]) exitWith {};

		if (local _vehicle && {(player getVariable ["side", sideUnknown]) != (_source getVariable ["side", sideUnknown])} && {!(canMove _vehicle)}) then {
			_vehicle setVariable ["disabled", true, true];
			if (_vehicle isKindOf "Tank") then {
				200 remoteExec ["client_fnc_vehicleDisabled", _source];
			};
			if (_vehicle isKindOf "Car") then {
				100 remoteExec ["client_fnc_vehicleDisabled", _source];
			};
			if (isPlayer _source && {_damage > 0.01}) then {
				_vehicle setVariable ["last_hit_source", _source, true];
			};
		};
	}];
}];

REMOVE_EXISTING_PEH("GetOutMan", cl_get_out_man);
cl_get_out_man = player addEventHandler ["GetOutMan", {
	private _vehicle = param[2, objNull, [objNull]];
	if (count (crew _vehicle) == 0) then {
		_vehicle setVariable ["last_man", player, true];
	};
	private _pos = getPos player;
	if (_vehicle isKindOf "Air") then {
		setObjectViewDistance 1000;
		setViewDistance 1250;
	};
	if ((_vehicle isKindOf "Air") && (_pos select 2 > 5)) then {
		private _velPlayer = (velocity player) vectorMultiply 0.1;
		player setVelocity _velPlayer;
		if (player getVariable ["hasChute", true]) then {
			["PRESS <t size='1.5'>[SPACE BAR]</t> TO OPEN YOUR PARACHUTE!"] call client_fnc_displayInfo;
		};
	};
}];
true
