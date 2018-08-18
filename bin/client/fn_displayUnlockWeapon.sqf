scriptName "fn_displayUnlockWeapon";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayUnlockWeapon.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayUnlockWeapon.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

private _classname = param[0,"",[""]];
if (_classname == "") exitWith {};

// Display unlock layer
120 cutRsc ["rr_weaponUnlockSingle","PLAIN"];

// Get display
private _display = uiNamespace getVariable ["rr_weaponUnlockSingle",displayNull];

// Display weapon and text
(_display displayCtrl 0) ctrlSetStructuredText parseText "<t size='2.5' align='center' shadow='2'>NEW WEAPON UNLOCKED</t>";
(_display displayCtrl 1) ctrlSetStructuredText parseText ("<t align='center' shadow='2' size='13'><img image='" + (([_classname] call client_fnc_weaponDetails) select 2) + "'/></t>");

// Play sound
playSound "unlock_epic";
