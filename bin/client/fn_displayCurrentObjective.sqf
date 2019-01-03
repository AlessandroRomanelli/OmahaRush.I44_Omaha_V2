private _side = player getVariable ["gameSide", "defenders"];
private _HQPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Spawns" >> _side >> "HQSpawn" >> "positionATL");

// Objectives
private _pos = sv_cur_obj getVariable ["positionAGL", []];
if (count _pos == 0) then {
  _pos = sv_cur_obj modelToWorldVisual [0,0,0.5];
  sv_cur_obj setVariable ["positionAGL", _pos];
};

private _alpha = [_pos] call {
  private _pos = param [0, [], [[]]];
  if (count _pos == 0) exitWith {1};
  private _relDir = player getRelDir _pos;
  if (_relDir < 10) exitWith {
    0.25 + (3*_relDir/40)
  };
  if (_relDir >= 10 && _relDir <= 350) exitWith {
    1
  };
  if (_relDir > 350) exitWith {
    1 - (3/40*_relDir) + 26.25
  };
  1
};

if ((sv_cur_obj getVariable ["status", -1]) isEqualTo 1) then {
  _alpha = 2/3 + (1/3*cos(100*diag_tickTime*pi));
};

private _objIsArmed = sv_cur_obj getVariable ["status", -1] isEqualTo 1;
private _origin = if (cl_inSpawnMenu) then {_HQPos} else {getPos player};
if (_side isEqualTo "defenders") then {
  if (_objIsArmed) then {
    drawIcon3D [MISSION_ROOT+"pictures\objective_defender_armed.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Defuse (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
  } else {
    drawIcon3D [MISSION_ROOT+"pictures\objective_defender.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Defend (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
  };
} else {
  if (_objIsArmed) then {
    drawIcon3D [MISSION_ROOT+"pictures\objective_attacker_armed.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Protect (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
  } else {
    drawIcon3D [MISSION_ROOT+"pictures\objective_attacker.paa",[1,1,1,_alpha],_pos,1.5,1.5,0,format["Attack (%1m)", round(_origin distance2D sv_cur_obj)],2,0.04, "PuristaLight", "center", true];
  };
};

private _d = uiNamespace getVariable ["rr_objective_gui", displayNull];
(_d displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='left'>%1</t>", sv_tickets];
(_d displayCtrl 4) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' font='PuristaMedium' align='right'>%1</t>", [sv_matchTime, "MM:SS"] call bis_fnc_secondsToString];
(_d displayCtrl 2) progressSetPosition (sv_tickets / sv_tickets_total);
