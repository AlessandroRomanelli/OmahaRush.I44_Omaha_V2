scriptName "fn_populateScoreboard";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_populateScoreboard.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_populateScoreboard.sqf"

if (isServer && isDedicated) exitWith {};

params [["_d", displayNull, [displayNull]]];

if (isNull _d) exitWith {};

private _allInfoAttackers = [];
private _allInfoDefenders = [];

// Fill data from objects
{
	private _name = _x getVariable ["name", name _x];
	private _classInitial = [_x getVariable ["class", ""]] call {
		private _class = param [0, "", [""]];
		if (_class isEqualTo "medic") exitWith {"M"};
		if (_class isEqualTo "assault") exitWith {"A"};
		if (_class isEqualTo "engineer") exitWith {"E"};
		if (_class isEqualTo "support") exitWith {"S"};
		if (_class isEqualTo "recon") exitWith {"R"};
		"";
	};
	if (_x getVariable ["side", side _x] != civilian) then {
		if ((_x getVariable ["side", side _x]) == WEST) then {
			_allInfoDefenders pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name, _classInitial];
		} else {
			_allInfoAttackers pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name, _classInitial];
		};
	};
} forEach AllPlayers;

// Sort data
_allInfoAttackers sort false;
_allInfoDefenders sort false;

private _data = if ((player getVariable ["side", side player]) isEqualTo EAST) then {
	[" ATTACKERS (%1)", " DEFENDERS (%1)", _allInfoAttackers, _allInfoDefenders]
} else {
	[" DEFENDERS (%1)", "ATTACKERS (%1)", _allInfoDefenders, _allInfoAttackers]
};
// Get controls

private _friends = (side player) countSide allPlayers;
private _enemies = ([EAST,WEST] select ((side player) == EAST)) countSide allPlayers;
(_d displayCtrl 0) ctrlSetStructuredText (parseText "<t shadow='2'>SCOREBOARD</t>");
(_d displayCtrl 1001) ctrlSetStructuredText (parseText (format[_data select 0, _friends]));
(_d displayCtrl 1002) ctrlSetStructuredText (parseText (format[_data select 1, _enemies]));
private _listFriendlies = (_d displayCtrl 1);
private _listEnemies = (_d displayCtrl 2);
{_x lnbAddRow ["","NAME","K","D","SCORE",""]} forEach [_listFriendlies, _listEnemies];

// Fill scoreboards
{
/* _listDefenders lnbAddRow [str _nDefender, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)]; */
_listFriendlies lnbAddRow [(_x select 4), (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
} forEach (_data select 2);
{
	_listEnemies lnbAddRow [(_x select 4), (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
} forEach (_data select 3);

true
