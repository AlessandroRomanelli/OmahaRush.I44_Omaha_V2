scriptName "fn_spotTarget";
/*--------------------------------------------------------------------
	Author: A. Roman

    File: fn_spotTarget.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spotTarget.sqf"

if (isServer && !hasInterface) exitWith {};
#include "..\utils.h"


/* systemChat "Spotting targets.."; */
private _side = SIDEOF(player);
private _allEnemies = allUnits select {(alive _x) && (SIDEOF(_x) != _side) && ((_x distance2D player) < 300)};

private _fnc_get_alignment = {
	private _toObj = param [0, objNull, [objNull]];
	if (isNull _toObj) exitWith {0};
	private _dir = vectorNormalized ((getPosVisual _toObj) vectorDiff (getPosVisual player));
	private _cameraDir = getCameraViewDirection player;
	_dir vectorDotProduct _cameraDir
};

{
	private _alignment = [_x] call _fnc_get_alignment;
	if ((_alignment > 0.995 && (_x distance player) < 100) || {cursorTarget isEqualTo _x}) then {
		if ([player, "VIEW", _x] checkVisibility [eyePos player, eyePos _x] > 0.1) then {
			_x setVariable ["isSpotted", serverTime, true];
		};
	};
} forEach _allEnemies;

true
