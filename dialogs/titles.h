class default
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0;

	class controlsBackground {};

	class controls
	{};
};

class rr_spawn
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=1;
	fadein=0;
	duration = 1;

	class controlsBackground {};

	class controls
	{
		class blackbackground: RscText
		{
			idc = -1;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,2};
		};
	};
};

class rr_black
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999;
	onLoad = "uiNamespace setVariable ['rr_black',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class blackbackground: RscText
		{
			idc = 0;
			x = 1 * safezoneW + safezoneX;
			y = 1 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,2};
		};
	};
};

class rr_timer
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=2;
	duration = 9999999;
	onLoad = "uiNamespace setVariable ['rr_timer',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.245 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.088 * safezoneH;
		};

		/* SCOREBOARD */
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.247962 * safezoneW + safezoneX;
			y = 0.34534 * safezoneH + safezoneY;
			w = 0.499125 * safezoneW;
			h = 0.462 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscText_1001: RscText
		{
			idc = -1;
			text = " DEFENDERS"; //--- ToDo: Localize;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.18,0.51,0.95};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			text = " ATTACKERS"; //--- ToDo: Localize;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4,0,0,1};
		};
		class RscText_10023: RscText
		{
			idc = -1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
			shadow = 2;
		};
		class RscText_10024: RscText
		{
			idc = -1;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
			shadow = 2;
		};
		class RscText_1003: RscListNBox
		{
			idc = 1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = {0.18,0.51,0.95};
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
		class RscText_1004: RscListNBox
		{
			idc = 2;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = {0.96,0.65,0.12,0.8};
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
	};
};

class rr_scoreboard
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.1;
	duration = 9999999;
	onLoad = "uiNamespace setVariable ['rr_scoreboard',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			text = "";
			size = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.245 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "PuristaMedium";
				color = "#FFFFFF";
				align = "center";
				valign = "middle";
			};
		};

		/* SCOREBOARD */
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.247962 * safezoneW + safezoneX;
			y = 0.34534 * safezoneH + safezoneY;
			w = 0.499125 * safezoneW;
			h = 0.462 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscText_1001: RscText
		{
			idc = -1;
			text = " DEFENDERS"; //--- ToDo: Localize;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.18,0.51,0.95};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			text = " ATTACKERS"; //--- ToDo: Localize;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4,0,0,1};
		};
		class RscText_10023: RscText
		{
			idc = -1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
			shadow = 2;
		};
		class RscText_10024: RscText
		{
			idc = -1;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
			shadow = 2;
		};
		class RscText_1003: RscListNBox
		{
			idc = 1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = {0.18,0.51,0.95};
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
		class RscText_1004: RscListNBox
		{
			idc = 2;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = {0.96,0.65,0.12,0.8};
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
	};
};

class rr_restrictedArea
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.1;
	onLoad = "uiNamespace setVariable ['rr_restrictedArea',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.298905 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = {1,0,0,0.1};
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.308 * safezoneH;
			colorBackground[] = {1,0,0,0.15};
		};
		class text: RscStructuredText
		{
			idc = 0;
			text = "<t size='3.5' color='#FFFFFF' shadow='2' align='center' font='PuristaBold'>TURN BACK</t><br/><t size='2' color='#FFFFFF' shadow='2' align='center'>YOU ARE LEAVING THE BATTLEFIELD</t>"; //--- ToDo: Localize;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			colorActive[] = {-1,-1,-1,0};
		};
		class timer: RscStructuredText
		{
			idc = 1101;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			colorActive[] = {-1,-1,-1,0};
		};
	};
};

class rr_restrictedAreaSpawn
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.1;
	onLoad = "uiNamespace setVariable ['rr_restrictedAreaSpawn',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.298905 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = {1,0,0,0.3};
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.308 * safezoneH;
			colorBackground[] = {1,0,0,0.3};
		};
		class text: RscStructuredText
		{
			idc = 0;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.286 * safezoneH;
			text = "<br/><t size='2' color='#FFFFFF' shadow='2' align='center' font='PuristaBold'>ENEMY HQ NEARBY</t><br/><t size='1.3' color='#FFFFFF' shadow='2' align='center'>LEAVE NOW OR YOU WILL BE KILLED</t>";
		};
	};
};

class rr_keyBindingHint
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.5;
	fadein=0;
	duration = 5;
	onLoad = "uiNamespace setVariable ['rr_keyBindingHint',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class text: RscStructuredText
		{
			idc = 0;
			text = "PRESS X TO DEPLOY COUNTERMEASURES"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};

