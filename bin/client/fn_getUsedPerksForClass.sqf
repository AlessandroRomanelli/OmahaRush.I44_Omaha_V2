scriptName "fn_getUsedPerksForClass";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getUsedPerksForClass.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getUsedPerksForClass.sqf"
if (isServer && !hasInterface) exitWith {};

_class = param[0,"",[""]];

_perkData = [];

// Get data from profilenamespace
switch (_class) do
{
	case "medic":
	{
		_perkData = profileNamespace getVariable ["rr_perks_medic", ["defibrillator",""]];
	};
	case "machinegunner":
	{
		_perkData = profileNamespace getVariable ["rr_perks_machinegunner", ["ammo",""]];
	};
	case "recon":
	{
		_perkData = profileNamespace getVariable ["rr_perks_recon", ["spawnbeacon",""]];
	};
	case "engineer":
	{
		_perkData = profileNamespace getVariable ["rr_perks_engineer", ["repair",""]];
	};
};

// Fetch data from config
_classConfigs = [];
_squadConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "SquadPerks");
switch (_class) do
{
	case "medic":
	{
		_classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Medic");
	};
	case "machinegunner":
	{
		_classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "MachineGunner");
	};
	case "recon":
	{
		_classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Recon");
	};
	case "engineer":
	{
		_classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> "Engineer");
	};
};

// Validate class perk // Avoid people loading perks into classes where they dont belong to
if ((_perkData select 0) != "") then {
	_isValid = false;
	{
		if ((configName _x) == (_perkData select 0)) then {
			_isValid = true;
		};
	} forEach _classConfigs;

	if (!_isValid) then {
		// The perk found in profile namespace could not be found in our configuration file, lets just remove it completely
		_perkData set [0, ""];
	};
};

// Return
_perkData