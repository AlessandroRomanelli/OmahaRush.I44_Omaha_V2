scriptName "fn_waitForServer";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_waitForServer.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_waitForServer.sqf"

#define HEX_GREEN "#00FF00"
#define HEX_YELLOW "#FFFF00"
#define HEX_RED "#FF0000"

if (isServer && !hasInterface) exitWith {};

player setVariable ["playerInitOK", true, true];
player enableSimulation false;
// Apparently the server isnt done selecting a map yet
60000 cutRsc ["waitingForPlayers", "PLAIN"];

if (!isNil "cl_waitingThread") then {
    terminate cl_waitingThread;
};

cl_waitingThread = addMissionEventHandler["EachFrame", {
  private _display = uiNamespace getVariable ["waitingForPlayers", displayNull];
  private _connectedCtrl = _display displayCtrl 1101;
  private _readyCtrl = _display displayCtrl 1102;
  private "_color";
  private _players = playersNumber west + playersNumber independent;
  private _readyPlayers = {_x getVariable ["playerInitOK", false]} count allPlayers;
  if (_readyPlayers < round(_players*0.4)) then {
    _color = HEX_RED;
  } else {
    if (_readyPlayers >= round(_players*0.4) && _readyPlayers < round(_players*0.8)) then {
      _color = HEX_YELLOW;
    } else {
      _color = HEX_GREEN;
    };
  };
  _connectedCtrl ctrlSetStructuredText (parseText (format ["CONNECTED: %1", _players]));
  _readyCtrl ctrlSetStructuredText (parseText (format ["READY: <t color='%2'>%1</t>", _readyPlayers, _color]));
}];

waitUntil{sv_gameStatus isEqualTo 2};
removeMissionEventHandler ["EachFrame", cl_waitingThread];

cl_waitingThread = nil;

player enableSimulation true;
// Cycle..
60000 cutText ["", "PLAIN"];

[] call client_fnc_spawn;
