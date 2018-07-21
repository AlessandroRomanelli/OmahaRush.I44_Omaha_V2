while {sv_gameStatus == 2} do {
	14 cutRsc ["rr_bottomTS3", "PLAIN", 1];
	sleep 0.5;
	switch ((floor diag_tickTime) % 5) do {
		case (0): {
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>PLAY WITH US, JOIN OUR <t color='#990000'>TEAMSPEAK</t></t>";
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='2' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>ts3.</t>no4commando.com</t>";
		};
		case (1): {
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>Brought to you by:</t>";
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='2' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>NO. 4 CDO</t>: WW2 MILSIM UNIT</t>";
		};
		case (2): {
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>Learn more about the commandos:</t>";
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='2' color='#FFFFFF' shadow='2' align='center'>WWW.<t color='#990000'>NO4COMMANDO</t>.COM</t>";		};
		case (3): {
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>A mission developed by:</t>";
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='1.5' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>SSGT.</t> A. ROMAN [NO.4]</t>";		};
		case (4): {
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText "<t size='1' color='#FFFFFF' shadow='2' align='center'>From the original mission:</t>";
			((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='1.5' color='#FFFFFF' shadow='2' align='center'><t color='#990000'>RushRedux</t> by (OPTiX)</t>";		};
	};
	sleep 14.5;
	14 cutFadeout 1;
	sleep 1;
};

cl_adsDisplay = nil;
