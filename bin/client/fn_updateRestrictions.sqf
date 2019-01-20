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
private _newArea = (getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "area"));
_newArea set [3, true];
private _newPos = (getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _currentStage >> "Area" >> (_side select 0) >> "positionATL"));

private _startTime = diag_tickTime;
if (_transitionTime > 0) then {
  ["triggerTransition", "onEachFrame", {
    params ["_transitionTime", "_currentPos", "_currentArea", "_newArea", "_newPos", "_trigger", "_startTime"];
    private _percentage = (diag_tickTime - _startTime)/_transitionTime;
    if (_percentage <= 1) then {
      private _tickPos = [(_currentPos select 0) + (((_newPos select 0) - (_currentpos select 0))*_percentage), (_currentPos select 1) + (((_newPos select 1) - (_currentpos select 1))*_percentage), 0];
      private _tickArea = [(_currentArea select 0) + (((_newArea select 0) - (_currentArea select 0))*_percentage), (_currentArea select 1) + (((_newArea select 1) - (_currentArea select 1))*_percentage), (_currentArea select 2) + (((_newArea select 2) - (_currentArea select 2))*_percentage), true, -1];
      // We set our trigger accordingly
      /* systemChat ("Progress: "+(str _percentage)+", Time left: "+(str (_transitionTime - _time))); */
      _trigger setPos _tickPos;
      _trigger setTriggerArea _tickArea;
    } else {
      ["triggerTransition", "onEachFrame"] call bis_fnc_removeStackedEventHandler;
      _trigger setPos _newPos;
      _trigger setTriggerArea _newArea;
    };
  }, [_transitionTime, _currentPos, _currentArea, _newArea, _newPos, _trigger, _startTime]] call bis_fnc_addStackedEventHandler;
} else {
  _trigger setPos _newPos;
  _trigger setTriggerArea _newArea;
};


// Update enemy base marker name
private _enemyMarkerName = _side select 1;
cl_enemySpawnMarker = _enemyMarkerName;

true
