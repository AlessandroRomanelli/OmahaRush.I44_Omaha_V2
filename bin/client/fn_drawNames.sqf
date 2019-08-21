scriptName "fn_drawNames.sqf";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_checkClassRestriction.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_drawNames.sqf"
if (isServer && !hasInterface) exitWith {};

private _id = addMissionEventHandler ["Draw3D", {
	{
		if !(!alive _x || {_x == player} || {(_x getVariable ["side", side _x]) != (player getVariable ["side", side player])}) then {
			private _dist = (player distance _x) / 25;
			private _color = getArray(configFile >> "CfgInGameUI" >> "SideColors" >> "colorFriendly");
			if (cursorTarget != _x) then {
				_color set [3, 1 - _dist];
			};
			drawIcon3D ["",_color,(ASLtoAGL (getPosASL _x)) vectorAdd [0,0, 1.9 + (_dist / 2)],0,0,0,_x getVariable ["name", name _x],2,0.03,"PuristaMedium"];
		};
	} forEach playableUnits;
}];

_id
