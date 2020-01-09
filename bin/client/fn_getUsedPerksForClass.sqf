scriptName "fn_getUsedPerksForClass";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getUsedPerksForClass.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getUsedPerksForClass.sqf"
if (isServer && !hasInterface) exitWith {};

private _class = param[0,"",[""]];

private _perkData = [];

// Get data from profilenamespace
switch (toLower _class) do
{
	case "medic":
	{
		_perkData = profileNamespace getVariable ["rr_perks_medic", ["defibrillator",""]];
	};
	case "support":
	{
		_perkData = profileNamespace getVariable ["rr_perks_support", ["ammo",""]];
	};
	case "assault":
	{
		_perkData = profileNamespace getVariable ["rr_perks_assault", ["grenadier",""]];
	};
	case "engineer":
	{
		_perkData = profileNamespace getVariable ["rr_perks_engineer", ["perkAT",""]];
	};
	case "recon":
	{
		_perkData = profileNamespace getVariable ["rr_perks_recon", ["spawnbeacon",""]];
	};
};

// Fetch data from config
_class = toUpper (_class select [0,1]) + (_class select [1, count _class - 1]);
private _classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> _class);

// Validate class perk // Avoid people loading perks into classes where they dont belong to
if ((_perkData select 0) != "") then {
	private _isValid = false;
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
