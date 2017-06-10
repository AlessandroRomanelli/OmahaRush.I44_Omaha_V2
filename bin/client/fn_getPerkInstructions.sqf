scriptName "fn_getPerkInstructions";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getPerkInstructions.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getPerkInstructions.sqf"
if (isServer && !hasInterface) exitWith {};

_perkName = param[0,"",[""]];
_class = param[1,cl_class,[""]];

if (_perkName == "") exitWith {["",""]};

_ret = ["",""];

switch (_class) do
{
	case "medic":
	{
		_ret = getArray(missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Medic" >> _perkName >> "instructions");
	};
	case "support":
	{
		_ret = getArray(missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Support" >> _perkName >> "instructions");
	};
	case "assault":
	{
		_ret = getArray(missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Assault" >> _perkName >> "instructions");
	};
	case "engineer":
	{
		_ret = getArray(missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Engineer" >> _perkName >> "instructions");
	};
};

_ret