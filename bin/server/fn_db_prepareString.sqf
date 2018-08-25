scriptName "fn_db_prepareString";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_db_prepareString.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_db_prepareString.sqf"

// Parameters
private _toDatabase = param[0,false,[false]];
private _string	= param[1,"",[""]];

// Exceptions
if (_string == "") then {""};
if (!isServer) exitWith {};

// Code
private _stringArray = [];

if (_toDatabase) then {
	_stringArray = toArray _string;
	private _newString = [];
	{
		switch (_x) do
		{
			//case 34:
			//{
			//	_newString pushBack 94;
			//};
			case 92:
			{
				_newString pushBack 92;
				_newString pushBack 92; // Escape char
			};
			default
			{
				_newString pushBack _x;
			};
		};
	} forEach _stringArray;

	_stringArray = _newString;
} else {
	//_stringArray = toArray _string;
	//{
	//	if (_x == 94) then {
	//		_stringArray set[_forEachIndex,34];
	//	};
	//} forEach _stringArray;
};

(toString _stringArray)
