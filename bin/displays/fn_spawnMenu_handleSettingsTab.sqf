scriptName "fn_spawnMenu_handleSettingsTab";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_handleSettingsTab.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_spawnMenu_handleSettingsTab.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

disableSerialization;

systemChat "Open user settings";

// Create dialog
createDialog "rr_user_settings";

// Get dialog and controls
private _d = findDisplay 2000;

true;
