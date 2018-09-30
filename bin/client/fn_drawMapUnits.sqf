/*
	Author: HallyG
	Displays map markers for all friendly units on the map.

	Argument(s):
	0: Show AI: <BOOLEAN> (default: Show AI in singleplayer only)

	Returns:
	<NOTHING>

	Example:
	[true] spawn FUNCTIONNAME;
	[true] execVM SCRIPTLOCATION;
__________________________________________________________________*/

if (isDedicated || missionNamespace getVariable ["unitMarkers_running", false]) exitWith {};
unitMarkers_running = true;

params [
	["_showAI", !isMultiplayer, [false]]
];

private _fnc_updtMkr = {
	params ["_marker", "_pos", "_dir", "_type", "_name", "_size", "_alpha"];
	_marker setMarkerSizeLocal _size;
	_marker setMarkerPosLocal _pos;
	_marker setMarkerDirLocal _dir;
	_marker setMarkerTypeLocal _type;
	_marker setMarkerTextLocal _name;
	_marker setMarkerAlphaLocal _alpha
};

private _fnc_getMarkerColor = {
	params ["_unit"];
	private _sideColor = [blufor, true] call BIS_fnc_sideColor;
	private _teamColor = "ColorWhiteStrong";
	private _reviveColor = "ColorRedStrong";
	private _enemyColor = "colorOPFOR";
	private _color = _enemyColor;
	if ((side _unit) isEqualTo (side player)) exitWith {
		_color = if ((group _unit) isEqualTo (group player)) then {_teamColor} else {_sideColor};
		if (!alive _unit) then {
			_color = _reviveColor;
		};
		_color
	};
	_color
};

_showAI = true;

private _markers = [];
private _units = [];


while {true} do {
	_units = allUnits select {
		if ((isPlayer _x || _showAI) && {(_x distance sv_cur_obj) < 500}) then {
			true
		};
	};

	if (visibleGPS || visibleMap) then {
		{
			private _marker = format ["Unit%1", _x];
			private _pos = visiblePositionASL _x;
			private _dir = getDirVisual _x;
			private _icon = "mil_triangle";
			private _name = _x getVariable ["name", "ERROR: No Name"];
			private _veh = {isPlayer _x || _showAI} count (crew vehicle _x);
			private _color = [_x] call _fnc_getMarkerColor;
			private _size = [1,1];
			private _alpha = 0.8;

			if !(_marker in _markers) then {
				_markers pushBack (createMarkerLocal [_marker, visiblePositionASL _x]);
				_marker setMarkerColorLocal _color;
			};

			if ((side _x) isEqualTo (side player)) then {
				if (!alive _x) then {
					_icon = "loc_hospital";
					_dir = 0;
				} else {
					if (!isNull objectParent _x) then {
						_name = format ["%1: %2 %3", getText (configFile >> "cfgVehicles" >> typeOf vehicle _x >> "displayname"), (_x getVariable ["name", "ERROR: No Name"]), format [["+%1",""] select (_veh < 2), _veh -1]];
						if (((crew vehicle _x) select {isPlayer _x || _showAI} select 0) isEqualTo _x) then {
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
			[_marker, _pos, _dir, _icon, _name, _size, _alpha] spawn _fnc_updtMkr;
		} forEach (_units select {!isNull _x});
	} else {
		{deleteMarkerLocal _x; true} count _markers;
		_markers = [];
	};
	uiSleep 0.05;
};
