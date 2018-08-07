scriptName "fn_checkClassRestriction";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_checkClassRestriction.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_checkClassRestriction.sqf"
if (isServer && !hasInterface) exitWith {};

_class = param[0,"medic",[""]];
_isRestricted = false;

_classRestrictionEnabled = [false, true] select ("ClassLimits" call bis_fnc_getParamValue);
if (!_classRestrictionEnabled || !(_class in ["support", "engineer", "recon"])) exitWith {false};

_classLimitException = {
	params [["_class", "support", ["support"]], ["_currentClassPlayers", 0, [0]]];
	_message = format["THERE ARE ALREADY %2 %1 PLAYERS AT THE MOMENT <br />SELECT ANOTHER CLASS", toUpper _class, _currentClassPlayers];
	if (_currentClassPlayers isEqualTo 1) then {
    _message = format["THERE IS ALREADY A %1 PLAYER AT THE MOMENT <br />SELECT ANOTHER CLASS", toUpper _class];
	};
	if (_currentClassPlayers isEqualTo 0) then {
		_message = format["THE %1 CLASS IS NOT AVAILABLE <br />PLEASE SELECT ANOTHER CLASS AND TRY AGAIN LATER", toUpper _class];
	};
	[_message] spawn client_fnc_displayError;
};

_sameSidePlayers = allPlayers select {if (playerSide isEqualTo (side _x)) then {true}};

_sameClassPlayers = count (_sameSidePlayers select {if (_x getVariable ["class", "medic"] isEqualTo _class) then {true}});
_classLimit = ((format ["ClassLimits_%1", _class]) call bis_fnc_getParamValue)/10;
_newClassMember = if !(player getVariable ["class", "medic"] isEqualTo _class) then {1} else {0};

if (_classLimit != 1 && {((_sameClassPlayers + _newClassMember)/(count _sameSidePlayers)) >= _classLimit}) then {
  [_class, _sameClassPlayers] spawn _classLimitException;
  _isRestricted = true;
};

_isRestricted
