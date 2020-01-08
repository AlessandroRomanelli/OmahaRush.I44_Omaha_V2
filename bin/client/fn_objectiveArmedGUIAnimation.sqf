scriptName "fn_objectiveArmedGUIAnimation";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_objectiveArmedGUIAnimation.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_objectiveArmedGUIAnimation.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};
	
disableSerialization;

private _c = (uiNamespace getVariable ["rr_objective_gui",displayNull]) displayCtrl 0;
private _obj = sv_cur_obj;

while {IS_OBJ_ARMED && {sv_cur_obj == _obj}} do {
	_c ctrlSetFade 1;
	_c ctrlCommit 0.5;
	uiSleep 0.5;
	_c ctrlSetFade 0;
	_c ctrlCommit 0.5;
	uiSleep 0.5;
};

_c ctrlSetFade 0;
_c ctrlCommit 0;
