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
	//(_this select 2) remoteExec ["client_fnc_MPHit",_this select 1];

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
	if (true) then { // Condition missing
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

// Handledamage
player addEventHandler ["HandleDamage",{
	_damage = _this select 2;

	// Dont allow team damage
	if ((driver vehicle (_this select 3)) getVariable ["side",sideUnknown] == (player getVariable ["side",sideUnknown]) && ((_this select 3) != player)) then {
		_damage = damage player;
	};

	// Return damage
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
	_vehicle removeAllEventHandlers "Hit";
	_vehicle addEventHandler ["Hit", {
		//hint "0";
		if ((driver (_this select 0)) != player) exitWith {};
		//hint "1";
		if ({alive _x} count (crew (_this select 0)) > 0 && !((_this select 0) getVariable ["disabled", false])) then {
			//hint "2";
			if (((driver (_this select 0)) getVariable ["side", sideUnknown]) != ((_this select 1) getVariable ["side", sideUnknown])) then {
				if ((_this select 2) > 0) then {
					//hint "3";
					(_this select 0) setVariable ["disabled", true];
					if !(canMove (_this select 0) && ((_this select 2) > 0.3)) then {
						//hint "4";
						[] remoteExec ["client_fnc_vehicleDisabled", (_this select 1)];
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