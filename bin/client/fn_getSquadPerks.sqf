scriptName "fn_getSquadPerks";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getSquadPerks.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getSquadPerks.sqf"
if (isServer && !hasInterface) exitWith {};

private _availableSquadPerks = (missionConfigFile >> "CfgPerks" >> "SquadPerks") call bis_fnc_getCfgSubClasses;
private _activePerks = [];

{
  private _idxPerk = _x getVariable ["squadPerk", -1];
  if (_idxPerk != -1) then {
    _activePerks pushBackUnique (_availableSquadPerks select _idxPerk);
  };
} forEach (units group player);

cl_squadPerks = _activePerks;
_activePerks
