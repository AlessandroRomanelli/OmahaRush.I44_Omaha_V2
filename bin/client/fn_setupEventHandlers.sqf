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

		if (_killer getVariable ["side",sideUnknown] != (_victim getVariable ["side",sideUnknown]) && (diag_tickTime - cl_spawn_tick) < 15) then {

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
		_victim setVariable ["isAlive", false];
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
	_unit = _this select 0;
	_hitSelection = _this select 1;
	_damage = _this select 2;
	_shooter = _this select 3;

	//If critical damage to the head kill the victim and reward the shooter with HS bonus
	if (side _shooter != side _unit) then {
		if ((_hitSelection in ["head", "face_hub"]) && (_damage >= 1) && (alive _unit)) then {
			if (!(_unit getVariable ["wasHS", false])) then {
				[_unit, true] remoteExec ["client_fnc_kill",_shooter];
				_unit setDamage 1;
				_unit setVariable ["wasHS", true];
				_unit setVariable ["isAlive", false];
			};
		} else {
    _damage = if (_hitSelection isEqualTo "") then {
	      _hit = [_unit, _damage, _shooter] call {
					params ["_unit", "_damage", "_shooter"];
					_mgs = 			  ["LIB_MG34", "LIB_MG42", "LIB_M1918A2_BAR", "LIB_M1919A6"];
					_bolts = 		  ["LIB_G3340", "LIB_K98_Late", "LIB_M1903A3_Springfield", "LIB_G43"];
					_smgs = 			["LIB_M1A1_Thompson", "LIB_M1928A1_Thompson", "LIB_M1928_Thompson", "LIB_MP38", "LIB_MP40", "LIB_MP44"];
					_semiAutos =  ["LIB_G43", "LIB_M1_Carbine", "LIB_M1A1_Carbine", "LIB_M1_Garand"];
					_pistols =	  ["fow_w_type14", "fow_w_m1911"];
					if (currentWeapon _shooter in _mgs) exitWith {damage _unit + (_damage/2)};
					if (currentWeapon _shooter in _bolts) exitWith {damage _unit + _damage/0.33};
					if (currentWeapon _shooter in _smgs) exitWith {damage _unit + _damage/3};
					if (currentWeapon _shooter in _semiAutos) exitWith {damage _unit + _damage/2};
					if (currentWeapon _shooter in _pistols) exitWith {damage _unit + _damage/1.5};
					_damage
				};
	      if (alive _unit && _hit > 0.1) then {
	        _hit remoteExec ["client_fnc_MPHit", _shooter];
	      };
	      _hit
	    } else {
	      _unit getHit _hitSelection
	    };
		};
	};

	if (((side (gunner vehicle _shooter) == side _unit) || (side (driver vehicle _shooter)) == side _unit) && (_shooter != _unit)) then {
	 _damage = damage _unit;
	};

 _damage
}];

// Getin Eventhandler for vehicles
player addEventHandler ["GetInMan", {
	_vehicle = _this select 2;
	_vehicle allowDamage true;

	_vehicle setVariable ["last_man", nil];

	_vehicle removeAllEventHandlers "Killed";
	_vehicle addEventHandler ["Killed", {
		_v = _this select 0;
		_killer = _this select 1;
		_instigator = _this select 2;

		_sendVehicleKill = {
			params ["_v", "_killer"];
			_halfTrucks = ["LIB_US_M3_Halftrack", "LIB_SdKfz251", "LIB_SdKfz251_FFV"];
			{[_x select 0, false] remoteExec ["client_fnc_kill", _killer];} forEach fullCrew _v;
			if (_v isKindOf "Tank" && !(typeOf _v in _halfTrucks)) exitWith {
				500 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			if (typeOf _v in _halfTrucks) exitWith {
				300 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
			if (_v isKindOf "Car") exitWith {
				150 remoteExec ["client_fnc_vehicleDisabled", _killer];
			};
		};

		if (!isNull _instigator) then {
			_killer = _instigator;
		};

		if ({alive (_x select 0)} count fullCrew _v > 0) exitWith {
			_crewPl = fullCrew _v select 0 select 0;
			if ((player isEqualto _crewPl) && (_crewPl getVariable "gameside" != _killer getVariable "gameside")) then {
				[_v, _killer] spawn _sendVehicleKill;
			};
		};
		if (player isEqualto (_v getVariable ["last_man", objNull])) exitWith {
			if (player getVariable "gameside" != _killer getVariable "gameside") then {
				[_v, _killer] spawn _sendVehicleKill;
			}:
		};
 }];

	// Always make sure we have an hit eventhandler
	_vehicle removeAllEventHandlers "HandleDamage";
	_vehicle addEventHandler ["HandleDamage", {
		_v = vehicle _this select 0;
		_hitSelection = _this select 1;
		_damage = _this select 2;
		_s = _this select 3;
		_shot = _this select 4;

		_damage = [_v, _shot] call {
			params ["_v", "_shot", "_damage"];
    	_rockets = ["LIB_60mm_M6", "LIB_R_88mm_RPzB"];
			if (_v isKindOf "Tank") then {
				if (_shot in _rockets) exitWith {_damage = damage _v + (_damage*3);};
			};
			if (_v isKindOf "Car" || ((typeOf _v) in ["LIB_US_M3_Halftrack", "LIB_SdKfz251", "LIB_SdKfz251_FFV"])) then {
				if (_shot in _rockets) then {
					_damage = 1;
				};
			};
		};
		_damage
	}];

	_vehicle removeAllEventHandlers "Hit";
	_vehicle addEventHandler ["Hit", {
		_v = _this select 0;
		_killer = _this select 1;
		_s = _this select 3;
		if (!isNull _s) then {
			_killer = _s;
		};
    0.1 remoteExec ["client_fnc_MPHit", _killer];
		if (_v getVariable ["disabled", false]) exitWith {};
		if ({alive (_x select 0)} count (fullCrew _v) > 0) then {
			_crewPl = fullCrew _v select 0 select 0;
			if ((player isEqualTo _crewPl) && ((_crewPl getVariable ["side", sideUnknown]) != (_killer getVariable ["side", sideUnknown]))) then {
				if (!(canMove _v)) then {
					_v setVariable ["disabled", true];
					if (_v isKindOf "Tank") exitWith {
						200 remoteExec ["client_fnc_vehicleDisabled", _killer];
					};
					if (_v isKindOf "Car") exitWith {
						100 remoteExec ["client_fnc_vehicleDisabled", _killer];
					};
				};
			};
		};
	}];
}];

player addEventHandler ["GetOutMan", {
	_v = _this select 2;
	if ({alive (_x select 0)} count (fullCrew _v) == 0) then {
		_v setVariable ["last_man", player];
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
