private _ammoBoxes = (getPos player) nearObjects ["LIB_AmmoCrates_NoInteractive_Large", 7];
{
  private _pos = getPosASL _x;
  _pos set [2, (_pos select 2) + 0.5];
  private _distance = player distance _x;
  private _alpha = if (_distance < 5) then {1} else {1-(1/2*_distance)+2.5};
  drawIcon3D [MISSION_ROOT+"pictures\support.paa", [1,1,1,_alpha], ASLtoAGL _pos, 1.5, 1.5, 0, format["Rearm (%1m)", round _distance], 2, 0.04, "PuristaLight", "center", true];
} forEach _ammoBoxes;

// Squad icons
{
  private _pos = getPosATLVisual (_x select 0);
  _pos set [2, (_pos select 2) + 1.85];
  drawIcon3D[_x select 2, [1,1,1, _x select 3], _pos, 1.5, 1.5, 0, _x select 1, 2, 0.04, "PuristaMedium", "center", true];
} forEach cl_onEachFrame_squad_members;

// Squad spawn beacons
{
  drawIcon3D["", [1,1,1,1], _x select 0, 1.5, 1.5, 0, _x select 1, 2, 0.04, "PuristaMedium", "center", true];
} forEach cl_onEachFrame_squad_beacons;

// Team icons
{
  private _unit = _x select 0;
  private _pos = getPosATLVisual _unit;
  _pos set [2, (_pos select 2) + 1.85];
  if (_unit == (driver vehicle cursorObject) || _unit == (driver vehicle cursorTarget)) then {
    drawIcon3D[_x select 2, [1,1,1,0.75], _pos, 0.5, 0.5, 0, _x select 1, 2, 0.03, "PuristaMedium", "center", false];
  } else {
    drawIcon3D[_x select 2, [1,1,1,0.25], _pos, 0.5, 0.5, 0, "", 2, 0.03, "PuristaMedium", "center", false];
  };
} forEach cl_onEachFrame_team_members;

// 3D Spotted enemies
{
  private _unit = _x select 0;
  private _time = _x select 1;
  private _pos = getPosATLVisual _unit;
  _pos set [2, (_pos select 2) + 1];
  if (serverTime - _time > 10) then {
    /* systemChat format ["Expired 3D spot for unit: %1 because %2s passed since spotting.", name _unit, serverTime - _time]; */
    _unit setVariable ["isSpotted", nil];
    _unit setVariable ["3dspotted", false];
  } else {
    if (_unit getVariable ["3dspotted", false]) then {
      private _alpha = ((10 + _time - serverTime)/10)*0.66;
      if (_alpha < 0 || ([player, "VIEW", _unit] checkVisibility [eyePos player, eyePos _unit] < 0.2)) then {
        _alpha = 0;
      };
      drawIcon3D [MISSION_ROOT+"pictures\enemy.paa", [1,1,1,_alpha], _pos, 0.3, 0.3, 0, "", 2, 0.03, "PuristaMedium", "center", false];
    };
  };
} forEach cl_onEachFrame_spotted_enemies;

// Revive icons
if (cl_class == "medic") then {
  {
    private _pos = getPosATLVisual _x;
    _pos set [2, (_pos select 2) + 0.1];
    drawIcon3D [MISSION_ROOT+"pictures\revive.paa", [1,1,1,0.8], _pos, 1.5, 1.5, 0, "", 2, 0.035, "PuristaMedium", "center", false];
  } forEach cl_onEachFrame_team_reviveable;
};
