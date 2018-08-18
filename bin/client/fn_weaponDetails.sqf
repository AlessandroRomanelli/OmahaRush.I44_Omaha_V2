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
private _displayName = getText(configFile >> "CfgWeapons" >> _classname >> "displayName");
private _picture = getText(configFile >> "CfgWeapons" >> _classname >> "picture");

[_classname, _displayName, _picture]
