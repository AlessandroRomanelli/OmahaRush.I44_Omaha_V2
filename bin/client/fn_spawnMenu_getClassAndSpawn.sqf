scriptName "fn_spawnMenu_getClassAndSpawn";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_getClassAndSpawn.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_getClassAndSpawn.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _spawnDisplay = findDisplay 5000;
private _requestedClass = (_spawnDisplay displayCtrl 300) lbData (lbCurSel (_spawnDisplay displayCtrl 300));

[_requestedClass] spawn client_fnc_spawnPlayer;
