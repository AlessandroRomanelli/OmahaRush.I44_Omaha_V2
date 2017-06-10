scriptName "fn_getCurrentStageString";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getCurrentStageString.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getCurrentStageString.sqf"

_ret = "null";

// Get current objective
if ((str sv_cur_obj) == (str sv_stage1_obj)) then {
	_ret = "Stage1";
};
if ((str sv_cur_obj) == (str sv_stage2_obj)) then {
	_ret = "Stage2";
};
if ((str sv_cur_obj) == (str sv_stage3_obj)) then {
	_ret = "Stage3";
};
if ((str sv_cur_obj) == (str sv_stage4_obj)) then {
	_ret = "Stage4";
};

_ret
