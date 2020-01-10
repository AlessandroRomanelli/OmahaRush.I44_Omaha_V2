scriptName "fn_spawn";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawn.sqf

	Written by A.Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawn.sqf"
#define KEY_ESC 1
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};


// Not too fast
if (diag_tickTime - (missionNamespace getVariable ["cl_spawnmenu_lastStartTick", 0]) < 1) exitWith {};
cl_spawnmenu_lastStartTick = diag_tickTime;

cl_inSpawnMenu = true;

// Set player to safe location
player setPos cl_safePos;

player setVariable ["wasHS", false];
player setVariable ["isAlive", false];

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
60000 cutFadeOut 0;
60001 cutFadeOut 0;

400 cutRsc ["rr_objective_gui","PLAIN"];
300 cutFadeOut 0;
// Setup the objective icon at the top
disableSerialization;
private _isDefending = IS_DEFENDING(player);

VARIABLE_DEFAULT(sv_setting_RotationsPerMatch, 2);
// If the server will restart after this round, display a visual warning at the top right
if (sv_gameCycle >= (sv_setting_RotationsPerMatch - 1)) then {
	500 cutRsc ["rr_topRightWarning", "PLAIN"];
	((uiNamespace getVariable ["rr_topRightWarning", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='1.2' color='#FE4629' shadow='2' align='right'>LAST ROUND BEFORE MAP CHANGE</t>";
};

private _marker1 = createMarkerLocal ["mobile_respawn_defenders",[0,0]];
if (_marker1 != "") then {
	_marker1 setMarkerTypeLocal (["o_unknown","b_unknown"] select _isDefending);
	_marker1 setMarkerTextLocal " Defenders HQ";
};

private _marker2 = createMarkerLocal ["mobile_respawn_attackers",[0,0]];
if (_marker2 != "") then {
	_marker1 setMarkerTypeLocal (["b_unknown","o_unknown"] select _isDefending);
	_marker2 setMarkerTextLocal " Attackers HQ";
};

// Markers
[] call client_fnc_updateMarkers;

// Hide hud
showHUD [true,false,false,false,false,true,false,true,false];

// Run equipment checks
[] call client_fnc_getLoadedEquipment;
[] call client_fnc_validateEquipment;


// Disable voice channels
[] call client_fnc_disableChannels;

removeUniform player;
removeVest player;
removeHeadgear player;
removeBackpack player;

// Markers
[playArea] call client_fnc_updateRestrictions;


// Wait until the objectives are available
waitUntil {!isNil "sv_stage1_obj" && !isNil "sv_stage2_obj" && !isNil "sv_stage3_obj" && !isNil "sv_stage4_obj"};

private _objectives = [sv_stage1_obj, sv_stage2_obj, sv_stage3_obj, sv_stage4_obj];
{
	if (_forEachIndex > 0) then {
		_x setVariable ["pre_stage", format["Stage%1", _forEachIndex]];
	};
	_x setVariable ["cur_stage", format["Stage%1", _forEachIndex + 1]];
	if (_forEachIndex != (count _objectives - 1)) then {
		_x setVariable ["nex_stage", format["Stage%1", _forEachIndex + 2]];
	};
} forEach _objectives;

// Display all buildings
setObjectViewDistance 1000;
setViewDistance 1250;

// DUMMY WEAPON SO THE PLAYER DOESNT PLAY THE ANIMATION WHEN HE SPAWNS
removeAllWeapons player;

// Create spawn cam
private _created = false;
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
		cl_spawnmenu_cam camSetFOV .90;
		cl_spawnmenu_cam camSetFocus [150, 1];
		cl_spawnmenu_cam camCommit 0.5;
	};
};
uiSleep 0.05;
showCinemaBorder false;
cameraEffectEnableHUD true;

// Get cam pos for spawn menu cam
private _stage = sv_cur_obj getVariable ["cur_stage", "Stage1"];
private _pos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _stage >> "Spawns" >> GAMESIDE(player) >> "HQSpawn" >> "positionATL");
private _cameraSet = [_pos] call displays_fnc_spawnMenu_getCameraPosAndTarget;
cl_spawnmenu_cam camPreparePos (_cameraSet select 0);
cl_spawnmenu_cam camPrepareTarget (_cameraSet select 1);

