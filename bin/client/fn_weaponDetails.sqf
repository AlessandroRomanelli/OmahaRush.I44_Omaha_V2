scriptName "fn_weaponDetails";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_weaponDetails.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_weaponDetails.sqf"
if (isServer && !hasInterface) exitWith {};

private _classname = param[0,"",[""]];
private ["_displayName", "_picture"];
if (isClass (configFile >> "CfgWeapons" >> _classname)) then {
  _displayName = getText(configFile >> "CfgWeapons" >> _classname >> "displayName");
  _picture = getText(configFile >> "CfgWeapons" >> _classname >> "picture");
} else {
  _displayName = getText(configFile >> "CfgMagazines" >> _classname >> "displayName");
  _picture = getText(configFile >> "CfgMagazines" >> _classname >> "picture");
};


[_classname, _displayName, _picture]
