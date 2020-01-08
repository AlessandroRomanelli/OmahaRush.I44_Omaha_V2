scriptName "fn_objectiveGUI_update";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_objectiveGUI_update.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_objectiveGUI_update.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

params [["_ctrl", controlNull], ["_index", -1]];

disableSerialization;
private _c = (uiNamespace getVariable ["rr_objective_gui",displayNull]) displayCtrl 0;
private _IntToAlpha = ["A", "B", "C", "D"];
private _idx = [sv_stage1_obj, sv_stage2_obj, sv_stage3_obj, sv_stage4_obj] findIf {_x isEqualTo cl_cur_obj};
if (_idx == -1) exitWith {};
private _picturePath = WWRUSH_ROOT+"pictures\"+(format["obj_%1_%2", _IntToAlpha select _idx, GAMESIDE(player)])+".paa";
_c ctrlSetText _picturePath;

true;
