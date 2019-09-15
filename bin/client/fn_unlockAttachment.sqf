scriptName "fn_unlockAttachment";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_unlockAttachment.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_unlockAttachment.sqf"
if (isServer && !hasInterface) exitWith {};

if (true) exitWith {};

private _unlockedAttachments = [];

private _unlockableAttachments = [] call client_fnc_getUnlockableAttachments;

if (count _unlockableAttachments == 0) exitWith {
	["All attachments for current weapon already unlocked"] spawn client_fnc_displayError;
	[]
};

// Select random attachment to unlock
private _unlockAttachmentClassname = selectRandom _unlockableAttachments;

// Now lets edit the original array >_>
_unlockedAttachments pushBack _unlockAttachmentClassname;

private _curEquip = player getVariable ["loaded_equipment", [cl_equipClassnames select 0, cl_equipClassnames select 1]];
private _weaponInfo = [];

// Which of the two equipped weapons are we playing and what other info do we have about them?
if (_curEquip select 0 select 0 == (currentWeapon player)) then {
	_weaponInfo = _curEquip select 0;
};
if (_curEquip select 1 select 0 == (currentWeapon player)) then {
	_weaponInfo = _curEquip select 1;
};

// No weapon is being played? Select a random one
if (count _weaponInfo == 0) then {
	_weaponInfo = selectRandom _curEquip;
};

// Return classname we just unlocked aswell as the weapon which for!
[_weaponInfo select 0, _unlockAttachmentClassname]
