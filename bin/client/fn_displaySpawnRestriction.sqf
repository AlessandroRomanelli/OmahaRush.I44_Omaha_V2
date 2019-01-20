scriptName "fn_displaySpawnRestriction";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displaySpawnRestriction.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displaySpawnRestriction.sqf"

// Create display
/* 30 cutRsc ["rr_keyBindingHintPermanent", "PLAIN"]; */
disableSerialization;

private _d = findDisplay 5000;
private _deployBtn = _d displayCtrl 302;
private _deployBtnCfg = (missionconfigfile >> "rr_spawnmenu" >> "controls" >> "deploybutton");
private _backgroundColor = getArray(_deployBtnCfg >> "colorBackground");
private _disabledBackgroundColor = getArray(_deployBtnCfg >> "colorBackgroundDisabled");
(_d displayCtrl 304) ctrlEnable false;

// Update text
private _matchTime = (["RoundTime", 15] call BIS_fnc_getParamValue)*60;
while {sv_matchTime > _matchTime} do {
	(_d displayCtrl 304) ctrlSetStructuredText parseText format ["<t size='1' color='#FD1A07' shadow='2' align='right' font='PuristaBold'>%1s</t>", round (sv_matchTime - _matchTime)];
	if (ctrlEnabled _deployBtn) then {
		_deployBtn ctrlEnable false;
		_deployBtn ctrlSetBackgroundColor _disabledBackgroundColor;
	};
	sleep 1;
};
_deployBtn ctrlEnable true;
(_d displayCtrl 304) ctrlSetStructuredText parseText "";
_deployBtn ctrlSetBackgroundColor _backgroundColor;

// Delete display
/* 30 cutRsc ["default", "PLAIN"]; */
