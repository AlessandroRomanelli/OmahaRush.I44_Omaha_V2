scriptName "fn_populateAdminParams.sqf";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_populateAdminParams.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_populateAdminParams.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

params [["_display", displayNull, [displayNull]]];

private _config = "true" configClasses (missionConfigFile >> "ServerParams");
private _params = [];

{
	_params pushBack [getText(_x >> "title"), getArray(_x >> "values"), getArray(_x >> "texts"), configName _x];
} forEach _config;

{
	_x params [["_title", "", [""]], ["_values", [], [[]]], ["_texts", [], [[]]], ["_varName", "", [""]]];
	if (count _texts == 0) then {
		_texts = _values;
	};
	private _titleCtrl = _display displayCtrl (1000+_forEachIndex);
	private _selectCtrl = _display displayCtrl (1100+_forEachIndex);
	_titleCtrl ctrlSetText _title;
	lbClear _selectCtrl;
	private _idx = 0;
	private _current = missionNamespace getVariable [format["sv_setting_%1", _varName], nil];
	for "_i" from 0 to ((count _values) - 1) do {
		_selectCtrl lbAdd (str (_texts select _i));
		_selectCtrl lbSetValue [lbSize _selectCtrl - 1, _values select _i];
		_selectCtrl lbSetData [lbSize _selectCtrl - 1, _varName];
		if (_current == _values select _i) then {
			_idx = _i;
		};
	};
	_selectCtrl lbSetCurSel _idx;
} forEach _params;

for "_i" from count _params to 25 do {
	private _titleCtrl = _display displayCtrl (1000+_i);
	private _selectCtrl = _display displayCtrl (1100+_i);
	_titleCtrl ctrlShow false;
	_selectCtrl ctrlShow false;
};
