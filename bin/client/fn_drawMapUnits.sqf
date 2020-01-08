/* __________________________________________________________________

	Author: A. Roman
	Displays map markers for all friendly units on the map.

__________________________________________________________________*/

#include "..\utils.h"

if (isDedicated || missionNamespace getVariable ["unitMarkers_running", false]) exitWith {};
unitMarkers_running = true;

#define TEAM_COLOR "ColorWhiteStrong"
#define SIDE_COLOR "colorBLUFOR"
#define REVIVE_COLOR "ColorRed"
#define ENEMY_COLOR "colorOPFOR"

params [
	["_showAI", !isMultiplayer, [false]]
];

cl_map_showAI = _showAI;

cl_map_fnc_updtMkr = {
	params ["_marker", "_pos", "_dir", "_type", "_name", "_size", "_alpha"];
	_marker setMarkerSizeLocal _size;
	_marker setMarkerPosLocal _pos;
	_marker setMarkerDirLocal _dir;
	_marker setMarkerTypeLocal _type;
	_marker setMarkerTextLocal _name;
	_marker setMarkerAlphaLocal _alpha
};

cl_map_fnc_getMarkerColor = {
	params ["_unit"];
	private _color = ENEMY_COLOR;
	if ((_unit getVariable ["side", side _unit]) isEqualTo (player getVariable ["side", side player])) exitWith {
		_color = if ((group _unit) isEqualTo (group player)) then {TEAM_COLOR} else {SIDE_COLOR};
		if (!alive _unit) then {
			_color = REVIVE_COLOR;
		};
		_color
	};
	_color
};

cl_map_markers = [];

REMOVE_EXISTING_MEH("EachFrame", cl_map_draw);

cl_map_draw = addMissionEventHandler ["EachFrame", {
	private _units = allUnits select {
		if ((!isNull _x) && {isPlayer _x || cl_map_showAI} && {(_x distance sv_cur_obj) < 1000}) then {
			true
		}
	};
	{
		private _marker = format ["Unit_%1", _x call bis_fnc_netId];
		private _pos = visiblePositionASL _x;
		private _dir = getDirVisual _x;
		private _icon = "mil_triangle";
		private _name = _x getVariable ["name", name _x];
		private _veh = {isPlayer _x || cl_map_showAI} count (crew vehicle _x);
		private _color = [_x] call cl_map_fnc_getMarkerColor;
		private _size = [1,1];
		private _alpha = 0.8;

		if !(_marker in cl_map_markers) then {
			cl_map_markers pushBack (createMarkerLocal [_marker, visiblePositionASL _x]);
		};

		_marker setMarkerColorLocal _color;

		if ((_x getVariable ["side", side _x]) isEqualTo (player getVariable ["side", side player])) then {
			if !(alive _x) then {
				_icon = "loc_hospital";
				_dir = 0;
			} else {
				if (!isNull objectParent _x) then {
					_name = format ["%1: %2 %3", getText (configFile >> "cfgVehicles" >> typeOf vehicle _x >> "displayname"), _x getVariable ["name", name _x], format [["+%1",""] select (_veh < 2), _veh -1]];
					if (((crew vehicle _x) select {isPlayer _x || cl_map_showAI} select 0) isEqualTo _x) then {
						_icon = "mil_box";
					} else {
						_icon = "Empty";
					};
				} else {
					_size = [0.8,1];
				};
			};
		} else {
			if (_x getVariable ["isSpotted", 0] > 0) then {
				_icon = "mil_circle";
				_size = [0.4, 0.4];
				_alpha = (10 + (_x getVariable ["isSpotted", 0]) - serverTime)/10;
				if (_alpha < 0) then {
					_alpha = 0;
				};
				_name = "";
			} else {
				_icon = "Empty";
			};
		};
		[_marker, _pos, _dir, _icon, _name, _size, _alpha] spawn cl_map_fnc_updtMkr;
	} forEach _units;
}];

TERMINATE_SCRIPT(cl_map_markers_check);

cl_map_markers_check = [] spawn {
	while {true} do {
		private _indices = [];
		{
			private _marker = _x;
			private _sub = _marker splitString "_";
			if ((_sub select 0) isEqualTo "Unit") then {
				private _obj = (_sub select 1) call BIS_fnc_objectFromNetId;
				if (isNull _obj) then {
					deleteMarker _marker;
					_indices pushBack (cl_map_markers findIf {_x isEqualTo _marker});
				};
			}
		} forEach allMapMarkers;
		for "_i" from (count _indices - 1) to 0 step -1 do {
			private _j = _indices select _i;
			cl_map_markers deleteAt _j;
		};
		uiSleep 5;
	};
};
