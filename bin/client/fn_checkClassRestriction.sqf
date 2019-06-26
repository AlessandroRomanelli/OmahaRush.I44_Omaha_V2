scriptName "fn_checkClassRestriction";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_checkClassRestriction.sqf

  You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_checkClassRestriction.sqf"
if (isServer && !hasInterface) exitWith {};

private _class = param[0,"medic",[""]];
private _isRestricted = false;

// Check if the mission parameters restrict classes
private _classRestrictionEnabled = (["ClassLimits", 1] call BIS_fnc_getParamValue) isEqualTo 1;
// If the class restriction is OFF or the class is not restricted, we got nothing to do!
if (!_classRestrictionEnabled || !(_class in ["support", "engineer", "recon"])) exitWith {false};

// Inline function to improve readability: displays the exception to the user
private _classLimitException = {
	params [["_class", "support", ["support"]], ["_currentClassPlayers", 0, [0]]];
	private _message = format["THERE ARE ALREADY %2 %1 PLAYERS AT THE MOMENT <br />SELECT ANOTHER CLASS", toUpper _class, _currentClassPlayers];
	if (_currentClassPlayers isEqualTo 1) then {
    _message = format["THERE IS ALREADY A %1 PLAYER AT THE MOMENT <br />SELECT ANOTHER CLASS", toUpper _class];
	};
	if (_currentClassPlayers isEqualTo 0) then {
		_message = format["THE %1 CLASS IS NOT AVAILABLE <br />PLEASE SELECT ANOTHER CLASS AND TRY AGAIN LATER", toUpper _class];
	};
	[_message] call client_fnc_displayError;
	true
};

// Count how many players are on our side
private _sameSidePlayers = allPlayers select {if (playerSide isEqualTo (_x getVariable ["side", sideUnknown])) then {true}};

// Count how many players are playing with our same class
private _sameClassPlayers = {if (_x getVariable ["class", "medic"] isEqualTo _class) then {true}} count _sameSidePlayers;
// Get how much percentage of our side should be present as the given class (0 --> 1)
private _classLimit = ((format ["ClassLimits_%1", _class]) call bis_fnc_getParamValue)/10;
// Check if the player already had spawned with the same class (thus already counted) or not
private _newClassMember = if !(player getVariable ["class", "medic"] isEqualTo _class) then {1} else {0};

// If the ratio between players with the same restricted class and the players on the same side is beyond the limit, restrict
if (_classLimit != 1 && {((_sameClassPlayers + _newClassMember)/(count allPlayers)) > _classLimit}) then {
  [_class, _sameClassPlayers] call _classLimitException;
  _isRestricted = true;
};

_isRestricted
