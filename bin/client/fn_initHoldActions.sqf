scriptName "fn_initHoldActions";
/*--------------------------------------------------------------------
	Authors: Maverick (ofpectag: MAV) & A. Roman (ofpectag: RMN)
    File: fn_initHoldActions.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de) & A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initHoldActions.sqf"
if (isServer && !hasInterface) exitWith {};

{[player, _x] call BIS_fnc_holdActionRemove} forEach cl_actionIDs;


mg_conditionShowOnMyself = {
	private _currentAmmo = 0;
	private _reserveAmmo = 0;

	{
		if ((_x select 0) == (currentMagazine player) && (_x select 2)) then
		{
			_currentAmmo = (_x select 1);
		};
		if ((_x select 0) == (currentMagazine player) && !(_x select 2)) then
		{
			_reserveAmmo = _reserveAmmo + (_x select 1);
		};
	} forEach (magazinesAmmoFull player);

	private _condition = if (cl_class in ["medic", "assault", "recon"]) then {((_currentAmmo + _reserveAmmo) <= 10)} else {((_currentAmmo + _reserveAmmo) <= 50)};
	_condition && !(player getVariable ["ammo_restored",false])
};

private _mg_code = {
	if (!isNull cl_lastActionTarget) then {
		[player] remoteExecCall ["client_fnc_restoreAmmo", cl_lastActionTarget];
	};

	// Pointsssss
	if (cl_lastActionTarget != player) then {
		["<t size='1.3' color='#FFFFFF'>AMMUNITION REPLENISHED</t>", 30] call client_fnc_pointfeed_add;
		[30] call client_fnc_addPoints;
	};

	// Make sure we cant spam it
	cl_lastActionTarget setVariable ["ammo_restored",true];

	[cl_lastActionTarget] spawn {
		private _lastActionTarget = param[0, objNull, [objNull]];
		if (_lastActionTarget isEqualTo player) then {
			uiSleep 60;
		} else {
			uiSleep 13;
		};

		// allow us to restore ammo again
		_lastActionTarget setVariable ["ammo_restored",false];
	};
};

diag_log "Setting up handlers... 1";

// Ammunition for myself
private _id = [
/* 0 object */							player,
/* 1 action title */					"Replenish Own Ammunition",
/* 2 idle icon */						WWRUSH_ROOT+"pictures\support.paa",
/* 3 progress icon */					WWRUSH_ROOT+"pictures\support.paa",
/* 4 condition to show */				"cl_classPerk == 'ammo' && [] call mg_conditionShowOnMyself ",
/* 5 condition for action */			"true",
/* 6 code executed on start */			{cl_lastActionTarget = player;},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		_mg_code,
/* 9 code executed on interruption */	{},
/* 10 arguments */						[],
/* 11 action duration */				1,
/* 12 priority */						500,
/* 13 remove on completion */			false,
/* 14 show unconscious */				false
] call BIS_fnc_holdActionAdd;
cl_actionIDs pushBack _id;


diag_log "Setting up handlers... 2";

// Ammunition for others
private _id = [
/* 0 object */							player,
/* 1 action title */					"Replenish Ammunition",
/* 2 idle icon */						WWRUSH_ROOT+"pictures\support.paa",
/* 3 progress icon */					WWRUSH_ROOT+"pictures\support.paa",
/* 4 condition to show */				"cl_classPerk == 'ammo' && {cursorTarget distance _this < 3} && {alive cursorTarget} && {!(cursorTarget getVariable ['ammo_restored',false])} && {(side cursorTarget) == (player getVariable ['side', sideUnknown])} && {cursorTarget isKindOf 'Man'}",
/* 5 condition for action */			"!(cursorTarget getVariable ['ammo_restored',false])",
/* 6 code executed on start */			{cl_lastActionTarget = cursorTarget;},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		_mg_code,
/* 9 code executed on interruption */	{},
/* 10 arguments */						[],
/* 11 action duration */				1,
/* 12 priority */						500,
/* 13 remove on completion */			false,
/* 14 show unconscious */				false
] call BIS_fnc_holdActionAdd;
cl_actionIDs pushBack _id;

