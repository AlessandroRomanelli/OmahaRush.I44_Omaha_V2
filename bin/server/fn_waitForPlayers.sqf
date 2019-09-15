scriptName "fn_waitForPlayers";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_waitForPlayers.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_waitForPlayers.sqf"
#include "..\utils.h"

VARIABLE_DEFAULT(sv_setting_DebugMode,0);
VARIABLE_DEFAULT(sv_setting_MinPlayers,0);
private _isDebug = sv_setting_DebugMode == 1;

if (!_isDebug && sv_gameCycle == 0) then {
  waitUntil{(playersNumber civilian) >= sv_setting_MinPlayers};
  private _then = diag_tickTime;
  waitUntil{ (diag_tickTime - _then >= 60) || {({_x getVariable ["playerInitOK", false]} count allPlayers) >= (floor ((playersNumber civilian)*0.66))} };
  uiSleep 1;
};
true
