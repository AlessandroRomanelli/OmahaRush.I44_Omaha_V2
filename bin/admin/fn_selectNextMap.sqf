scriptName "fn_selectNextMap";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_selectNextMap.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_selectNextMap.sqf"
#include "..\utils.h"

VARIABLE_DEFAULT(cl_admin_sel_map, "");

if (!isNil 'cl_admin_sel_map' && {cl_admin_sel_map != ""}) then {
	[cl_admin_sel_map] remoteExecCall ['server_fnc_selectNextMap', 2];
	private _admin = findDisplay 7000;
	private _list = _admin displayCtrl 1502;
	(_admin displayCtrl 1000) ctrlSetText format ['Next map: %1', _list lbText (lbCurSel _list)];
};

false
