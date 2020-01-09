scriptName "fn_displaySpawnRestriction";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_displaySpawnRestriction.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displaySpawnRestriction.sqf"
#include "..\utils.h"

// Create display
/* 30 cutRsc ["rr_keyBindingHintPermanent", "PLAIN"]; */
disableSerialization;

private _d = findDisplay 5000;
private _deployBtn = _d displayCtrl 302;
private _deployText = _d displayCtrl 303;
private _timeLeft = _d displayCtrl 304;
private _switchBtn = _d displayCtrl 105;
private _deployBtnCfg = (missionconfigfile >> "rr_spawnmenu" >> "controls" >> "Sidebar_Container" >> "controls" >> "Deploy" >> "Controls" >> "deploybutton");
private _textColor = getArray(_deployBtnCfg >> "colorText");
private _textDisabled = getArray(_deployBtnCfg >> "colorDisabled");
private _backgroundColor = getArray(_deployBtnCfg >> "colorBackground");
private _disabledBackgroundColor = getArray(_deployBtnCfg >> "colorBackgroundDisabled");

if (diag_tickTime - (missionNamespace getVariable ["cl_lastSwitched", 0]) < 15 || {IS_OBJ_ARMED}) then {
	_switchBtn ctrlEnable false;
	_switchBtn ctrlSetBackgroundColor _disabledBackgroundColor;
} else {
	_switchBtn ctrlEnable true;
	_SwitchBtn ctrlSetBackgroundColor _backgroundColor;
};

if (IS_DEFENDING(player)) exitWith {
	_deployBtn ctrlEnable true;
	_deployText ctrlSetTextColor _textColor;
	_timeLeft ctrlSetStructuredText parseText "";
	_deployBtn ctrlSetBackgroundColor _backgroundColor;
};
_timeLeft ctrlEnable false;

// Update text
VARIABLE_DEFAULT(sv_setting_RoundTime, 15);
private _matchTime = sv_setting_RoundTime*60;
if (sv_matchTime > _matchTime) then {
	_timeLeft ctrlSetText ([sv_matchTime - _matchTime, "MM:SS"] call bis_fnc_secondsToString);
	if (ctrlEnabled _deployBtn) then {
		_deployBtn ctrlEnable false;
	};
	_deployBtn ctrlSetBackgroundColor _disabledBackgroundColor;
	_deployText ctrlSetTextColor _textDisabled;
} else {
	_deployBtn ctrlEnable true;
	_timeLeft ctrlSetText "";
	_deployBtn ctrlSetBackgroundColor _backgroundColor;
	_deployText ctrlSetTextColor _textColor;
};

// Delete display
/* 30 cutRsc ["default", "PLAIN"]; */
