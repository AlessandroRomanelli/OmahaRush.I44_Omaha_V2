scriptName "fn_updateRestrictions";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateRestrictions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateRestrictions.sqf"
if (isServer && !hasInterface) exitWith {};

private _trigger = param[0, objNull, [objNull]];
private _transitionTime = param[1, 0, [0]];

if (isNull _trigger) exitWith {};

private _currentStage = [] call client_fnc_getCurrentStageString;

private _isPlayerAttacking = (player getVariable "gameSide" == "attackers");
private _side = [["Defender", "mobile_respawn_attackers"], ["Attacker", "mobile_respawn_defenders"]] select (_isPlayerAttacking);

private _currentPos = getPosATL _trigger;
private _currentArea = triggerArea _trigger;

private _newArea = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "area"));
_newArea set [3, true];
private _newPos = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "positionATL"));

private _time = 0;
while {_time < _transitionTime} do {
  _time = _time + 0.03;
  private _percentage = _time/_transitionTime;
  private _tickPos = [((_newPos select 0) - (_currentpos select 0))*_time, ((_newPos select 1) - (_currentpos select 1))*_time, 0];
  private _tickArea = [((_newArea select 0) - (_currentArea select 0))*_time, ((_newArea select 1) - (_currentArea select 1))*_time, ((_newArea select 2) - (_currentArea select 2))*_time, true, -1];
  _trigger setPos _tickPos;
  _trigger setTriggerArea _tickArea;
};

_trigger setPos _newPos;
_trigger setTriggerArea _newArea;

// Update enemy base marker name
private _enemyMarkerName = _side select 1;
cl_enemySpawnMarker = _enemyMarkerName;

true
