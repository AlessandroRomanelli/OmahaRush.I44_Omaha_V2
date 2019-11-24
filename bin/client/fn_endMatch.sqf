scriptName "fn_endMatch";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A. Roman
    File: fn_endMatch.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_endMatch.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

WAIT_IF_NOT(cl_init_done);

private _winners = param[0,"",[""]];

// Huh?
if (_winners == "") exitWith {};

// Make people hear the explosion :)
uiSleep 1;

// Close dialogs
while {dialog} do {
	closeDialog 0;
};

// Play sound!
private _faction = getText(missionConfigFile >> "Unlocks" >> _winners >> "faction");

playSound (format ["ending%1", _faction]);

// Get mcoms
private _mcoms = [];
for "_i" from 1 to 4 do {
	private _mcom = missionNamespace getVariable [format["sv_stage%1_obj", _i], objNull];
	private _hasBeenDone = _mcom getVariable ["status", -1] == 3;
	_mcoms pushback _hasBeenDone;
};

[{_x} count _mcoms] call {
	private _mcomsDestroyed = param[0, 0, [0]];
	private _side = player getVariable ["side", side player];
	if (_side == WEST && _mcomsDestroyed < 4) then {
		private _mcomDefended = 4 - _mcomsDestroyed;
		[format ["<t size='1.3' color='#FFFFFF'>%1 OBJECTIVE(S) DEFENDED</t>", _mcomDefended], 150*_mcomDefended] call client_fnc_pointfeed_add;
		[150*_mcomDefended] call client_fnc_addPoints;
	};
	if (_side == EAST && _mcomsDestroyed > 0) then {
		[format ["<t size='1.3' color='#FFFFFF'>%1 OBJECTIVE(S) DESTROYED</t>", _mcomsDestroyed], 150*_mcomsDestroyed] call client_fnc_pointfeed_add;
		[150*_mcomsDestroyed] call client_fnc_addPoints;
	};
	["<t size='1.3' color='#FFFFFF'>ROUND COMPLETED BONUS</t>", 200] call client_fnc_pointfeed_add;
	[200] call client_fnc_addPoints;
};

// Save stats
[] spawn client_fnc_saveStatistics;

// No damage
player allowDamage false;
player setVariable ["isAlive", false];
player setVariable ["name", name player, true];

