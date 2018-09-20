scriptName "fn_spotTarget";
/*--------------------------------------------------------------------
	Author: A. Roman

    File: fn_spotTarget.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spotTarget.sqf"

if (isServer && !hasInterface) exitWith {};

systemChat "Spotting targets..";
private _allEnemies = allUnits select {(_x getVariable "gameSide" != player getVariable "gameSide") && ((_x distance2D player) < 150)};
{
  private _relDir = player getRelDir _x;
  if (((_relDir > 355 || _relDir < 5) || (cursorTarget isEqualTo _x)) && !(_x getVariable ["isSpotted", false])) then {
    if ([player, "VIEW", _x] checkVisibility [eyePos player, eyePos _x] > 0.1) then {
      _x setVariable ["isSpotted", serverTime, true];
      systemChat format ["%1 is visible and spotted!", name _x];
    } else {
      systemChat format ["%1 was in range, but not visible.", name _x];
    };
  };
} forEach _allEnemies;
