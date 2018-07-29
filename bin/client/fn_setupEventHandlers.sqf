scriptName "fn_setupEventHandlers";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_setupEventHandlers.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
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

// Automatic magazine recombination
player addEventHandler ["Take",
{
	_magInfo = magazinesAmmoFull player;
	_curMag = currentMagazine player;
	_bulletCount = 0;
	{
		if ((_x select 0) == _curMag AND !(_x select 2)) then {
			_bulletCount = _bulletCount + (_x select 1);
			player removeMagazine _curMag;
		};
	} forEach _magInfo;

	if (_bulletCount == 0) exitWith {};

	_maxBulletCountPerMag = getNumber(configfile >> "CfgMagazines" >> _curMag >> "count");
	_fillMags = true;
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
	_d = [_this select 0, _this select 1] call BIS_fnc_relativeDirTo;
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
	_causedBy = _this select 1;
	if (!isNull _causedBy && isPlayer _causedBy) then {
		["Assists detected 0"] call server_fnc_log;
		[_causedBy, _this select 2] spawn client_fnc_countAssist;
	};

	// Hp regeneration
	client_hpregeneration_thread = [] spawn client_fnc_regenerateHP;
}];

// Killed
player addEventHandler ["Killed",{
	_victim = _this select 0;
	_lastDeath = _victim getVariable ["lastDeath", 0];
	//Avoiding more than one time each 1/10 of a second
	if (diag_tickTime - _lastDeath > 0.1) then {
		// Increase deaths
		cl_deaths = cl_deaths + 1;
		cl_total_deaths = cl_total_deaths + 1;

		_victim setVariable ["deaths",cl_deaths,true];

		// Killer
		_killer = _this select 1;
		_instigator = _this select 2;

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
			_victim setVariable ["lastDeath", diag_tickTime];
			// you have been killed by message
			[format ["You have been killed by<br/>%1", name _killer]] spawn client_fnc_displayInfo;

			// Send message to all units that we are reviveable
			// As this package gets send to all clients we might aswell use it to share our information regarding assists (damage that was inflicted on us)
			[_victim,_killer, cl_assistsInfo] remoteExec ["client_fnc_medic_unitDied", 0];
		};

		// Disable hud
		["rr_spawn_bottom_right_hud_renderer", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		300 cutRsc ["default","PLAIN"];

		rr_respawn_thread = [] spawn client_fnc_killed;

		_victim setVariable ["isAlive", false];

		_spawnSafeDistance = (getNumber (missionConfigFile >> "MapSettings" >> "safeSpawnDistance"));
		_spawnSafeTime = "SpawnSafeTime" call bis_fnc_getParamValue;
		_spawnMarker = format ["mobile_respawn_%1", _victim getVariable "gameSide"];
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
				[] spawn client_fnc_revive;
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
	_currentDmg = _unit getVariable ["unitDmg", 0];
	//If critical damage to the head kill the victim and reward the shooter with HS bonus
	if (side _shooter != side _unit && {_currentHP <= 1}) then {
		if ((_hitSelection in ["head", "face_hub"]) && {_damage >= 1} && {alive _unit}) then {
			if (!(_unit getVariable ["wasHS", false])) then {
				[_unit, true] remoteExec ["client_fnc_kill",_shooter];
				_unit setDamage 1;
				_unit setVariable ["wasHS", true];
				_unit setVariable ["isAlive", false];
			};
		} else {
			_mgs = 			  ["LIB_MG34", "LIB_MG42", "LIB_M1918A2_BAR", "LIB_M1919A6", "LIB_MP44"];
			_bolts = 		  ["LIB_G3340", "LIB_K98_Late", "LIB_M1903A3_Springfield", "LIB_G43"];
			_smgs = 			["LIB_M1A1_Thompson", "LIB_M1928A1_Thompson", "LIB_M1928_Thompson", "LIB_MP38", "LIB_MP40"];
			_semiAutos =  ["LIB_G43", "LIB_M1_Carbine", "LIB_M1A1_Carbine", "LIB_M1_Garand"];
			_pistols =	  ["fow_w_type14", "fow_w_m1911"];
	    if (_hitSelection isEqualTo "") then {
				if (alive _unit && {_damage > 0.01} && {_damage < 1}) then {
					_damage remoteExec ["client_fnc_MPHit", _shooter];
				};
				_hit = 0;
				if (currentWeapon _shooter in _mgs) then {_hit = _damage/3.75};
				if (currentWeapon _shooter in _bolts) then {_hit = _damage/0.5};
				if (currentWeapon _shooter in _smgs) then {_hit =  _damage/3};
				if (currentWeapon _shooter in _semiAutos) then {_hit = _damage/1.8};
				if (currentWeapon _shooter in _pistols) then {_hit = _damage/1};
				_hit = _hit + _currentDmg;
				_unit setVariable ["unitDmg", _hit];
				_unit setDamage _hit;
				_damage = damage _unit;
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
	params ["_unit", "_role", "_vehicle", "_turret"];
	_vehicle allowDamage true;

	if (count crew _vehicle > 0 && {_vehicle getVariable ["last_man", objNull] != objNull}) then {
		_vehicle setVariable ["last_man", objNull, true];
	};

	_vehicle removeAllEventHandlers "Killed";
	_vehicle addEventHandler ["Killed", {
		params ["_vehicle", "_killer", "_instigator", "_useEffects"];

		_sendVehicleKill = {
			params ["_vehicle", "_killer"];
			{[_x, false] remoteExec ["client_fnc_kill", _killer];} forEach crew _vehicle;
			_halfTrucks = ["LIB_US_M3_Halftrack", "LIB_SdKfz251", "LIB_SdKfz251_FFV"];
			if (_vehicle isKindOf "Tank" && !(typeOf _vehicle in _halfTrucks)) exitWith {
				500 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			if (typeOf _vehicle in _halfTrucks) exitWith {
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
			_unit = crew _vehicle select 0;
			if ((player isEqualto _unit) && (_unit getVariable ["gameSide", "attackers"] != _killer getVariable ["gameSide", "defenders"])) then {
				[_vehicle, _killer] spawn _sendVehicleKill;
			};
		};
		_lastMan = _vehicle getVariable ["last_man", objNull];
		if (player isEqualto _lastMan) exitWith {
			if (_lastMan getVariable ["gameSide", "attackers"] != _killer getVariable ["gameSide", "defenders"]) then {
				[_vehicle, _killer] spawn _sendVehicleKill;
			};
		};
 }];

	// Always make sure we have an hit eventhandler
	_vehicle removeAllEventHandlers "HandleDamage";
	_vehicle addEventHandler ["HandleDamage", {
		params ["_vehicle", "_hitSelection", "_damage", "_shooter", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
  	_rockets = ["LIB_60mm_M6", "LIB_R_88mm_RPzB"];
		if (_vehicle isKindOf "Tank" && {_projectile in _rockets}) then {
			_damage = damage _vehicle + (_damage*3);
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
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	if (count (crew _vehicle) == 0) then {
		_vehicle setVariable ["last_man", player, true];
	};
	_pos = getPosATL player;
	if ((_pos select 2) > 75) then {
		waitUntil {((getPosATL player) select 2) < 75};
		if (vehicle player == player) then
		{
			_para = "Steerable_Parachute_F" createVehicle position player;
			_velPlayer = (velocity player);
			_posPlayer = position player;
			_dirPlayer = getDir player;
			player moveInDriver _para;
			_para setPos _posPlayer;
			_para setVelocity _velPlayer;
			_para setDir _dirPlayer;
			waitUntil {!alive player OR ((position player) select 2) < 2 OR isNull _para};
			deleteVehicle _para;
		};
	};
}];
