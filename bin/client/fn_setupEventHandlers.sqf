scriptName "fn_setupEventHandlers";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A. Roman
    File: fn_setupEventHandlers.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_setupEventHandlers.sqf"
if (isServer && !hasInterface) exitWith {};


// Remove all handlers
player removeAllEventHandlers "Take";
player removeAllEventHandlers "InventoryOpened";
player removeAllEventHandlers "Hit";
player removeAllEventHandlers "HitPart";
player removeAllEventHandlers "Killed";
player removeAllEventHandlers "Respawn";
player removeAllEventHandlers "HandleDamage";
[missionNamespace, "groupPlayerChanged"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "switchedToExtCamera"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "playAreaChanged"] call BIS_fnc_removeAllScriptedEventHandlers;
[missionNamespace, "objStatusChanged"] call BIS_fnc_removeAllScriptedEventHandlers;

// Custom Event Handler for Group Change
cl_groupSize = -1;
cl_playAreaPos = [0,0,0];
cl_obj_status = -1;
addMissionEventHandler["EachFrame", {
		private _data = count (units group player);
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
			[missionNamespace, "objStatusChanged"] call BIS_fnc_callScriptedEventHandler;
			cl_obj_status = _data;
		};
}];

// If the group size changes (either we left or some other people joined) update the perks
[missionNamespace, "groupPlayerChanged", {
		[] spawn client_fnc_getSquadPerks;
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "playAreaChanged", {
		["playArea"] spawn client_fnc_updateLine;
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "objStatusChanged", {
	// Update objective marker to reflect status
		[true] spawn client_fnc_updateMarkers;
		if ((sv_cur_obj getVariable ["status", -1]) isEqualTo 1) then {
			// Make the UI at the top blink
			[] spawn client_fnc_objectiveArmedGUIAnimation;
		};
}] call bis_fnc_addScriptedEventHandler;

[missionNamespace, "switchedToExtCamera", {
	private _infFP = [false, true] select (paramsArray#15);
	private _vehFP = [false, true] select (paramsArray#16);
	if (isNull objectParent player) then {
		if (_infFP) then {
			player switchCamera "INTERNAL";
		};
	} else {
		if (_vehFP) then {
			player switchCamera "INTERNAL";
			["Third person view for vehicles is disabled"] spawn client_fnc_displayError;
		};
	};
}] call bis_fnc_addScriptedEventHandler;

// Automatic magazine recombination
player addEventHandler ["Take", {
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
player addEventHandler ["InventoryOpened", {closeDialog 0;true;}];

player addEventHandler ["Hit",{
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
player addEventHandler ["Hit",
{
	// Stop any hp regeneration thread
	if (!isNil "client_hpregeneration_thread") then {
		terminate client_hpregeneration_thread;
	};

	// In combat
	if !(player getVariable ["inCombat", false]) then {
		player setVariable ["inCombat",true,true];
	};

	// Did we get hit by a player? Add it to our assist-array
	private _causedBy = _this select 1;
	if (!isNull _causedBy && isPlayer _causedBy) then {
		["Assists detected 0"] call server_fnc_log;
		[_causedBy, _this select 2] spawn client_fnc_countAssist;
	};

	// Hp regeneration
	client_hpregeneration_thread = [] spawn client_fnc_regenerateHP;
}];

// Killed
player addEventHandler ["Killed", {
	private _victim = _this select 0;
	private _lastDeath = _victim getVariable ["lastDeath", 0];
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

		[format ["You have been killed by killer %1", str _killer]] call server_fnc_log;
		[format ["You have been killed by instigator %1", str _instigator]] call server_fnc_log;

		// Send message to killer that he killed someone
		if ((_victim != _killer) && (!isNull _victim) && (!isNull _killer)) then {
			if (_victim getVariable ["isAlive", true]) then {
				[_victim, false] remoteExec ["client_fnc_kill", _killer];
				_victim setVariable ["isAlive", false];
			};
			// you have been killed by message
			[format ["You have been killed by<br/>%1", _killer getVariable ["name", "ERROR: No Name"]]] spawn client_fnc_displayInfo;

			// Send message to all units that we are reviveable
			// As this package gets send to all clients we might aswell use it to share our information regarding assists (damage that was inflicted on us)
			[_victim,_killer, cl_assistsInfo] remoteExec ["client_fnc_medic_unitDied", 0];
		};

		// Disable hud
		["rr_spawn_bottom_right_hud_renderer", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		300 cutRsc ["default","PLAIN"];

		rr_respawn_thread = [] spawn client_fnc_killed;

		_victim setVariable ["isAlive", false];

		private _spawnSafeDistance = (getNumber (missionConfigFile >> "MapSettings" >> "safeSpawnDistance"));
		private _spawnSafeTime = paramsArray#6;
		private _spawnMarker = format ["mobile_respawn_%1", _victim getVariable "gameSide"];
		if (_killer getVariable ["gameSide", "attackers"] != (_victim getVariable ["gameSide", "defenders"]) &&
				{(diag_tickTime - cl_spawn_tick) < _spawnSafeTime} &&
				{(_victim distance (getMarkerPos _spawnMarker)) < _spawnSafeDistance}) exitWith {
			// Info
			["Your killer has been punished for spawn camping, your death will not be counted"] spawn client_fnc_displayError;
			cl_deaths = cl_deaths - 1;
			cl_total_deaths = cl_total_deaths - 1;

			// Revive us
			[] spawn {
				sleep 0.5;
				[objNull, true] spawn client_fnc_revive;
			};

			// Kill the killer
			["You have been killed for spawn camping"] remoteExec ["client_fnc_administrationKill",_killer];
		};
	};
}];

// Respawn
/*player addEventHandler ["Respawn", {
	["Player respawned"] spawn server_fnc_log;
	[format["sv_gameStatus %1 cl_revived %2", sv_gameStatus, cl_revived]] spawn server_fnc_log;
	if (sv_gameStatus == 2 && !cl_revived) then {
		[] spawn client_fnc_spawn;

		player enableStamina false;
		player forceWalk false;
	};
}];*/



// Handledamage
player addEventHandler ["HandleDamage", {
	params ["_unit", "_hitSelection", "_damage", "_shooter", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	if (!isNull _instigator) then {
		_shooter = _instigator;
	};
	//If critical damage to the head kill the victim and reward the shooter with HS bonus
	if !((side _shooter) isEqualTo (side _unit)) then {
		if ((_hitSelection in ["head", "face_hub"]) && {_damage >= 0.2} && {_unit getVariable ["isAlive", true]}) then {
			if (!(_unit getVariable ["wasHS", false])) then {
				[_unit, true] remoteExec ["client_fnc_kill",_shooter];
				_unit setDamage 1;
				_unit setVariable ["wasHS", true];
				_unit setVariable ["isAlive", false];
			};
		} else {
			private _mgs = 			  ["LIB_MG34", "LIB_MG42", "LIB_FG42G", "LIB_DP28", "LIB_DT", "LIB_M1918A2_BAR", "LIB_M1919A4", "LIB_M1919A6"];
			private _bolts = 		  ["LIB_G3340", "LIB_K98_Late", "LIB_M1903A3_Springfield", "LIB_M1903A4_Springfield", "LIB_DELISLE", "LIB_K98", "LIB_K98ZF39", "LIB_M9130", "LIB_M38", "LIB_M44"];
			private _smgs = 			["LIB_M1A1_Thompson", "LIB_M1928A1_Thompson", "LIB_M1928_Thompson", "LIB_MP38", "LIB_MP40", "LIB_M3_GreaseGun", "LIB_PPSh41_m", "LIB_MP44"];
			private _semiAutos =  ["LIB_G43", "LIB_M1A1_Carbine", "LIB_M1_Carbine", "LIB_M1_Garand", "LIB_G41", "LIB_SVT_40"];
			private _pistols =	  ["LIB_P38", "LIB_M1895", "LIB_TT33", "LIB_M1896", "LIB_Colt_M1911"];
			if (_hitSelection isEqualTo "") then {
				if (currentWeapon _shooter in _mgs) then {_damage = _damage/25};
				if (currentWeapon _shooter in _bolts) then {_damage = _damage/0.5};
				if (currentWeapon _shooter in _smgs) then {_damage =  _damage/5};
				if (currentWeapon _shooter in _semiAutos) then {_damage = _damage/1.8};
				if (currentWeapon _shooter in _pistols) then {_damage = _damage/2.5};
				_damage = (damage _unit) + _damage;
				if (_unit getVariable ["isAlive", true] && {_damage > 0} && {_damage < 1}) then {
					_damage remoteExec ["client_fnc_MPHit", _shooter];
				};
			} else {
				_damage = _unit getHit _hitSelection;
			};
		};
	};

	if (((side (gunner vehicle _shooter) == side _unit) || {side (driver vehicle _shooter) == side _unit}) && {_shooter != _unit}) then {
	 _damage = damage _unit;
	};

 _damage
}];

// Getin Eventhandler for vehicles
player addEventHandler ["GetInMan", {
	private _unit = param[0, objNull, [objNull]];
	private _vehicle = param[2, objNull, [objNull]];
	_vehicle allowDamage true;

	if ((count (crew _vehicle) > 0) && {_vehicle getVariable ["last_man", objNull] != objNull}) then {
		_vehicle setVariable ["last_man", objNull, true];
	};

	_vehicle removeAllEventHandlers "Killed";
	_vehicle addEventHandler ["Killed", {
		params ["_vehicle", "_killer", "_instigator"];

		private _sendVehicleKill = {
			params ["_vehicle", "_killer"];
			{[_x, false] remoteExec ["client_fnc_kill", _killer];} forEach crew _vehicle;
			private _halfTrucks = ["LIB_US_M3_Halftrack", "LIB_SdKfz251", "LIB_SdKfz251_FFV", "LIB_M8_Greyhound", "LIB_SdKfz234_2"];
			if (_vehicle isKindOf "Tank" && !((typeOf _vehicle) in _halfTrucks)) exitWith {
				500 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			if ((typeOf _vehicle) in _halfTrucks) exitWith {
				300 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			if (_vehicle isKindOf "Car") exitWith {
				150 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
		};

		if (!isNull _instigator) then {
			_killer = _instigator;
		};

		if (!isPlayer _killer) then {
			_killer = _vehicle getVariable ["last_hit_source", objNull];
		};

		if (isNull _killer) exitWith {};

		if (count (crew _vehicle) > 0) exitWith {
			_unit = (crew _vehicle) select 0;
			if ((player isEqualto _unit) && (_unit getVariable ["gameSide", "attackers"] != _killer getVariable ["gameSide", "defenders"])) then {
				[_vehicle, _killer] spawn _sendVehicleKill;
			};
		};
		private _lastMan = _vehicle getVariable ["last_man", objNull];
		if (player isEqualto _lastMan) exitWith {
			if (_lastMan getVariable ["gameSide", "attackers"] != _killer getVariable ["gameSide", "defenders"]) then {
				[_vehicle, _killer] spawn _sendVehicleKill;
			};
		};
 }];

	// Always make sure we have an hit eventhandler
	_vehicle removeAllEventHandlers "HandleDamage";
	_vehicle addEventHandler ["HandleDamage", {
		params ["_vehicle", "_hitSelection", "_damage", "_shooter", "_projectile"];
  	private _rockets = ["LIB_60mm_M6", "LIB_R_88mm_RPzB"];
		if (_vehicle isKindOf "Tank" && {_projectile in _rockets}) then {
			_damage = damage _vehicle + (_damage*2);
		};
		if ((_vehicle isKindOf "Car" || {(typeOf _vehicle) in ["LIB_US_M3_Halftrack", "LIB_SdKfz251", "LIB_SdKfz251_FFV"]}) && {_projectile in _rockets}) then {
			if (_projectile in _rockets) then {
				_damage = 1;
			};
		};
		_damage
	}];

	_vehicle removeAllEventHandlers "Hit";
	_vehicle addEventHandler ["Hit", {
		params ["_vehicle", "_source", "_damage", "_shooter"];
		if (!isNull _shooter) then {
			_source = _shooter;
		};
    0.1 remoteExec ["client_fnc_MPHit", _source];
		if (_vehicle getVariable ["disabled", false]) exitWith {};
		if (count (crew _vehicle) > 0) then {
			_unit = crew _vehicle select 0;
			if ((player isEqualTo _unit) && {(_unit getVariable ["gameSide", "attackers"]) != (_source getVariable ["gameSide", "defenders"])} && {!(canMove _vehicle)}) then {
				_vehicle setVariable ["disabled", true, true];
				if (_vehicle isKindOf "Tank") exitWith {
					200 remoteExec ["client_fnc_vehicleDisabled", _source];
				};
				if (_vehicle isKindOf "Car") exitWith {
					100 remoteExec ["client_fnc_vehicleDisabled", _source];
				};
			};
		};
		if (isPlayer _source && {_damage > 0.01}) then {
			_vehicle setVariable ["last_hit_source", _source];
		};
	}];

	if (_vehicle isKindOf "Air") then {
		if (typeOf _vehicle isEqualTo "NonSteerable_Parachute_F") then {
			[_vehicle] spawn {
				private _vehicle = param[0, objNull, [objNull]];
				waitUntil{(getPosATL _vehicle) select 2 < 3};
				deleteVehicle _vehicle;
			};
		} else {
			[_vehicle] spawn {
				private _vehicle = param[0, objNull, [objNull]];
				private _side = ["Attacker", "Defender"] select ((player getVariable ["gameSide", "defenders"]) isEqualTo "defenders");
				private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> _side);
				_configs = _configs select {(getText(_x >> "className")) isEqualTo (typeOf _vehicle)};
				if (count _configs != 0) then {
					private _fuelTime = getNumber(_configs select 0 >> "fuelTime");
					sleep (_fuelTime - 10);
					private _timeLeft = 10;
					while {_timeLeft > 0 && ((vehicle player) isEqualTo _vehicle)} do {
						[format["YOU'LL RUN OUT OF FUEL IN %1 SECONDS<br /><t size='1.25'>PREPARE TO BAIL OUT!</t>", _timeLeft]] spawn client_fnc_displayError;
						sleep 1;
						_timeLeft = _timeLeft - 1;
					};
				};
			};
		};
	};
}];

player addEventHandler ["GetOutMan", {
	private _vehicle = param[2, objNull, [objNull]];
	if (count (crew _vehicle) == 0) then {
		_vehicle setVariable ["last_man", player, true];
	};
	private _pos = getPos player;
	if ((_vehicle isKindOf "Air") && (_pos select 2 > 5)) then {
		private _velPlayer = velocity player;
		{_velPlayer set [_forEachIndex, _x/5]} forEach _velPlayer;
		player setVelocity _velPlayer;
		if (player getVariable ["hasChute", true]) then {
			["PRESS <t size='1.5'>[SPACE BAR]</t> TO OPEN YOUR PARACHUTE!"] spawn client_fnc_displayInfo;
		};
		/* [] spawn {
			waitUntil{((getPosATL player) select 2) < 30};
			if (isNull (objectParent player)) then {
				private _velPlayer = velocity player;
				{_velPlayer set [_forEachIndex, _x/5]} forEach _velPlayer;
				private _posPlayer = position player;
				private _dirPlayer = getDir player;
				private _para = "NonSteerable_Parachute_F" createVehicle _posPlayer;
				player moveInDriver _para;
				_para setPos _posPlayer;
				_para setVelocity _velPlayer;
				_para setDir _dirPlayer;
			};
		}; */
	};
}];