// If the camera is new, commit instantly, otherwise zoom out slowly
if (_created) then {
	cl_spawnmenu_cam camCommitPrepared 0;
	60000 cutRsc ["rr_spawn","PLAIN"];
} else {
	cl_spawnmenu_cam camCommitPrepared 1.5;
};

// Create spawn dialog
private _menuDisplay = (findDisplay 5000);
if (isNull _menuDisplay) then {
	createDialog "rr_spawnmenu";
	_menuDisplay = (findDisplay 5000);
};

// Blurry background?
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
	["DynamicBlur", 400, [0.5]] spawn {
		params ["_name", "_priority", "_effect"];
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
[] call client_fnc_populateSpawnMenu;

// Add eventhandlers to the dialog and hide the weapon selection
cl_spawnmenu_currentWeaponSelectionState = 0; // Nothing open
disableSerialization;

{(_menuDisplay displayCtrl _x) ctrlSetStructuredText parseText "<t size='0.75' color='#ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>"} forEach [2001,2002];

// Event handlers for hover actions
{
	(_menuDisplay displayCtrl _x) ctrlRemoveAllEventHandlers "MouseEnter";
	(_menuDisplay displayCtrl _x) ctrlRemoveAllEventHandlers "MouseExit";

	(_menuDisplay displayCtrl _x) ctrlAddEventHandler ["MouseEnter", {
		private _display = findDisplay 5000;
		if ((_this select 0) isEqualTo (_display displayCtrl 15)) then {
			if (cl_spawnmenu_currentWeaponSelectionState != 1) then {
				(_display displayCtrl 207) ctrlSetBackgroundColor [0.725,0.588,0.356,0.8];
			};
		} else {
			private _secondaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >>  GAMESIDE(player) >> _x >> "type")) == "secondary"};
			if (cl_spawnmenu_currentWeaponSelectionState != 2 && {count _secondaryWeapons != 0}) then {
				(_display displayCtrl 209) ctrlSetBackgroundColor [0.725,0.588,0.356,0.8];
			};
		};
	}];
	(_menuDisplay displayCtrl _x) ctrlAddEventHandler ["MouseExit", {
		private _display = findDisplay 5000;
		if (cl_spawnmenu_currentWeaponSelectionState != 1) then {
			(_display displayCtrl 207) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
		};
		if (cl_spawnmenu_currentWeaponSelectionState != 2) then {
			(_display displayCtrl 209) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
		};
	}];
} forEach [15,16];

uiNamespace getVariable ["wwr_loadout_right_col", controlNull] ctrlShow false;

[false] spawn client_fnc_spawnMenu_loadClasses;
[] spawn {
	[] call client_fnc_loadSpawnpoints;
	private _display = findDisplay 5000;
	private _spawnCtrl = _display displayCtrl 8;
	waitUntil {(lbSize _spawnCtrl) > 0};
	_spawnCtrl lbSetCurSel 0;
};

if (isNil "TEMPWARNING") then {
	createDialog "rr_info_box";
	((findDisplay 10000) displayCtrl 0) ctrlSetStructuredText parseText ("<t size='1' color='#FFFFFF' shadow='2' align='left'>
	<t font='PuristaBold'>WWRush</t>
	<br/>V"+getText(missionConfigFile >> "version")+"
	<br/>
	<br/><t font='PuristaBold'>Changelog</t>
	<br/><a href='https://github.com/AlessandroRomanelli/WWR-Template/blob/master/ChangeLog.md'>Learn more</a>
	<br/>
	<br/><t font='PuristaBold'>Github Repository</t>
	<br/><a href='https://github.com/AlessandroRomanelli/WWR-Template'>Browse Files</a></t>");
	playSound "introSong";
	TEMPWARNING = true;
};

player enableStamina false;
player forceWalk false;
player setSpeaker "NoVoice";

if (isNil "unitMarkers_running") then {
	[] spawn client_fnc_drawMapUnits;
};
