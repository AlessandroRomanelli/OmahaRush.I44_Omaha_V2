scriptName "fn_getUnlockableAttachments";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getUnlockableAttachments.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getUnlockableAttachments.sqf"
if (isServer && !hasInterface) exitWith {};

private["_curEquip","_weaponInfo","_currentWeapon"];

// Unlocks random attachment for currently used weapon
_currentWeapon = currentWeapon player;

_curEquip = [] call client_fnc_getLoadedEquipment;
_weaponInfo = [];

// Which of the two equipped weapons are we playing and what other info do we have about them?
if (_curEquip select 0 select 0 == _currentWeapon) then {
	_weaponInfo = _curEquip select 0;
};
if (_curEquip select 1 select 0 == _currentWeapon) then {
	_weaponInfo = _curEquip select 1;
};

// No weapon is being played? Select a random one
if (count _weaponInfo == 0) then {
	_weaponInfo = selectRandom _curEquip;
};

// Get unlocked attachments
_unlockedAttachments = _weaponInfo select 2;

// Cycle through unlockable items via config and create a list of classnames that could be unlocked
_attachmentConfigs = "true" configClasses (missionConfigFile >> "Unlocks" >> (_weaponInfo select 0) >> "attachments");

_unlockableAttachments = [];

// Populate cl_equipConfigurations with all possible weapons
for "_i" from 0 to (count _attachmentConfigs - 1) step 1 do
{
	_attachmentClassname = configName (_attachmentConfigs select _i);
	_found = false;

	{
		if (_x == _attachmentClassname) then {
			_found = true;
		};
	} forEach _unlockedAttachments;

	// Not found? Add to list of unlockable attachments
	_unlockableAttachments pushBack _attachmentClassname;
};

// No duplicates
_finalUnlockableAttachments = [];
_e = [] call client_fnc_getLoadedEquipment;
{
	if !(_x in (_weaponInfo select 2)) then {
		_finalUnlockableAttachments pushBack _x;
	};
} forEach _unlockableAttachments;


_finalUnlockableAttachments;