class rr_keyBindingHintPermanent
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999;
	onLoad = "uiNamespace setVariable ['rr_keyBindingHintPermanent',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class text: RscStructuredText
		{
			idc = 0;
			text = "PRESS X TO DEPLOY COUNTERMEASURES"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};

class rr_topRightWarning
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999;
	onLoad = "uiNamespace setVariable ['rr_topRightWarning',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.645406 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};

class rr_bottomTS3
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.5;
	fadein=1;
	duration = 999999999999;
	onLoad = "uiNamespace setVariable ['rr_bottomTS3',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class bottom_line: RscStructuredText
		{
			idc = 0;
			text = ""; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class top_line: RscStructuredText
		{
			idc = 1;
			text = ""; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class rr_spawnPlayer
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.3;
	duration = 0.3;

	class controlsBackground {};

	class controls
	{
		class blackbackground: RscText
		{
			idc = -1;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,2};
		};
	};
};

class rr_weaponUnlockSingle
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.3;
	fadein=0.3;
	duration = 5;
	onLoad = "uiNamespace setVariable ['rr_weaponUnlockSingle',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.190625 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.613594 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1;
			x = 0.195781 * safezoneW + safezoneX;
			y = 0.153 * safezoneH + safezoneY;
			w = 0.608437 * safezoneW;
			h = 0.5 * safezoneH;
		};
	};
};

class rr_errorText
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.2;
	fadein=0.2;
	duration = 4;
	onLoad = "uiNamespace setVariable ['errorText',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.200937 * safezoneW + safezoneX;
			y = 0.363 * safezoneH + safezoneY;
			w = 0.598125 * safezoneW;
			h = 0.077 * safezoneH;
		};
	};
};

class rr_pointfeed
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999999999999999;
	onLoad = "uiNamespace setVariable ['rr_pointfeed',_this select 0];";

	class controlsBackground {};

	class controls {
		class mainfeed: RscStructuredText
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.715 * safezoneH + safezoneY;
			w = 0.355781 * safezoneW;
			h = 0.275 * safezoneH;
		};
		class totalpoints: RscStructuredText
		{
			idc = 1;
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};

class rr_objectivemessage
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.1;
	duration = 6;
	onLoad = "uiNamespace setVariable ['rr_objectivemessage',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = -0.00017268 * safezoneW + safezoneX;
			y = 0.0931436 * safezoneH + safezoneY;
			w = 1.00035 * safezoneW;
			h = 0.186934 * safezoneH;
		};
	};
};

class rr_hint
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.1;
	duration = 10;
	onLoad = "uiNamespace setVariable ['rr_hint',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = 0;
			x = 0.804219 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.143 * safezoneH;
			colorText[] = {1,1,1,0.8};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1001: RscStructuredText
		{
			idc = 1;
			text = "ATTACKER"; //--- ToDo: Localize;
			x = 0.809375 * safezoneW + safezoneX;
			y = 0.3306 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 2;
			text = "Attack and capture the objectives before your team runs out of tickets. Each death costs your team a ticket. Reviving restores a ticket."; //--- ToDo: Localize;
			x = 0.809375 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
	};
};


class rr_objective_gui
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=2;
	duration = 999999999999999;
	onLoad = "uiNamespace setVariable ['rr_objective_gui',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.391718 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class image: RscPicture
		{
			idc = 0;
			text = "pictures\objective_attacker.paa";
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.037125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1002: RscProgress
		{
			idc = 2;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {0,0,0,0};
    		colorBackground[] = {0,0,0,0};
   	 		colorBar[] = {0.96,0.65,0.12,1};
		};
		class time: RscStructuredText
		{
			idc = 4;
			text = "∞"; //--- ToDo: Localize;
			x = 0.391718 * safezoneW + safezoneX;
			y = 0.0255 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0264 * safezoneH;
		};
		class tickets: RscStructuredText
		{
			idc = 1;
			text = "150"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.0255 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0264 * safezoneH;
		};

		/* now also holds the killfeed */
		class RscStructuredText_Killfeed: RscStructuredText
		{
			idc = 10;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.366094 * safezoneW;
			h = 0.22 * safezoneH;
		};
	};
};


