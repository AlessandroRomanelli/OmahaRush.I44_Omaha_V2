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

if (isDedicated || missionNamespace getVariable ["HGF_unitMarkers_running", false]) exitWith {};
HGF_unitMarkers_running = true;

params [
	["_showAI", !isMultiplayer, [false]]
];

private _fnc_updtMkr = {
	params ["_marker", "_pos", "_dir", "_type", "_name"];

	_marker setMarkerPosLocal _pos;
	_marker setMarkerDirLocal _dir;
	_marker setMarkerTypeLocal _type;
	_marker setMarkerTextLocal _name;
};

private _markers = [];
private _units = [];
private _sideColor = [blufor, true] call BIS_fnc_sideColor;
private _teamColor = [independent, true] call BIS_fnc_sideColor;

while {true} do {
	_units = allUnits select {
		if (isPlayer _x || _showAI) then {
			if ((side _x) isEqualTo (playerSide)) then {
				true
			};
		};
	};

	if (visibleGPS || visibleMap) then {
		{
			private _marker = format ["Unit%1", _x];
			private _veh = {isPlayer _x || _showAI} count (crew vehicle _x);

			if !(_marker in _markers) then {
				_markers pushBack (createMarkerLocal [_marker, visiblePositionASL _x]);
				_marker setMarkerAlphaLocal 0.75;
				_marker setMarkerSizeLocal [0.8, 0.8];
				if ((group _x) isEqualTo (group player)) then {
					_marker setMarkerColorLocal _teamColor;
				} else {
					_marker setMarkerColorLocal _sideColor;
				}
			};
			[
				[
					_marker,
					(visiblePositionASL _x),
					(getDirVisual _x),
					[
						["Empty", "mil_box"] select ((((crew vehicle _x) select {isPlayer _x || _showAI}) select 0) isEqualTo _x),
						"mil_triangle"
					] select (isNull objectParent _x || {(objectParent _x isKindOf "ParachuteBase")}),
					[
						format ["%1: %2 %3", getText (configFile >> "cfgVehicles" >> typeOf vehicle _x >> "displayname"), name _x, format [["+%1",""] select (_veh < 2), _veh -1]],
						name _x
					] select (isNull objectParent _x || {(objectParent _x isKindOf "ParachuteBase")})
				],
				[
					_marker,
					(visiblePositionASL _x),
					0,
					"Empty",
					name _x
				]
			] select !(alive _x) call _fnc_updtMkr;

			if !(alive _x) then {
				_units deleteAt _forEachIndex;
			};
		} forEach (_units select {!isNull _x});
	} else {
		{deleteMarkerLocal _x; true} count _markers;
		_markers = [];
	};
	uiSleep 0.03;
};
