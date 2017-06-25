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
	_lastDeath = (_this select 0) getVariable ["lastDeath", 0];
	//Avoiding more than one time each 1/10 of a second
	if (diag_tickTime - _lastDeath > 0.1) then {
		(_this select 0) setVariable ["unitDmg", 0];
		// Increase deaths
		cl_deaths = cl_deaths + 1;
		cl_total_deaths = cl_total_deaths + 1;

		// Killer
		_killer = _this select 1;
		_instigator = _this select 2;

		if (!isNull _instigator) then {
			_killer = _instigator;
		};

		[format ["You have been killed by killer %1", str _killer]] call server_fnc_log;
		[format ["You have been killed by instigator %1", str _instigator]] call server_fnc_log;

		// Send message to killer that he killed someone
		if ((_this select 0) != _killer && !isNull (_this select 0) && (!isNull _killer)) then {
			[_this select 0] remoteExec ["client_fnc_kill",_killer];
			//Log time of death
			(_this select 0) setVariable ["lastDeath", diag_tickTime];
			// you have been killed by message
			[format ["You have been killed by<br/>%1", (_killer getVariable ["name", ""])]] spawn client_fnc_displayInfo;

			// Send message to all units that we are reviveable
			// As this package gets send to all clients we might aswell use it to share our information regarding assists (damage that was inflicted on us)
			[_this select 0,_killer, cl_assistsInfo] remoteExec ["client_fnc_medic_unitDied", 0];
		};

		// Disable hud
		["rr_spawn_bottom_right_hud_renderer", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		300 cutRsc ["default","PLAIN"];

		rr_respawn_thread = [] spawn client_fnc_killed;

		if (_killer getVariable ["side",sideUnknown] != (player getVariable ["side",sideUnknown]) && (diag_tickTime - cl_spawn_tick) < 15) then {

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

player addEventHandler ["HitPart", {
	{
		// If the headshot is the hit selection
	 	if ("head" in (_x select 5)) then {
			// Set a variable on the victim, it was HS
			(_x select 0) setVariable ["wasHS", true, true];
			// Kill the target
	  	(_x select 0) setDamage 1;
			[_x select 0] remoteExec ["client_fnc_kill",_x select 1];
		};
	} forEach _this;
}];

// Handledamage
player addEventHandler ["HandleDamage", {
 _u = _this select 0;
 _damage = _this select 2;
 _s = _this select 3;
 //Get the shooter's rifle
 _rifle = ((getUnitLoadout _s) select 0) select 0;
 //SMG array
 _smgs = ["LIB_M1928_Thompson", "LIB_M1A1_Thompson", "LIB_MP40", "LIB_M1928A1_Thompson", "LIB_M1928A1_Thompson", "LIB_PPSh41_m", "LIB_MP44"];
 if (_rifle in _smgs) then {
	 //Get the time of last hit
  _lastHit = _u getVariable ["lastHit", 0];
	//If the time between last hit and new hit is more than 1/10 of a second
  if ((diag_tickTime - _lastHit) > 0.1) then {
		//Get damage between 0.2 and 0.35 (Worst case: 3 hits, best case: 2 hits, average: 3-4 hits)
   _dmg = (floor random [33,50,33])/100;
	 //Get the current damage of the victim, if the variable is undefined, sets it to 0
	 _unitHP = _u getVariable ["unitDmg", 0];
	 //Sets the damage of the unit to its current HP + the damage caused by the smg
   _u setDamage (_unitHP + _dmg);
	 //If the bullet is defined,
   if ((_this select 4) != "") then {
		 //Send a hit marker to the shooter
    _dmg remoteExec ["client_fnc_MPHit", _s];
   };
	 if (_unitHP + _dmg >= 1 && _u getVariable ["isAlive", true]) then {
		_u setVariable ["isAlive", false];
		[_u] remoteExec ["client_fnc_kill",_s];
	 };
	 //Store the new unit HP
	 _u setVariable ["unitDmg", _unitHP + _dmg];
	 //Store the time of last hit
	 _u setVariable ["lastHit", diag_tickTime];
  };
	//Set the default damage output of SMGs to 0
  _damage = 0;
 };

 //Handle friendlyfire
 if ((driver vehicle _s) getVariable ["side",sideUnknown] == (_u getVariable ["side",sideUnknown]) && (_s != player)) then {
  _damage = damage _u;
 };
 _damage
}];

// Getin Eventhandler for vehicles
player addEventHandler ["GetInMan", {
	_vehicle = _this select 2;

	// Add handler
	if (_vehicle isKindOf "Air") then {
		// Make sure helicopters and planes get warned about incoming missiles and that the active defense system for pilots is activated!
		_vehicle removeAllEventHandlers "IncomingMissile";
		[_vehicle] spawn client_fnc_addAirVehicleHandlers;
	};

	// Always make sure we have an hit eventhandler
	_vehicle removeAllEventHandlers "HandleDamage";
	_vehicle addEventHandler ["HandleDamage", {
		_v = _this select 0;
		_s = _this select 3;
		if (_v isKindOf "Tank") then {
			_damage = _this select 2;
			_damage = 0;
			_lastDmg = _v getVariable ["lastDmg", 0];
			if (diag_tickTime - _lastDmg > 0.1) then {
				_shot = _this select 4;
				_rockets = ["LIB_60mm_M6", "LIB_R_88mm_RPzB"];
				if (_shot in _rockets) then {
					_dmg = floor random [40, 60, 40]/100;
					_vehDmg = _v getVariable ["vehDmg", 0];
					_v setDamage (_vehDmg + _dmg);
					if (damage _v > 0.85) then {
						300 remoteExec ["client_fnc_vehicleDisabled", _s];
					};
					_v setVariable ["vehDmg", _vehDmg + _dmg];
				};
				_atGren = ["LIB_pwm", "LIB_rpg6"];
				if (_shot in _atGren) then {
					_dmg = floor random [20,35,20]/100;
					_vehDmg = _v getVariable ["vehDmg", 0];
					_v setDamage (_vehDmg + _dmg);
					_v setHitPointDamage ["HitLTrack", _vehDmg + 0.5];
					_v setHitPointDamage ["HitRTrack", _vehDmg + 0.5];
					if (damage _v > 0.85) then {
						300 remoteExec ["client_fnc_vehicleDisabled", _s];
					};
					_v setVariable ["vehDmg", _vehDmg + _dmg];
				};
				_v setVariable ["lastDmg", diag_tickTime];
			};
		};
	}];


	_vehicle removeAllEventHandlers "Hit";
	_vehicle addEventHandler ["Hit", {
		_v = _this select 0;
		_s = _this select 3;
		if ({alive _x} count (crew _v) > 0 && !(_v getVariable ["disabled", false])) then {
			if (((driver _v) getVariable ["side", sideUnknown]) != (_s getVariable ["side", sideUnknown])) then {
				if (!(canMove _v)) then {
					_v setVariable ["disabled", true];
					if (_v isKindOf "Tank") exitWith {
						200 remoteExec ["client_fnc_vehicleDisabled", _s];
					};
					if ((_this select 0) isKindOf "Car") exitWith {
						if ((damage _v) > 0.85) then {
							150 remoteExec ["client_fnc_vehicleDisabled", _s];
						};
						100 remoteExec ["client_fnc_vehicleDisabled", _s];
					};
				};
			};
		};
	}];
}];

player addEventHandler ["GetOutMan", {
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
