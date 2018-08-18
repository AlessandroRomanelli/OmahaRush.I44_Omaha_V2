scriptName "fn_updateRestrictions";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateRestrictions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateRestrictions.sqf"
if (isServer && !hasInterface) exitWith {};

private _trigger = param[0, objNull, [objNull]];

if (isNull _trigger) exitWith {};

private _currentStage = [] call client_fnc_getCurrentStageString;

private _isPlayerAttacking = (player getVariable "gameSide" == "attackers");
private _side = [["Defender", "mobile_respawn_attackers"], ["Attacker", "mobile_respawn_defenders"]] select (_isPlayerAttacking);

private _area = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "area"));
_area set [3, true];
private _pos = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "positionATL"));

_trigger setPos _pos;
_trigger setTriggerArea _area;

// Update enemy base marker name
private _enemyMarkerName = _side select 1;
cl_enemySpawnMarker = _enemyMarkerName;

true
