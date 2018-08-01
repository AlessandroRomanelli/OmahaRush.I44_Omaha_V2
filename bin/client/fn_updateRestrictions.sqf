scriptName "fn_updateRestrictions";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateRestrictions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateRestrictions.sqf"
if (isServer && !hasInterface) exitWith {};

_currentStage = [] call client_fnc_getCurrentStageString;

_isPlayerAttacking = (player getVariable "gameSide" == "attackers");
_side = [["Defender", "mobile_respawn_attackers"], ["Attacker", "mobile_respawn_defenders"]] select (_isPlayerAttacking);

_area = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "area"));
_area set [3, true];
_pos = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "positionATL"));

playArea setPos _pos;
playArea setTriggerArea _area;

// Update enemy base marker name
_enemyMarkerName = _side select 1;
cl_enemySpawnMarker = _enemyMarkerName;

true
