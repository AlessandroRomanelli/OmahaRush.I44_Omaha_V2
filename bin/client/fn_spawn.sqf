scriptName "fn_spawn";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawn.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawn.sqf"
if (isServer && !hasInterface) exitWith {};

player setVariable ["wasHS", false];
player setVariable ["unitDmg", 0];

if (player getVariable ["firstSpawn", true]) then {
	player setVariable ["firstSpawn", false];
	playSound "introSong";
};

// Not too fast
if (diag_tickTime - (missionNamespace getVariable ["cl_spawnmenu_lastStartTick", 0]) < 1) exitWith {};
cl_spawnmenu_lastStartTick = diag_tickTime;

// Strip player
removeUniform player;
removeBackpackGlobal player;
removeAllWeapons player;
removeGoggles player;
removeHeadgear player;
removeAllAssignedItems player;
removeVest player;

// Mute sound
//0 fadeSound 0;
0 fadeRadio 0;

// No damage
player allowDamage false;

// Reset array of assists
cl_assistsInfo = [];

// Delete layers that may be still there
60001 cutRsc ["default", "PLAIN"];

400 cutRsc ["rr_objective_gui","PLAIN"];
// Setup the objective icon at the top
if (player getVariable "gameSide" == "defenders") then {
	disableSerialization;
	_d = uiNamespace getVariable ["rr_objective_gui", displayNull];
	(_d displayCtrl 0) ctrlSetText "pictures\objective_defender.paa";
};

// If the server will restart after this round, display a visual warning at the top right
if (sv_gameCycle >= (("RotationsPerMatch" call bis_fnc_getParamValue) - 1)) then {
	15 cutRsc ["rr_topRightWarning", "PLAIN"];
	((uiNamespace getVariable ["rr_topRightWarning", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='1.2' color='#FE4629' shadow='2' align='right'>LAST ROUND BEFORE MAP CHANGE</t>"
};

// Set player to safe location
player setPos cl_safePos;

//Keeping the role updated
if (sv_gameCycle % 2 == 0) then {
	if (playerSide == WEST) then {
		player setVariable ["gameSide", "defenders", true];
	} else {
		player setVariable ["gameSide", "attackers", true];
	};
} else {
	if (playerSide == WEST) then {
		player setVariable ["gameSide", "attackers", true];
	} else {
		player setVariable ["gameSide", "defenders", true];
	};
};

if (player getVariable "gameSide" == "defenders") then {
	_marker1 = createMarkerLocal ["mobile_respawn_defenders",[0,0]];
	_marker1 setMarkerTypeLocal "b_unknown";
	_marker1 setMarkerTextLocal " Defenders HQ";

	_marker2 = createMarkerLocal ["mobile_respawn_attackers",[0,0]];
	_marker2 setMarkerTypeLocal "o_unknown";
	_marker2 setMarkerTextLocal " Attackers HQ";
} else {
	_marker1 = createMarkerLocal ["mobile_respawn_defenders",[0,0]];
	_marker1 setMarkerTypeLocal "o_unknown";
	_marker1 setMarkerTextLocal " Defenders HQ";

	_marker2 = createMarkerLocal ["mobile_respawn_attackers",[0,0]];
	_marker2 setMarkerTypeLocal "b_unknown";
	_marker2 setMarkerTextLocal " Attackers HQ";
};

// Markers
[] spawn client_fnc_updateMarkers;

// Hide hud
_3dcursor = [false, true] select ("Cursor3DEnable" call bis_fnc_getParamValue);
showHUD [true,false,false,false,false,true,false,_3dcursor,false];

// Run equipment checks
[] call client_fnc_getLoadedEquipment;
[] call client_fnc_validateEquipment;


// Disable voice channels
[] spawn client_fnc_disableChannels;

_side = player getVariable "gameSide";
_sideLoadout = [] call client_fnc_getCurrentSideLoadout;

_uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "uniforms"));
_goggles = (getText(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "goggles"));
_vests		 = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "vests"));
_headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "headgears"));
_backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "backpacks"));

if (count _uniforms > 0) then {player forceAddUniform (selectRandom _uniforms);};
if (_goggles != "") then {player addGoggles _goggles;};
if (count _headgears > 0) then {player addHeadgear (selectRandom _headgears);};
if (count _vests > 0) then {player addVest (selectRandom _vests);};
if (count _backpacks > 0) then {player addBackpack (selectRandom _backpacks);};

// Shared items
/*player addItem "ItemGPS";
player assignItem "ItemGPS";*/

// Markers
[] spawn client_fnc_updateRestrictions;


// Wait until the objectives are available
waitUntil {!isNil "sv_stage1_obj" && !isNil "sv_stage2_obj" && !isNil "sv_stage3_obj" && !isNil "sv_stage4_obj"};

// Get cam pos for spawn menu cam
_stage = "null";
while {_stage == "null"} do {
	_stage = [] call client_fnc_getCurrentStageString;
};
_side = player getVariable "gameSide";
_pos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Spawns" >> _side);

// Determine point between current pos and target pos
_targetPos = [_pos, getPos sv_cur_obj] call client_fnc_getSectionCenter;

// Set cam pos height
_pos set[2, 400];

// Display all buildings
setObjectViewDistance 1000;
setViewDistance 2000;

// DUMMY WEAPON SO THE PLAYER DOESNT PLAY THE ANIMATION WHEN HE SPAWNS
removeAllWeapons player;

