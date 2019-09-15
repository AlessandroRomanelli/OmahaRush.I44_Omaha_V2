scriptName "fn_spawnModal";
/*--------------------------------------------------------------------
	Author: A.Roman (ofpectag: RMN)
    File: fn_spawnModal.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnModal.sqf"
if (isServer && !hasInterface) exitWith {};

params [["_title", "", [""]], ["_description", "", [""]], ["_callback", {}, [{}]]];

disableSerialization;

createDialog "rr_modal";

private _modal = findDisplay 8000;
private _titleCtrl = _modal displayCtrl 1002;
private _descriptionCtrl = _modal displayCtrl 1003;

_titleCtrl ctrlSetText _title;
_descriptionCtrl ctrlSetText _description;
uiNamespace setVariable ["rr_modal_callback", _callback];