class rr_end_bestof
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999999;
	onLoad = "uiNamespace setVariable ['rr_end_bestof',_this select 0];";

	class controlsBackground {};

	class controls {
		class a: RscStructuredText
		{
			idc = 0;
			x = -1 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 1.00547 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class b: RscStructuredText
		{
			idc = 1;
			x = -1 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 1.00031 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class c: RscStructuredText
		{
			idc = 2;
			x = -1 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 1.00031 * safezoneW;
			h = 0.462 * safezoneH;
		};
	};
};

class rr_reloadingFlares {
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.3;
	fadein=0;
	duration = 999999999999999;
	onLoad = "uiNamespace setVariable ['rr_reloadingFlares',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.011 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1001: RscProgress
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.011 * safezoneH;
			colorFrame[] = {0,0,0,0};
    		colorBackground[] = {0,0,0,0};
   	 		colorBar[] = {0.96,0.65,0.12,1};
		};
	};
};



	class playerHUD {
		idd = 5100;
		name= "playerHUD";
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0;
		fadein=0;
		duration = 86400;
		onLoad="uiNamespace setVariable ['playerHUD',_this select 0]";

		class controlsBackground {};

		class controls {
			class RscText_1000: RscText
			{
				idc = -1;
				x = 0.863 * safezoneW + safezoneX;
				y = 0.896 * safezoneH + safezoneY;
				w = 0.135093 * safezoneW;
				h = 0.1012 * safezoneH;
				colorBackground[] = {0.12,0.14,0.16,0.8};
				shadow = 2;
			};
			class currentAmmo: RscText
			{
				idc = 100;
				text = "000"; //--- ToDo: Localize;
				x = 0.865064 * safezoneW + safezoneX;
				y = 0.894 * safezoneH + safezoneY;
				w = 0.0711564 * safezoneW;
				h = 0.055 * safezoneH;
				//sizeEx = 3.8 * GUI_GRID_H;
				sizeEx = "(1.75*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class reserveAmmo: RscText
			{
				idc = 101;
				text = "000"; //--- ToDo: Localize;
				x = 0.952714 * safezoneW + safezoneX;
				y = 0.8982 * safezoneH + safezoneY;
				w = 0.0515625 * safezoneW;
				h = 0.033 * safezoneH;
				//sizeEx = 1.9 * GUI_GRID_H;
				sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class RscText_1002: RscText
			{
				idc = 106;
				text = "/"; //--- ToDo: Localize;
				x = 0.940341 * safezoneW + safezoneX;
				y = 0.8982 * safezoneH + safezoneY;
				w = 0.0113438 * safezoneW;
				h = 0.0374 * safezoneH;
				//sizeEx = 1.5 * GUI_GRID_H;
				sizeEx = "(0.75*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class firemode: RscStructuredText
			{
				idc = 102;
				text = "[  AUTO  ]"; //--- ToDo: Localize;
				x = 0.93969 * safezoneW + safezoneX;
				y = 0.934852 * safezoneH + safezoneY;
				w = 0.0495002 * safezoneW;
				h = 0.0185 * safezoneH;
				//sizeEx = 1 * GUI_GRID_H;
				//sizeEx = /*safezoNeW/*/(1*0.04);
				shadow = 2;
			};
			class RscText_1004: RscText
			{
				idc = 103;
				text = "+"; //--- ToDo: Localize;
				x = 0.936218 * safezoneW + safezoneX;
				y = 0.9525 * safezoneH + safezoneY;
				w = 0.02 * safezoneW;
				h = 0.033 * safezoneH;
				//sizeEx = 3 * GUI_GRID_H;
				font = "PuristaBold";
				sizeEx = "(1.5*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class healthpoints: RscText
			{
				idc = 104;
				text = "000"; //--- ToDo: Localize;
				x = 0.952719 * safezoneW + safezoneX;
				y = 0.955 * safezoneH + safezoneY;
				w = 0.0515625 * safezoneW;
				h = 0.0352 * safezoneH;
				//sizeEx = 1.9 * GUI_GRID_H;
				sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class zeroing: RscText
			{
				idc = 105;
				text = "Gx01"; //--- ToDo: Localize;
				x = 0.86714 * safezoneW + safezoneX;
				y = 0.955 * safezoneH + safezoneY;
				w = 0.0615625 * safezoneW;
				h = 0.0352 * safezoneH;
				//sizeEx = 1.9 * GUI_GRID_H;
				sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class typeGranade: RscPicture
			{
				text = "";
				idc = 108;
				x = 0.83 * safezoneW + safezoneX;
				y = 0.94 * safezoneH + safezoneY;
				w = 0.0360937 * safezoneW;
				h = 0.066 * safezoneH;
			};
			class granades: RscText
			{
				idc = 107;
				text = "0"; //--- ToDo: Localize;
				x = 0.823282 * safezoneW + safezoneX;
				y = 0.946593 * safezoneH + safezoneY;
				w = 0.0154688 * safezoneW;
				h = 0.055 * safezoneH;
				/* sizeEx = 2 * GUI_GRID_H; */
				sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
				shadow = 2;
			};
			class RscText_1100: RscText
			{
			  idc = 1100;
			  text = ""; //--- ToDo: Localize;
			  x = 0.86575 * safezoneW + safezoneX;
			  y = 0.8704 * safezoneH + safezoneY;
			  w = 0.130208 * safezoneW;
			  h = 0.0224076 * safezoneH;
			  colorBackground[] = {-1,-1,-1,0};
				shadow = 2;
				font = "PuristaBold";
				align = "right";
			};
		};
	};







































	// HIT DIRECTION INDICATORS
	class cu
	{
		idd = -1;
		name= "cu";
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0;
		fadein=0;
		duration = 0.5;
		onLoad="uiNamespace setVariable ['cu',_this select 0]";

		class controlsBackground {};

		class controls {
			class RscText211000: RscPicture
			{
				idc = 1101;
				text = "pictures\cu.paa"; //--- ToDo: Localize;
				x = 0 * safezoneW + safezoneX;
				y = 0 * safezoneH + safezoneY;
				w = 1 * safezoneW;
				h = 1 * safezoneH;
			};
		};
	};

	class cr
	{
		idd = -1;
		name= "cr";
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0;
		fadein=0;
		duration = 0.5;
		onLoad="uiNamespace setVariable ['cr',_this select 0]";

		class controlsBackground {};

		class controls {
			class RscText211000: RscPicture
			{
				idc = 1101;
				text = "pictures\cr.paa"; //--- ToDo: Localize;
				x = 0 * safezoneW + safezoneX;
				y = 0 * safezoneH + safezoneY;
				w = 1 * safezoneW;
				h = 1 * safezoneH;
			};
		};
	};

	class cl
	{
		idd = -1;
		name= "cl";
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0;
		fadein=0;
		duration = 0.5;
		onLoad="uiNamespace setVariable ['cl',_this select 0]";

		class controlsBackground {};

		class controls {
			class RscText211000: RscPicture
			{
				idc = 1101;
				text = "pictures\cl.paa"; //--- ToDo: Localize;
				x = 0 * safezoneW + safezoneX;
				y = 0 * safezoneH + safezoneY;
				w = 1 * safezoneW;
				h = 1 * safezoneH;
			};
		};
	};

	class cd
	{
		idd = -1;
		name= "cd";
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0;
		fadein=0;
		duration = 0.5;
		onLoad="uiNamespace setVariable ['cd',_this select 0]";

		class controlsBackground {};

		class controls {
			class RscText211000: RscPicture
			{
				idc = 1101;
				text = "pictures\cd.paa"; //--- ToDo: Localize;
				x = 0 * safezoneW + safezoneX;
				y = 0 * safezoneH + safezoneY;
				w = 1 * safezoneW;
				h = 1 * safezoneH;
			};
		};
	};

	class hm_kill
	{
		idd = -1;
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0;
		fadein=0;
		duration = 0.3;

		class controlsBackground {};

		class controls {

			class RscText2131000: RscPicture
			{
				idc = -1;
				x = 0.455656 * safezoneW + safezoneX;
				y = 0.422 * safezoneH + safezoneY;
				w = 0.0886877 * safezoneW;
				h = 0.154 * safezoneH;
				text = "pictures\hm_kill.paa";
			};
		};
	};

	class hm_headshot
	{
		idd = -1;
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0.0;
		fadein=0;
		duration = 0.3;

		class controlsBackground {};

		class controls {

			class RscText2131000: RscPicture
			{
				idc = -1;
				x = 0.455656 * safezoneW + safezoneX;
				y = 0.422 * safezoneH + safezoneY;
				w = 0.0886877 * safezoneW;
				h = 0.154 * safezoneH;
				text = "pictures\hm_headshot.paa";
			};
		};
	};

	class hm_hit
	{
		idd = -1;
		movingEnable = 1;
		enableSimulation = 1;
		fadeout=0.0;
		fadein=0;
		duration = 0.3;

		class controlsBackground {};

		class controls {

			class RscText2131000: RscPicture
			{
				idc = -1;
				x = 0.455656 * safezoneW + safezoneX;
				y = 0.422 * safezoneH + safezoneY;
				w = 0.0886877 * safezoneW;
				h = 0.154 * safezoneH;
				text = "pictures\hm_hit.paa";
			};
		};
	};
