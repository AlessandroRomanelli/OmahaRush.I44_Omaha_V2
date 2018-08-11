scriptName "fn_objectiveArmedGUIAnimation";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_objectiveArmedGUIAnimation.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_objectiveArmedGUIAnimation.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
_c = (uiNamespace getVariable ["rr_objective_gui",displayNull]) displayCtrl 0;
_obj = sv_cur_obj;

while {(_obj getVariable ["status", -1] == 1) && {sv_cur_obj == _obj}} do {
	_c ctrlSetFade 1;
	_c ctrlCommit 0.5;
	sleep 0.5;
	_c ctrlSetFade 0;
	_c ctrlCommit 0.5;
	sleep 0.5;
};

_c ctrlSetFade 0;
_c ctrlCommit 0;
