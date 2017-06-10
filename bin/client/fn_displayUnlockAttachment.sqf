scriptName "fn_displayUnlockAttachment";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayUnlockAttachment.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayUnlockAttachment.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

_info = param[0,[],[[]]];
if (count _info == 0) exitWith {};

// Display unlock layer
120 cutRsc ["rr_weaponUnlockSingle","PLAIN"];

// Get display
_display = uiNamespace getVariable ["rr_weaponUnlockSingle",displayNull];

// Display weapon, attachment and text
(_display displayCtrl 0) ctrlSetStructuredText parseText "<t size='2.5' align='center' shadow='2'>ATTACHMENT UNLOCKED</t>";
(_display displayCtrl 1) ctrlSetStructuredText parseText ("<t align='center' shadow='2' size='10'><img image='" + (([_info select 0] call client_fnc_weaponDetails) select 2) + "'/><img image='" + (([_info select 1] call client_fnc_weaponDetails) select 2) + "'/></t>");

// Play sound
playSound "unlock_epic";