// Create spawn cam
_created = false;
if (isNil "cl_spawnmenu_cam") then {
	diag_log "SPAWNMENU_CAM WAS NIL";
	cl_spawnmenu_cam = "camera" camCreate (getPos player);
	cl_spawnmenu_cam cameraEffect ["Internal", "Back"];
	cl_spawnmenu_cam camSetFOV .90;
	cl_spawnmenu_cam camSetFocus [150, 1];
	cl_spawnmenu_cam camCommit 0;
	_created = true;
} else {
	if (isNull cl_spawnmenu_cam) then {
		diag_log "SPAWNMENU_CAM WAS NULL";
		cl_spawnmenu_cam = "camera" camCreate (getPos player);
		cl_spawnmenu_cam cameraEffect ["Internal", "Back"];
		cl_spawnmenu_cam camSetFOV .90;
		cl_spawnmenu_cam camSetFocus [150, 1];
		cl_spawnmenu_cam camCommit 0;
		_created = true;
	} else {
		diag_log "SPAWNMENU_CAM WAS NEITHER";
	};
};
sleep 0.05;
showCinemaBorder false;
cameraEffectEnableHUD true;

cl_spawnmenu_cam camPreparePos _pos;
cl_spawnmenu_cam camPrepareTarget _targetPos;

// If the camera is new, commit instantly, otherwise zoom out slowly
if (_created) then {
	cl_spawnmenu_cam camCommitPrepared 0;
	60000 cutRsc ["rr_spawn","PLAIN"];
} else {
	cl_spawnmenu_cam camCommitPrepared 1.5;
};

// Create spawn dialog
createDialog "rr_spawnmenu";

// Disable ESC
(findDisplay 5000) displayAddEventHandler ["KeyDown",{
	_handled = false;
	if ((_this select 1) == 1) then {
		_handled = true; // Block ESC
	};
	_handled;
}];

// Blurry background?
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
	["DynamicBlur", 400, [0.4]] spawn {
		params ["_name", "_priority", "_effect", "_handle"];
		while {
			cl_spawnmenu_blur = ppEffectCreate [_name, _priority];
			cl_spawnmenu_blur < 0
		} do {
			_priority = _priority + 1;
		};
		cl_spawnmenu_blur ppEffectEnable true;
		cl_spawnmenu_blur ppEffectAdjust _effect;
		cl_spawnmenu_blur ppEffectCommit 0.1;
	};
};

// Populate the structured texts
[] spawn client_fnc_populateSpawnMenu;

// Enable spawn buttons // REDONE WITH LISTBOX UPDATE // SEE SPAWNMENU_LOADCLASSES
((findDisplay 5000) displayCtrl 302) ctrlAddEventHandler ["ButtonDown",{
	profileNamespace setVariable ["rr_class_preferred", cl_class];
	[] spawn client_fnc_spawnMenu_getClassAndSpawn
}];

// Add eventhandlers to the dialog and hide the weapon selection
cl_spawnmenu_currentWeaponSelectionState = 0; // Nothing open
disableSerialization;

((findDisplay 5000) displayCtrl 15) ctrlAddEventHandler ["ButtonDown",{
	[] spawn client_fnc_spawnMenu_displayPrimaryWeaponSelection;
}];

((findDisplay 5000) displayCtrl 16) ctrlAddEventHandler ["ButtonDown",{
	_secondaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x >> "type")) == "secondary"};
	if (count _secondaryWeapons != 0) then {
		[] spawn client_fnc_spawnMenu_displaySecondaryWeaponSelection;
	};
}];
/* ((findDisplay 5000) displayCtrl 12) ctrlAddEventHandler ["ButtonDown",{[] spawn client_fnc_spawnMenu_displayPrimaryAttachmentSelection;}];
((findDisplay 5000) displayCtrl 13) ctrlAddEventHandler ["ButtonDown",{[] spawn client_fnc_spawnMenu_displaySecondaryAttachmentSelection;}]; */
((findDisplay 5000) displayCtrl 100) ctrlAddEventHandler ["ButtonDown",{
	[] spawn client_fnc_spawnMenu_displayGroupManagement;
}];

// Load available classes and select our preferred one
[] spawn client_fnc_spawnMenu_loadClasses;

// Hide the weapon selection listbox and its background + the attachment listboxes and their backgrounds
{
	((findDisplay 5000) displayCtrl _x) ctrlShow false;
} forEach [
	2,3,
	20,21,22,25,23,24,26,27,28,29
];

[] spawn {
	[] spawn client_fnc_loadSpawnpoints;
	while {dialog} do {
		sleep 0.05;
		[] spawn client_fnc_loadSpawnpoints;
	};
};

// First start warning TEMP
if (isNil "TEMPWARNING") then {
	// TEMPRARY WARNING TODO
	createDialog "rr_info_box";
	((findDisplay 10000) displayCtrl 0) ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='left'><t font='PuristaBold'>No.4 WW2 Rush Version</t><br/>0.64.0<br/><br/><t font='PuristaBold'>Changelog</t><br/><a href='https://github.com/AlessandroRomanelli/OmahaRush.I44_Omaha_V2/blob/master/ChangeLog.md'>Learn more</a><br/><br/><t font='PuristaBold'>Official Website</t><br/><a href='http://www.no4commando.com'>Open</a></t>";
	TEMPWARNING = true;
};

player enableStamina false;
player forceWalk false;
player setSpeaker "NoVoice";

[true] spawn client_fnc_drawMapUnits;
