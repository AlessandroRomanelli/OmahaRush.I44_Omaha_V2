scriptName "fn_giveStatistics";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_giveStatistics.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_giveStatistics.sqf"
if (isServer && !hasInterface) exitWith {};

private _playerData = param[0,[],[[]]];

// Set vars
cl_total_kills = _playerData select 0;
cl_total_deaths = _playerData select 1;
cl_exp_assault = (_playerData select 2) select 0;
cl_exp_medic =( _playerData select 2) select 1;
cl_exp_engineer = (_playerData select 2) select 2;
cl_exp_support = (_playerData select 2) select 3;
cl_exp_recon = (_playerData select 2) select 4;
cl_equipConfigurations = _playerData select 3;
cl_equipClassnames = _playerData select 4;
