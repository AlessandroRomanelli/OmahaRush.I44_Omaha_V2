scriptName "fn_displayAds.sqf";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_checkClassRestriction.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayAds.sqf"
if (isServer && !hasInterface) exitWith {};

private _dUp = ((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1);
private _dDown = ((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0);
while {sv_gameStatus == 2} do {
	14 cutRsc ["rr_bottomTS3", "PLAIN", 1];
	sleep 0.5;
	switch ((floor diag_tickTime) % 5) do {
		case (0): {
			_dUp ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>PLAY WITH US, JOIN OUR <t color='#990000'>TEAMSPEAK</t></t>";
			_dDown ctrlSetStructuredText parseText "<t size='2' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>ts3.</t>no4commando.com</t>";
		};
		case (1): {
			_dUp ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>Brought to you by:</t>";
			_dDown ctrlSetStructuredText parseText "<t size='2' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>NO. 4 CDO</t>: WW2 MILSIM UNIT</t>";
		};
		case (2): {
			_dUp ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>Learn more about the commandos:</t>";
			_dDown ctrlSetStructuredText parseText "<t size='2' color='#FFFFFF' shadow='2' align='center'>WWW.<t color='#990000'>NO4COMMANDO</t>.COM</t>";		};
		case (3): {
			_dUp ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>A mission developed by:</t>";
			_dDown ctrlSetStructuredText parseText "<t size='1.5' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>SSGT.</t> A. ROMAN [NO.4]</t>";		};
		case (4): {
			_dUp ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>From the original mission:</t>";
			_dDown ctrlSetStructuredText parseText "<t size='1.5' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>RushRedux</t> by (OPTiX)</t>";		};
	};
	sleep 14.5;
	14 cutFadeout 1;
	sleep 1;
};

cl_adsDisplay = nil;
