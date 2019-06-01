scriptName "fn_spotTarget";
/*--------------------------------------------------------------------
	Author: A. Roman

    File: fn_spotTarget.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spotTarget.sqf"

if (isServer && !hasInterface) exitWith {};

/* systemChat "Spotting targets.."; */
private _allEnemies = allUnits select {(alive _x) && (_x getVariable "gameSide" != player getVariable "gameSide") && ((_x distance2D player) < 200)};
private _fnc_getRelDirPOV = {
  private _origin = param [0, objNull, [objNull]];
  private _target = param [1, objNull, [objNull]];
  if (isNull _origin || isNull _target) exitWith {};
  private _pos = getPosWorld _origin;
  private _cameraDir = _pos getDir (_pos vectorAdd (getCameraViewDirection _origin));
  private _weaponDir = getDir _origin;
  private _offset = abs(_weaponDir - _cameraDir);
  private _relDir = _origin getRelDir _target;
  abs (_offset - _relDir)
};
{
  private _relDirPov = [player, _x] call _fnc_getRelDirPOV;
  if (((_relDirPov > 357.5 || _relDirPov < 2.5) && ((_x distance player) < 100)) || (cursorTarget isEqualTo _x)) then {
    if ([player, "VIEW", _x] checkVisibility [eyePos player, eyePos _x] > 0.1) then {
      _x setVariable ["isSpotted", serverTime, true];
      _x setVariable ["3dSpotted", true];
    };
  };
} forEach _allEnemies;

true
