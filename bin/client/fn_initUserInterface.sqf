scriptName "fn_initUserInterface";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_initUserInterface.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initUserInterface.sqf"

#include "..\utils.h"

#define COLOR_RED [[[1, 0.66, 0.66, 1], [0.4, 0.26, 0.26, 1]], ["#ffaaaa", "#664444"]]
#define COLOR_YELLOW [[[1, 0.8, 0.6, 1], [0.4, 0.32, 0.24]], ["#ffcc99", "#66513d"]]
#define COLOR_GREEN [[[0.66, 1, 0.66, 1], [0.26, 0.4, 0.26, 1]], ["#aaffaa", "#446644"]]

private _event = addMissionEventHandler["EachFrame", {
	if (visibleMap) exitWith {};
	private _isAttacking = IS_ATTACKING(player);
	private _gameSide = GAMESIDE(player);
	private _HQPos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> (sv_cur_obj getVariable ["cur_stage", "Stage1"]) >> "Spawns" >> _gameSide >> "HQSpawn" >> "positionATL");
	private _vehiclePlayer = vehicle player;
	private _posPlayer = getPosATL player;
	private _curSpawn = _HQPos;

	private _d = uiNamespace getVariable ["rr_objective_gui", displayNull];
	(_d displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='left'>%1</t>", sv_tickets];
	(_d displayCtrl 2) progressSetPosition (sv_tickets / sv_tickets_total);
	(_d displayCtrl 4) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='right'>%1</t>", [sv_matchTime, "MM:SS"] call bis_fnc_secondsToString];

	// Display the currently selected spawn if in spawn menu
	if (cl_inSpawnMenu) then {
		[] call client_fnc_refreshSpawnMenu;
	};

	if (player getVariable ["bayo_equipped", false]) then {
		[] call LIB_bayonetPerFrame;
	};

	if (player getVariable ["gl_equipped", false]) then {
		private _unit = (call ww2_fnc_findPlayer);
		private _magazines = primaryWeaponMagazine _unit;
		private _weaponState = weaponState _unit;
		if (!alive _unit) exitwith {};
		if (count _magazines > 1 && (_weaponState select 1 == primaryWeapon _unit)) then {
			_unit removePrimaryWeaponItem (_magazines select 1);
			_unit addMagazine (_magazines select 1);
			private _boltAction = [(configFile >> "cfgWeapons" >>  (primaryWeapon _unit)),"LIB_boltActionAnim",""] call BIS_fnc_returnConfigEntry;
			if !(_boltAction isEqualTo "") then {
				[_unit,primaryWeapon _unit,primaryWeapon _unit] call LIB_fnc_handleBoltAction;
			};
		};
	};

	// Objectives
	private _pos = sv_cur_obj getVariable ["positionAGL", []];
	if (count _pos == 0) then {
		_pos = sv_cur_obj modelToWorldVisual [0,0,0.5];
		sv_cur_obj setVariable ["positionAGL", _pos];
	};

	private _alpha = [] call {
		private _viewDir = getCameraViewDirection player;
		private _los = vectorNormalized ((getPosASL sv_cur_obj) vectorDiff (eyePos player));
		1 - ((_viewDir vectorDotProduct _los) max 0)^256;
	};

	private _objStatus = sv_cur_obj getVariable ["status", -1];
	if (_objStatus isEqualTo 1) then {
		_alpha = 2/3 + (1/3*cos(100*diag_tickTime*pi));
	};

	private _origin = if (cl_inSpawnMenu) then {_curSpawn} else {_posPlayer};
	private _icon = WWRUSH_ROOT+("pictures\objective_"+((
		[
			["defender.paa", "defender_armed.paa"],
			["attacker.paa", "attacker_armed.paa"]
		] select (_isAttacking)) select (_objStatus == 1))
	);
	private _text = format["%1 (%2m)",
		([
			["Defend", "Defuse"],
			["Attack", "Protect"]
		] select (_isAttacking)) select (_objStatus == 1), round(_origin distance sv_cur_obj)];
	drawIcon3D [_icon, [1,1,1,_alpha],_pos,1.5,1.5,0,_text,2,0.04, "PuristaLight", "center", false];

	private _ammoBoxes = (_posPlayer) nearObjects ["LIB_AmmoCrates_NoInteractive_Large", 7];
	{
		private _pos = (getPosASL _x) vectorAdd [0,0,0.5];
		private _distance = player distance _x;
		private _alpha = if (_distance < 5) then {1} else {1-(1/2*_distance)+2.5};
		drawIcon3D [WWRUSH_ROOT+"pictures\support.paa", [1,1,1,_alpha], ASLToAGL _pos, 1.5, 1.5, 0, format["Rearm (%1m)", round _distance], 2, 0.04, "PuristaLight", "center", true];
	} forEach _ammoBoxes;

	// Squad icons
	{
		_x params [["_unit", objNull], ["_name", ""], ["_icon", ""], ["_alpha", 1]];
		private _pos = (getPosATLVisual _unit) vectorAdd [0,0,1.85];
		drawIcon3D[_icon, [1,1,1, _alpha], _pos, 1.5, 1.5, 0, _name, 2, 0.04, "PuristaMedium", "center", true];
	} forEach cl_onEachFrame_squad_members;

	// Squad spawn beacons
	{
		_x params ["_ASLpos", "_name"];
		drawIcon3D["", [1,1,1,1], _ASLpos, 1.5, 1.5, 0, _name, 2, 0.04, "PuristaMedium", "center", true];
	} forEach cl_onEachFrame_squad_beacons;

	// Team icons
	{
		_x params ["_unit", "_name", "_icon"];
		private _pos = (getPosATLVisual _unit) vectorAdd [0,0,1.85];
		([[0.25, ""], [0.75, _name]] select (_unit == (driver vehicle cursorObject))) params ["_alpha", "_name"];
		drawIcon3D[_icon, [1,1,1,_alpha], _pos, 0.5, 0.5, 0,_name, 2, 0.03, "PuristaMedium", "center", false];
	} forEach cl_onEachFrame_team_members;

	// 3D Spotted enemies
	{
		private _unit = _x select 0;
		private _time = _x select 1;
		private _pos = _unit modelToWorldVisual [0,0,2.5];
		if (serverTime - _time > 10) then {
			_unit setVariable ["isSpotted", nil];
			_unit setVariable ["3dspotted", false];
		} else {
			if ((_unit getVariable ["isSpotted", -1]) > 0) then {
				private _alpha = ((10 + _time - serverTime)/10)*0.66;
				if (_alpha < 0 || ([player, "VIEW", _unit] checkVisibility [eyePos player, eyePos _unit] < 0.2)) then {
					_alpha = 0;
				};
				private _icon = [] call client_fnc_getUnitIcon;
				drawIcon3D [_icon, [0.968,0.423,0.353,_alpha], _pos, 0.8, 0.8, 0, "", 2, 0.03, "PuristaMedium", "center", false];
			};
		};
	} forEach cl_onEachFrame_spotted_enemies;

	// Revive icons
	if (cl_class == "medic") then {
		{
			private _pos = (getPosATLVisual _x) vectorAdd [0,0,0.1];
			private _alpha = (player distance _x) / 50;
			drawIcon3D [WWRUSH_ROOT+"pictures\revive.paa", [1,1,1,1 - _alpha], _pos, 1.35, 1.35, 0, "", 2, 0.035, "PuristaMedium", "center", false];
		} forEach cl_onEachFrame_team_reviveable;
	};

	// MERGE OF INGAME GUI
	private _hud = uiNamespace getVariable ["playerHUD",displayNull];
	private _HUD_currentAmmo = _hud displayCtrl 100;
	private _HUD_reserveAmmo = _hud displayCtrl 101;
	private _HUD_firemode = _hud displayCtrl 102;
	private _HUD_healthPoints = _hud displayCtrl 104;
	private _HUD_zeroing = _hud displayCtrl 105;
	private _HUD_grenades = _hud displayCtrl 107;
	private _HUD_typeGrenade = _hud displayCtrl 108;
	private _HUD_weaponName = _hud displayCtrl 1100;

	private _groupUnits = units (group player);

	private _getHUDColor = {
		private _unit = param [0, objNull, [objNull]];
		private _textFormat = param [1, false, [false]];
		if (damage _unit > 0.1) exitWith {
			COLOR_YELLOW select _textFormat
		};
		if (alive _unit && {_unit inArea playArea}) exitWith {
			COLOR_GREEN select _textFormat
		};
		COLOR_RED select _textFormat
	};

	private _getTeamIcon = {
		private _unit = param [0, objNull, [objNull]];
		private _perkIdx = _unit getVariable ["squadPerk", -1];
		if (_perkIdx isEqualTo -1) exitWith {WWRUSH_ROOT+"pictures\noperk.paa"};
		private _availableSquadPerks = (missionConfigFile >> "CfgPerks" >> "SquadPerks") call bis_fnc_getCfgSubClasses;
		private _squadPerk = _availableSquadPerks select _perkIdx;
		private _icon = WWRUSH_ROOT+"pictures\"+_squadPerk+".paa";
		_icon
	};

	for "_i" from 0 to 4 do {
		private _teamMateName = _hud displayCtrl (2100 + _i);
		private _teamMateIcon = _hud displayCtrl (2200 + _i);
		private _teamMateLeader = _hud displayCtrl (2300 + _i);
		if (_i < count _groupUnits) then {
			private _unit = _groupUnits select _i;
			private _colors = [_unit, true] call _getHUDColor;
			private _name = _unit getVariable ["name", name _unit];
			_teamMateName ctrlSetStructuredText parseText (format ["<t size='1.15' shadow='1' shadowColor='%1' color='%2' font='PuristaLight' align='right'>%3</t>", _colors select 1, _colors select 0, _name]);
			([_unit, false] call _getHUDColor) params ["_color"];
			_teamMateIcon ctrlSetText ([_unit] call _getTeamIcon);
			_teamMateIcon ctrlSetTextColor _color;
			_teamMateLeader ctrlSetTextColor ([[0,0,0,0], _color] select (_unit isEqualTo (leader (group player))));
		} else {
			_teamMateName ctrlSetStructuredText parseText "";
			_teamMateIcon ctrlSetText WWRUSH_ROOT+"pictures\noperk.paa";
			_teamMateIcon ctrlSetTextColor [0,0,0,0.25];
			_teamMateLeader ctrlSetTextColor [0,0,0,0];
		};
	};

	private _currentAmmo = 0;
	private _reserveAmmo = 0;
	private _grenades    = 0;
	private _fireMode = "";


	private _mode = currentWeaponMode (gunner _vehiclePlayer);
	if (_mode isEqualType "STRING") then {
		_fireMode = [] call {
			if (currentWeapon player != ((weaponState player) select 1)) exitWith { "GL" };
			if (_mode == "Single") exitWith { "SNGL"};
			if (_mode in ["Burst","Burst2rnd"]) exitWith { "BRST"};
			if (_mode == "FullAuto" || _mode == "manual") exitWith { "AUTO"};
			if (_mode == "LIB_Bayonet_Muzzle") exitWith { "BAYO" };
		};
	} else {_fireMode = "---"};

	if ((isNull objectParent player) || {(assignedVehicleRole player select 0) isEqualTo "cargo"}) then {
		{
			_x params ["_className", "_ammoCount", "_loaded", "_magType", "_magLocation"];
			private _curWep = currentWeapon player;
			private _mags = getArray(configFile >> "CfgWeapons" >> _curWep >> "magazines") apply {toLower _x};
			if ((toLower _className) in _mags) then {
				if (_loaded) then {
					_currentAmmo = _ammoCount;
				} else {
					_reserveAmmo = _reserveAmmo + _ammoCount;
				};
			};
			if (_className isEqualTo ((currentThrowable player) select 0)) then {
				_grenades = _grenades + 1;
			};
		} forEach (magazinesAmmoFull player);
	} else {
		if (driver _vehiclePlayer == player && {!(_vehiclePlayer isKindOf "Air")}) then {
			_currentAmmo = format ["%1", abs (floor (speed _vehiclePlayer))];
			_reserveAmmo = format ["%1°", floor getDir _vehiclePlayer];
			_fireMode = "KM/H";
		} else {
			_currentAmmo = _vehiclePlayer ammo (currentWeapon _vehiclePlayer);
			_reserveAmmo = [] call {
				private _ammoLeft = 0 - (_vehiclePlayer ammo (currentWeapon _vehiclePlayer));
				{
					if ((_x select 0) isEqualTo (currentMagazine _vehiclePlayer)) then {
						_ammoLeft = _ammoLeft + (_x select 1)
					}
				} forEach magazinesAmmo _vehiclePlayer;
				_ammoLeft
			};
		};
	};

	private _grenadeIcon = "";
	private _fragGrenades = ["lib_us_mk_2", "lib_shg24", "lib_rg42", "lib_millsbomb"];
	if (count (currentThrowable player) > 0) then {
		private _currentGrenade = (currentThrowable player) select 0;
		if ((toLower _currentGrenade) in _fragGrenades) then {
			_grenadeIcon = WWRUSH_ROOT+"pictures\grenade.paa";
		} else {
			_grenadeIcon = WWRUSH_ROOT+"pictures\smoke.paa";
		};
	};

	if (_grenades isEqualTo 0) then {_grenades = ""};

	private _weaponName = getText(configFile >> "cfgWeapons" >> currentWeapon _vehiclePlayer >> "displayName");

	_HUD_currentAmmo  ctrlSetText format ["%1",_currentAmmo];
	_HUD_reserveAmmo  ctrlSetText format ["%1",_reserveAmmo];
	_HUD_firemode     ctrlSetStructuredText parseText format ["<t align='left' size='1'>[</t><t align='center' size='1'>%1</t><t align='right' size='1'>]</t>",_fireMode];
	_HUD_healthPoints ctrlSetText format ["%1",floor((1-(damage player))*100)];
	_HUD_zeroing  		ctrlSetText format ["%1m", currentZeroing player];
	_HUD_typeGrenade	ctrlSetText _grenadeIcon;
	_HUD_grenades			ctrlSetText format ["%1", _grenades];
	_HUD_weaponName		ctrlSetText _weaponName;

	private _minimap = _hud displayCtrl 1800;
	private _zoom = 0.075;
	private _coeff = log(vectorMagnitude (velocity _vehiclePlayer)*3.6 + 10);
	if (_vehiclePlayer isEqualTo player) then {
		_zoom = 0.075;
	} else {
		if (_vehiclePlayer isKindOf "Car") then {
			_zoom = 0.1;
		};
		if (_vehiclePlayer isKindOf "Tank") then {
			_zoom = 0.08;
		};
		if (_vehiclePlayer isKindOf "Air") then {
			_zoom = 0.3;
		};
	};
	_zoom = _zoom * _coeff;
	_minimap ctrlMapAnimAdd [0, _zoom, _posPlayer];
	ctrlMapAnimCommit _minimap;

	private _dirCtrl = _hud displayCtrl 1801;
	private _cameraDir = _posPlayer getDir (_posPlayer vectorAdd (getCameraViewDirection player));
	_dirCtrl ctrlSetText format ["%1°", round _cameraDir];

	if (player getVariable ["isAlive", false] && !(_vehiclePlayer isKindOf "Air")) then {
		private _safeSpawnDistance = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "safeSpawnDistance");
		private _inPlayArea = _vehiclePlayer inArea playArea || {player getVariable ["isFallingBack", false] && player distance (getMarkerPos "mobile_respawn_defenders") < 300};
		if (isNil "cl_restrictedArea_thread" && {!_inPlayArea || {player distance (getMarkerPos cl_enemySpawnMarker) < _safeSpawnDistance}}) then {
			cl_restrictedArea_thread = [] spawn client_fnc_restrictedArea;
		};
	};
}];

_event
