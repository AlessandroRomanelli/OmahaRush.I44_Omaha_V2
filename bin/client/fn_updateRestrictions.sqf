scriptName "fn_updateRestrictions";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateRestrictions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateRestrictions.sqf"
if (isServer && !hasInterface) exitWith {};

_currentStage = [] call client_fnc_getCurrentStageString;

_atkArea = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> "Attacker" >> "area"));
_atkArea set [3, true];
_defArea = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> "Defender" >> "area"));
_defArea set [3, true];
area_atk setPos (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> "Attacker" >> "positionATL"));
area_atk setTriggerArea _atkArea;
area_def setPos (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> "Defender" >> "positionATL"));
area_def setTriggerArea _defArea;

if (player getVariable ["gameSide", "defenders"] == "defenders") then {
	[area_def, "playArea"] spawn client_fnc_updateLine;
} else {
	[area_atk, "playArea"] spawn client_fnc_updateLine;
};


// Update enemy base marker name
cl_enemySpawnMarker = if (player getVariable "gameSide" == "defenders") then {"mobile_respawn_attackers"} else {"mobile_respawn_defenders"};