// Planting and defusing objectives
private _icon = WWRUSH_ROOT+"pictures\";
private _cond = "";
private _text = "";
private _completion = {};
private _interruption = {};
private _duration = if (cl_classPerk == "saboteur") then {1} else {4};
if ((player getVariable "gameSide") == "defenders") then {
	_icon = _icon + "bombDefuse.paa";
	_text = "Disarm Explosives";
	_cond = "((player getVariable 'gameSide') == 'defenders') && {player inArea playArea} && {(player distance sv_cur_obj) < ceil(([sv_cur_obj] call client_fnc_getObjectiveDistance) + 1.5)} && {(sv_cur_obj getVariable ['status',-1] == 1) || {sv_cur_obj getVariable ['status', -1] == 0 && {sv_cur_obj getVariable ['arming', false]}}}";
	_completion = {
		if ((player distance sv_cur_obj) < ceil(([sv_cur_obj] call client_fnc_getObjectiveDistance) + 1.5)) then {
			[] call client_fnc_disarmMCOM;
		};
	};
	_interruption = {
		sv_cur_obj setVariable ["status", 1, true];
		sv_cur_obj setVariable ["arming", false];
	};
} else {
	_icon = _icon + "bombPlant.paa";
	_text = "Plant Explosives";
	_cond = "((player getVariable 'gameSide') == 'attackers') && {player inArea playArea} && {(player distance sv_cur_obj) < ceil(([sv_cur_obj] call client_fnc_getObjectiveDistance) + 1.5)} && {((sv_cur_obj getVariable ['status',-1]) in [-1, 2]) || {(sv_cur_obj getVariable ['status', -1] == 0) && {sv_cur_obj getVariable ['arming', false]}}}";
	_completion = {if ((sv_cur_obj distance player) < ceil(([sv_cur_obj] call client_fnc_getObjectiveDistance) + 1.5)) then {[] call client_fnc_armMCOM;};};
	_interruption = {
		sv_cur_obj setVariable ["status", -1, true];
		sv_cur_obj setVariable ["arming", false];
	};
};

// Add action to objectives
private _id = [
/* 0 object */							player,
/* 1 action title */					_text,
/* 2 idle icon */						_icon,
/* 3 progress icon */					_icon,
/* 4 condition to show */				_cond,
/* 5 condition for action */			"player distance sv_cur_obj < ceil(([sv_cur_obj] call client_fnc_getObjectiveDistance) + 2)",
/* 6 code executed on start */			{
	playSound3D[WWRUSH_ROOT + "sounds\arm.ogg", sv_cur_obj];
	sv_cur_obj setVariable ["status", 0, true];
	sv_cur_obj setVariable ["arming", true];
	cl_action_obj = sv_cur_obj;
},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		_completion,
/* 9 code executed on interruption */	_interruption,
/* 10 arguments */						[],
/* 11 action duration */				_duration,
/* 12 priority */						10000,
/* 13 remove on completion */			false,
/* 14 show unconscious */				false
] call bis_fnc_holdActionAdd;
cl_actionIDs pushBack _id;


// Vehicle ammunition
private _completed = {
	if (player distance cl_lastActionTarget > 5) exitWith {};

	["<t size='1.3' color='#FFFFFF'>AMMUNITION REPLENISHED</t>", 50] call client_fnc_pointfeed_add;
	[50] call client_fnc_addPoints;

	// Make sure we cant spam it
	cl_lastActionTarget setVariable ["ammo_restored",true];

	[cl_lastActionTarget] spawn {
		uiSleep 120;
		private _lastActionTarget = param[0, objNull, [objNull]];
		// allow us to restore ammo again
		_lastActionTarget setVariable ["ammo_restored",false];
	};
};

