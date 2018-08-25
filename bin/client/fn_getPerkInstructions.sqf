scriptName "fn_getPerkInstructions";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getPerkInstructions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getPerkInstructions.sqf"
if (isServer && !hasInterface) exitWith {};

private _perkName = param[0,"",[""]];
private _class = param[1,cl_class,[""]];

if (_perkName == "") exitWith {["",""]};

_class = _class splitString "";
_class set [0, (toUpper (_class select 0))];
_class = _class joinString "";

getArray(missionConfigFile >> "CfgPerks" >> "ClassPerks" >> _class >> _perkName >> "instructions");
