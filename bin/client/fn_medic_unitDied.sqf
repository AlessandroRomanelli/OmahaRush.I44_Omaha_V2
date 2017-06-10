scriptName "fn_medic_unitDied";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_medic_unitDied.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_medic_unitDied.sqf"
if (isServer && !hasInterface) exitWith {};

_unit = param[0,objNull,[objNull]];
_killer = param[1,objNull,[objNull]];
_assistsInfo = param[2,[],[[]]];

// Make sure this doesnt get run before the init
if (isNil "cl_equipClassnames") exitWith {};

// Add this death to our killfeed
[_unit, _killer] spawn client_fnc_displayKillfeed;

// Evaluate assist info
[_assistsInfo, _killer] spawn client_fnc_evaluateAssistInfo;

// Is this unit on our side?
if ((_unit getVariable ["side",civilian]) != playerSide) exitWith {};

// Are we a medic and do we have the defi perk?
if (cl_equipClassnames select 2 != "medic") exitWith {};
if (cl_classPerk != "defibrillator") exitWith {};

// Revive icon! Yay!
_actionID = [
	_unit,
	"Revive",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
	"(_target distance _this) < 2 && !alive _target && !isNull _target",
	"(_target distance _caller) < 2 && ((speed _caller) <= 0.1)",
	{},
	{},
	{[_target] spawn client_fnc_medic_reviveUnit},
	{},
	[],
	0.5,
	50,
	true,
	false
] call bis_fnc_holdActionAdd;

// Set action id locally on object if we need to remove it later on
_unit setVariable ["revive_actionID",_actionID];

// Make sure the action gets deleted once the person respawns
_unit addEventHandler ["Respawn",{
	(_this select 0) removeAllEventHandlers "Respawn";
	{
		[_x, _x getVariable ["revive_actionID", -1]] call BIS_fnc_holdActionRemove;
	} forEach [_this select 0, _this select 1];
}];
