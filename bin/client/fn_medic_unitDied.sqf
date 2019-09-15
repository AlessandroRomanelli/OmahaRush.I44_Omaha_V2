scriptName "fn_medic_unitDied";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_medic_unitDied.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_medic_unitDied.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

private _unit = param[0,objNull,[objNull]];
private _killer = param[1,objNull,[objNull]];
private _assistsInfo = param[2,[],[[]]];
private _grenade = param[3,"",[""]];
private _wasMelee = param[4, false, [false]];


// Make sure this doesnt get run before the init
if (isNil "cl_equipClassnames") exitWith {};

// Add this death to our killfeed
[_unit, _killer, _grenade, _wasMelee] spawn client_fnc_displayKillfeed;

// Evaluate assist info
if (!isNull _killer) then {
	[_assistsInfo, _killer] spawn client_fnc_evaluateAssistInfo;
};

// Is this unit on our side?
if ((_unit getVariable ["side", sideUnknown]) != (player getVariable ["side", sideUnknown])) exitWith {};

// Are we a medic and do we have the defi perk?
if (((cl_equipClassnames select 2) != "medic") || {isNull _killer}) exitWith {};

private _time = if (cl_classPerk == "defibrillator") then {0.5} else {1.5};

// Revive icon! Yay!
private _actionID = [
	_unit,
	"Revive",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
	"(_target distance _this) < 3.5 && {!alive _target} && {!isNull _target} && {_target inArea playArea}",
	"(_target distance _caller) < 3.5 && {(speed _caller) <= 0.1} && {_target inArea playArea}",
	{},
	{},
	{
		params ["_target"];
		[_target] spawn client_fnc_medic_reviveUnit
	},
	{},
	[],
	_time,
	50,
	true,
	false
] call bis_fnc_holdActionAdd;

TERMINATE_SCRIPT(cl_delete_revive);

cl_delete_revive = [_unit, _actionID] spawn {
	params ["_unit", "_actionID"];
	sleep 15;
	[_unit, _actionID] call BIS_fnc_holdActionRemove;
	cl_delete_revive = nil;
};

// Set action id locally on object if we need to remove it later on
_unit setVariable ["revive_actionID",_actionID];

// Make sure the action gets deleted once the person respawns
_unit addEventHandler ["Respawn",{
	TERMINATE_SCRIPT(cl_delete_revive);

	(_this select 0) removeAllEventHandlers "Respawn";
	{
		[_x, _x getVariable ["revive_actionID", -1]] call BIS_fnc_holdActionRemove;
	} forEach [_this select 0, _this select 1];
}];
