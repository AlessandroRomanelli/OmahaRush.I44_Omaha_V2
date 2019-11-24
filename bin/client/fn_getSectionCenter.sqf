scriptName "fn_getSectionCenter";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_getSectionCenter.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getSectionCenter.sqf"

private _pos1 = param[0,[],[[]]];
private _pos2 = param[1,[],[[]]];

params [	["_pos1", [], [[]] ], ["_pos2", [], [[]] ]	];

(_pos1 vectorAdd _pos2) vectorMultiply 0.5;
