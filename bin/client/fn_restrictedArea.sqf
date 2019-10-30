scriptName "fn_restrictedArea";
/*--------------------------------------------------------------------
	Author: A.Roman (ofpectag: MAV)
    File: fn_restrictedArea.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_restrictedArea.sqf"
#include "..\utils.h"
player setVariable ["entryTime", diag_tickTime];


private _safeSpawnDistance = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "safeSpawnDistance");
private _isFallingBack = player getVariable ["isFallingBack", false];
VARIABLE_DEFAULT(sv_setting_OutOfBoundsTime,20);
private _OOBTimeout = [sv_setting_OutOfBoundsTime, [] call client_fnc_getFallbackTime] select _isFallingBack;

[playArea] call client_fnc_updateRestrictions;

"ColorCorrections" ppEffectEnable true;
"ColorCorrections" ppEffectAdjust [1,1,0,[0,0,0,0.5],[1,1,1,0],[0.299,0.587,0.114,0]];
"ColorCorrections" ppEffectCommit 1;
"FilmGrain" ppEffectEnable true;
"FilmGrain" ppEffectAdjust [0.75,1.5,1.7,0.2,1.0,true];
"FilmGrain" ppEffectCommit 1;

for "_i" from _OOBTimeout to 0 step -1 do {
		private _message = [format ["YOU ARE LEAVING THE BATTLEFIELD: %1", _i], format ["FALLBACK TO THE OBJECTIVE: %1", _i]] select _isFallingBack;
		if (player distance (getMarkerPos cl_enemySpawnMarker) < _safeSpawnDistance) then {
			_message = format ["YOU ARE TOO CLOSE TO THE ENEMY HQ: %1", _i];
		};
		// Display error rsc
		50 cutRsc ["rr_timeout","PLAIN", 0.25];
		private _display = uiNamespace getVariable ["timeout", displayNull];
		(_display displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='1.5' align='center' shadow='2' font='PuristaMedium' color='#ff0000'>%1</t>", _message];
		if ((vehicle player) inArea playArea || {player getVariable ["isAlive", true] && cl_inSpawnMenu}) exitWith {};
		uiSleep 1;
		if (_i == 0) then {
			forceRespawn player;
			player setVariable ["isAlive", false];
			["YOU HAVE BEEN KILLED FOR TRESPASSING"] call client_fnc_displayError;
		};
};

50 cutFadeOut 1;

"ColorCorrections" ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0],[-1,-1,0,0,0,0,0]];
"ColorCorrections" ppEffectCommit 1;
"FilmGrain" ppEffectAdjust [0,1.5,1.7,0.2,1.0,true];
"FilmGrain" ppEffectCommit 1;


// Delete myself ay!
cl_restrictedArea_thread = nil;
