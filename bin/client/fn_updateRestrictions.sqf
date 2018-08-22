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

// Something somewhere went wrong
if (isNull _trigger) exitWith {};

// Get the current stage
private _currentStage = [] call client_fnc_getCurrentStageString;

// Check if the player is attacking
private _isPlayerAttacking = (player getVariable "gameSide" == "attackers");
// A set of data depending on whether the player attacks or defends
private _side = [["Defender", "mobile_respawn_attackers"], ["Attacker", "mobile_respawn_defenders"]] select (_isPlayerAttacking);

// Current data of the trigger before alterations
private _currentPos = getPosATL _trigger;
private _currentArea = triggerArea _trigger;

// Future data of the trigger after alteration
private _newArea = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "area"));
_newArea set [3, true];
private _newPos = (getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "positionATL"));

// Set time to 0 and start counting
private _time = 0;
while {_time < _transitionTime} do {
  // If we add 0.03 each 0.03 seconds, do we get 1:1 time ratio? Hopefully!
  _time = _time + 0.03;
  // What is the progress of the transition?
  private _percentage = _time/_transitionTime;
  // We take the initial state and we add do it the difference between the new and the current data, times the progress in our transition
  private _tickPos = [(_currentPos select 0) + (((_newPos select 0) - (_currentpos select 0))*_percentage), (_currentPos select 1) + (((_newPos select 1) - (_currentpos select 1))*_percentage), 0];
  private _tickArea = [(_currentArea select 0) + (((_newArea select 0) - (_currentArea select 0))*_percentage), (_currentArea select 1) + (((_newArea select 1) - (_currentArea select 1))*_percentage), (_currentArea select 2) + (((_newArea select 2) - (_currentArea select 2))*_percentage), true, -1];
  // We set our trigger accordingly
  _trigger setPos _tickPos;
  _trigger setTriggerArea _tickArea;
  // Good ol' 33FPS
  sleep 0.03;
};

_trigger setPos _newPos;
_trigger setTriggerArea _newArea;

// Update enemy base marker name
private _enemyMarkerName = _side select 1;
cl_enemySpawnMarker = _enemyMarkerName;

true
