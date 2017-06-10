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
_requestedClass = ((findDisplay 5000) displayCtrl 300) lbData (lbCurSel ((findDisplay 5000) displayCtrl 300));

switch (_requestedClass) do
{
	case "medic":
	{
		["medic"] spawn client_fnc_spawnPlayer;
	};
	case "support":
	{
		["support"] spawn client_fnc_spawnPlayer;
	};
	case "assault":
	{
		["assault"] spawn client_fnc_spawnPlayer;
	};
	case "engineer":
	{
		["engineer"] spawn client_fnc_spawnPlayer;
	};

	default
	{
		["medic"] spawn client_fnc_spawnPlayer;
	};
};