// black out
60000 cutRsc ["rr_black", "PLAIN"];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlSetPosition [1 * safezoneW + safezoneX, 0 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlCommit 0;

// Move in
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlSetPosition [0 * safezoneW + safezoneX, 0 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlCommit 0.2;

uiSleep 0.25;

// Delete spawn cam if it exists
if (!isNil "cl_spawnmenu_cam") then {
	if (!isNull cl_spawnmenu_cam) then {
		camDestroy cl_spawnmenu_cam;
	};
};

// Switch to cam that hovers above the arena
cl_exitcam_object = "camera" camCreate (getPos player);
cl_exitcam_object cameraEffect ["Internal", "Back"];
cl_exitcam_object camSetFOV .65;
cl_exitcam_object camSetFocus [150, 1];
cl_exitcam_object camCommit 0;
uiSleep .05;
showCinemaBorder false;

// Display message
private _side = player getVariable ["side", side player];
if (_winners == "attackers") then {
	if (_side == WEST) then {
		["THE ENEMY TEAM HAS WON THE GAME"] call client_fnc_displayObjectiveMessage;
	} else {
		["YOUR TEAM HAS WON THE GAME"] call client_fnc_displayObjectiveMessage;
	};
} else {
	if (_side == WEST) then {
		["YOUR TEAM HAS WON THE GAME"] call client_fnc_displayObjectiveMessage;
	} else {
		["THE ENEMY TEAM HAS WON THE GAME"] call client_fnc_displayObjectiveMessage;
	};
};

// Hide icons
//["rr_spawn_iconrenderer", "onEachFrame"] call bis_fnc_removeStackedEventHandler;

// Disable hud
//["rr_spawn_bottom_right_hud_renderer", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
300 cutRsc ["default","PLAIN"];

// Proper cam animation
cl_exitcam_object camPreparePos [((getPos sv_stage1_obj) select 0) - 200,((getPos sv_stage1_obj) select 1) - 200, 100];
cl_exitcam_object camPrepareTarget sv_stage2_obj;
cl_exitcam_object camCommitPrepared 0;
cl_exitcam_object camPreparePos [((getPos sv_stage4_obj) select 0) - 200,((getPos sv_stage4_obj) select 1) - 200, 100];
cl_exitcam_object camPrepareTarget sv_stage4_obj;
cl_exitcam_object camCommitPrepared 38;

// Blurr
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
	["DynamicBlur", 400, [3]] spawn {
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

uiSleep .3;

// Move out
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlSetPosition [-1 * safezoneW + safezoneX, 0 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlCommit 0.2;

// Lets share our stats with the others
player setVariable ["kills",cl_kills,true];
player setVariable ["deaths",cl_deaths,true];
player setVariable ["points",cl_points,true];

// Wait...
uiSleep 6.5;

// Display for best-ofs
250 cutRsc ["rr_end_bestof","PLAIN"];

// Inline function to fade in / fade out the display
private _fadeInFadeOut = {
	disableSerialization;
	private["_c1", "_c2", "_c3"];
	_c1 = ((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 0);
	_c2 = ((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 1);
	_c3 = ((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 2);
	_c1 ctrlSetPosition [(-0.00531252 + 1) * safezoneW + safezoneX, 0.302 * safezoneH + safezoneY];
	_c2 ctrlSetPosition [(-0.000156274 + 1) * safezoneW + safezoneX, 0.401 * safezoneH + safezoneY];
	_c3 ctrlSetPosition [(-0.000156274 + 1) * safezoneW + safezoneX, 0.533 * safezoneH + safezoneY];
	_c1 ctrlSetFade 1;
	_c2 ctrlSetFade 1;
	_c3 ctrlSetFade 1;
	_c1 ctrlCommit 0;
	_c2 ctrlCommit 0;
	_c3 ctrlCommit 0;

	// Move to middle
	_c1 ctrlSetPosition [(-0.00531252) * safezoneW + safezoneX, 0.302 * safezoneH + safezoneY];
	_c2 ctrlSetPosition [(-0.000156274) * safezoneW + safezoneX, 0.401 * safezoneH + safezoneY];
	_c3 ctrlSetPosition [(-0.000156274) * safezoneW + safezoneX, 0.533 * safezoneH + safezoneY];
	_c1 ctrlSetFade 0;
	_c2 ctrlSetFade 0;
	_c3 ctrlSetFade 0;
	_c1 ctrlCommit 0.5;
	_c2 ctrlCommit 0.5;
	_c3 ctrlCommit 0.5;

	// Wait 7 seconds
	uiSleep 5;

	// Move to left and fade out
	_c1 ctrlSetPosition [(-1) * safezoneW + safezoneX, 0.302 * safezoneH + safezoneY];
	_c2 ctrlSetPosition [(-1) * safezoneW + safezoneX, 0.401 * safezoneH + safezoneY];
	_c3 ctrlSetPosition [(-1) * safezoneW + safezoneX, 0.533 * safezoneH + safezoneY];
	_c1 ctrlSetFade 1;
	_c2 ctrlSetFade 1;
	_c3 ctrlSetFade 1;
	_c1 ctrlCommit 0.5;
	_c2 ctrlCommit 0.5;;
	_c3 ctrlCommit 0.5;;
};

// Lets start determining who was the best of all!
if (true) then {
	private _mostKills = -1;
	private _mostKillsPlayer = objNull;
	{
		if ((_x getVariable ["kills", -1]) > _mostKills) then {
			_mostKills = _x getVariable ["kills", -1];
			_mostKillsPlayer = _x;
		};
	} forEach AllPlayers;

	// Set Text
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='3' color='#FFFFFF' shadow='2' align='center'>%1</t>","MOST ELIMINATIONS"];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='6' color='#FFFFFF' shadow='2' align='center'>%1</t>", _mostKillsPlayer getVariable ["name", name _mostKillsPlayer]];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 2) ctrlSetStructuredText parseText format ["<t size='2.5' color='#FFFFFF' shadow='2' align='center'>%1</t>",_mostKillsPlayer getVariable ["kills", -1]];

	// Display
	[] spawn _fadeInFadeOut;

	// Sleep
	uiSleep 5.25;
};

if (true) then {
	private _bestKD = -1;
	private _bestKDPlayer = objNull;
	{
		private _deaths = (_x getVariable ["deaths", -1]);
		if (_deaths == 0) then {_deaths = 1};
		if (((_x getVariable ["kills", -1]) / _deaths) > _bestKD) then {
			_bestKD = ((_x getVariable ["kills", -1]) / _deaths);
			_bestKDPlayer = _x;
		};
	} forEach AllPlayers;

	private _deaths = (_bestKDPlayer getVariable ["deaths", -1]);
	if (_deaths == 0) then {_deaths = 1};

	// Set Text
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='3' color='#FFFFFF' shadow='2' align='center'>%1</t>","BEST KILL/DEATH RATIO"];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='6' color='#FFFFFF' shadow='2' align='center'>%1</t>", _bestKDPlayer getVariable ["name", name _bestKDPlayer]];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 2) ctrlSetStructuredText parseText format ["<t size='2.5' color='#FFFFFF' shadow='2' align='center'>%1</t>",((_bestKDPlayer getVariable ["kills", -1]) / _deaths)];

	// Display
	[] spawn _fadeInFadeOut;

	// Sleep
	uiSleep 5.25;
};

if (true) then {
	private _mostPoints = -1;
	private _mostPointsPlayer = objNull;
	{
		if ((_x getVariable ["points", -1]) > _mostPoints) then {
			_mostPoints = _x getVariable ["points", -1];
			_mostPointsPlayer = _x;
		};
	} forEach AllPlayers;

	// Set Text
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='3' color='#FFFFFF' shadow='2' align='center'>%1</t>","MOST VALUABLE PLAYER"];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='6' color='#FFFFFF' shadow='2' align='center'>%1</t>", _mostPointsPlayer getVariable ["name", name _mostPointsPlayer]];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 2) ctrlSetStructuredText parseText format ["<t size='2.5' color='#FFFFFF' shadow='2' align='center'>%1</t>",_mostPointsPlayer getVariable ["points", -1]];

	// Display
	[] spawn _fadeInFadeOut;

	// Sleep
	uiSleep 5.25;
};

if (true) then {
	private _bestSquadPoints = -1;
	private _bestSquad = grpNull;
	private _groups = [];
	{
		private _p = 0;
		{
			_p = _p + (_x getVariable ["points", 0]);
		} forEach (units _x);

		_groups pushBack [_p, _x];
	} forEach allGroups;

	{
		if ((_x select 0) > _bestSquadPoints) then {
			_bestSquad = (_x select 1);
			_bestSquadPoints = (_x select 0);

		};
	} forEach _groups;

	// All units of the squad
	private _unitsText = "";
	{
		_unitsText = _unitsText + (_x getVariable ["name", name _x]) + "<br/>";
	} forEach (units _bestSquad);

	// Set Text
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='3' color='#FFFFFF' shadow='2' align='center'>%1</t>","MOST EFFICIENT SQUAD"];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='6' color='#FFFFFF' shadow='2' align='center'>%1</t>",groupId _bestSquad];
	((uiNamespace getVariable ["rr_end_bestof", displayNull]) displayCtrl 2) ctrlSetStructuredText parseText format ["<t size='2.5' color='#FFFFFF' shadow='2' align='center'>%1</t>",_unitsText];

	// Display
	[] spawn _fadeInFadeOut;

	// Sleep
	uiSleep 4.5;
};

60000 cutRsc ["rr_black", "PLAIN"];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlSetPosition [1 * safezoneW + safezoneX, 0 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlCommit 0;

// Move in
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlSetPosition [0 * safezoneW + safezoneX, 0 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_black",displayNull]) displayCtrl 0) ctrlCommit 0.2;

uiSleep 1;

// To safe pos
player setPos cl_safePos;
player allowDamage true;