cl_vehicleAmmoTypes = [] call client_fnc_getAllAmmoVehicles;

private _completedEngineer = {
	if (player distance cl_lastActionTarget > 5) exitWith {};
	["<t size='1.3' color='#FFFFFF'>VEHICLE REPAIRED</t>", 50] call client_fnc_pointfeed_add;
	[50] call client_fnc_addPoints;
	cl_lastActionTarget setVariable ["vehDmg", 0];
	// Make sure we cant spam it
	cl_lastActionTarget setVariable ["repaired",true];
	cl_lastActionTarget setDamage 0;
	cl_lastActionTarget setFuel 1;

	[cl_lastActionTarget] spawn {
		uiSleep 120;
		private _lastActionTarget = param[0, objNull, [objNull]];
		// allow us to restore ammo again
		_lastActionTarget setVariable ["repaired",false];
	};
};

diag_log "Setting up handlers... 6";

private _id = [
/* 0 object */							player,
/* 1 action title */					"Replenish Vehicle Ammunition",
/* 2 idle icon */						WWRUSH_ROOT+"pictures\support.paa",
/* 3 progress icon */					WWRUSH_ROOT+"pictures\support.paa",
/* 4 condition to show */				"cl_classPerk == 'ammo' && (cursorTarget distance _this) < 3 && alive cursorTarget && !(cursorTarget getVariable ['ammo_restored',false]) && ((typeOf cursorTarget) in cl_vehicleAmmoTypes)",
/* 5 condition for action */			"!(cursorTarget getVariable ['ammo_restored',false])",
/* 6 code executed on start */			{cl_lastActionTarget = cursorTarget;},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		_completed,
/* 9 code executed on interruption */	{},
/* 10 arguments */						[],
/* 11 action duration */				8,
/* 12 priority */						500,
/* 13 remove on completion */			false,
/* 14 show unconscious */				false
] call BIS_fnc_holdActionAdd;
cl_actionIDs pushBack _id;

diag_log "Setting up handlers... 7";

// Engineer repair option
private _id = [
	player,
	"Repair Vehicle",
	WWRUSH_ROOT+"pictures\engineer.paa",
	WWRUSH_ROOT+"pictures\engineer.paa",
	"cl_class == 'engineer' && (cursorTarget distance player) < 5 && alive cursorTarget && !(cursorTarget getVariable ['repaired',false]) && (cursorTarget isKindOf 'Air' || cursorTarget isKindOf 'LandVehicle' || cursorTarget isKindOf 'Ship')",
	"!(cursorTarget getVariable ['repaired',false])",
	{cl_lastActionTarget = cursorTarget;},
	{},
	_completedEngineer,
	{},
	[],
	10,
	500,
	false,
	false
] call BIS_fnc_holdActionAdd;
cl_actionIDs pushBack _id;

diag_log "Setting up handlers... 8";

// Rearm at ammo crate
private _id = [
/* 0 object */							player,
/* 1 action title */					"Rearm at Ammobox",
/* 2 idle icon */						WWRUSH_ROOT+"pictures\support.paa",
/* 3 progress icon */					WWRUSH_ROOT+"pictures\support.paa",
/* 4 condition to show */				"(typeOf cursorTarget) isEqualTo 'LIB_AmmoCrates_NoInteractive_Large' && (cursorTarget distance player) < 5",
/* 5 condition for action */			"true",
/* 6 code executed on start */			{},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		client_fnc_restoreAmmo,
/* 9 code executed on interruption */	{},
/* 10 arguments */						[],
/* 11 action duration */				0.5,
/* 12 priority */						500,
/* 13 remove on completion */			false,
/* 14 show unconscious */				false
] call BIS_fnc_holdActionAdd;
cl_actionIDs pushBack _id;

diag_log "Setting up handlers... 9";

true
