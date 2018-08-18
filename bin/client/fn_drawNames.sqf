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
    if (side _x == side player && {alive _x}) then {
      private _dist = (player distance _x) / 15;
      private _color = getArray (configFile/'CfgInGameUI'/'SideColors'/'colorFriendly');
      if (cursorTarget != _x) then {
        _color set [3, 1 - _dist]
      };
      drawIcon3D [
        '',
        _color,
        [
          visiblePosition _x select 0,
          visiblePosition _x select 1,
          (visiblePosition _x select 2) +
          ((_x modelToWorld (
              _x selectionPosition 'head'
          )) select 2) + 0.4 + _dist / 1.5
        ],
        0,
        0,
        0,
        name _x,
        2,
        0.03,
        'PuristaMedium'
      ];
    };
  } count playableUnits - [player];
}];

_id
