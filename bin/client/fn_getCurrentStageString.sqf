scriptName "fn_getCurrentStageString";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getCurrentStageString.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getCurrentStageString.sqf"

if (str sv_cur_obj == str sv_stage1_obj) exitWith {"Stage1"};
if (str sv_cur_obj == str sv_stage2_obj) exitWith {"Stage2"};
if (str sv_cur_obj == str sv_stage3_obj) exitWith {"Stage3"};
if (str sv_cur_obj == str sv_stage4_obj) exitWith {"Stage4"};
