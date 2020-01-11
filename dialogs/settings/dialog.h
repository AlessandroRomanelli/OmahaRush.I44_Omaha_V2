#define SETTINGS_WIDTH safeZoneW * 0.4
#define SETTINGS_HEIGHT safeZoneH * 0.3
#define SETTINGS_HEADER_HEIGHT safeZoneH * 0.0225
#define SETTINGS_MARGIN safeZoneW * 0.01

#include "..\globals.h"

class rr_user_settings {
	idd = 2000;
	movingEnable = 0;
	enableSimulation = 1;
	duration = 999999;

	class WWR_Slider: RscControlsGroupNoScrollbars {
		idc = -1;
		x = SETTINGS_MARGIN;
		y = 0;
		w = SETTINGS_WIDTH - SETTINGS_MARGIN * 2;
		h = SETTINGS_HEADER_HEIGHT * 2;

		class controls {
			class OptionName: RscText {
				idc = -1;
				x = 0;
				y = 0;
				w = SETTINGS_WIDTH - SETTINGS_MARGIN * 2;
				h = SETTINGS_HEADER_HEIGHT;
				text = "VIEW DISTANCE";
				colorText[] = COLOR_BRIGHT(1.0);
			};
			class Slider: RscXSliderH {
				idc = -1;
				x = 0;
				y = SETTINGS_HEADER_HEIGHT;
				w = (SETTINGS_WIDTH * 0.75) - SETTINGS_MARGIN;
				h = SETTINGS_HEADER_HEIGHT;
			};
			class OptionValue: RscText {
				idc = -1;
				x = SETTINGS_WIDTH * 0.75;
				y = SETTINGS_HEADER_HEIGHT;
				w = (SETTINGS_WIDTH * 0.25) - SETTINGS_MARGIN;
				h = SETTINGS_HEADER_HEIGHT;
				text = "1000";
				shadow = 0;
			};
		};
	};

	class controls {
		class Container: RscControlsGroupNoScrollbars {
			x = safeZoneX + safeZoneW / 2 - SETTINGS_WIDTH / 2;
			y = safeZoneY + safeZoneH / 2 - SETTINGS_HEIGHT / 2;
			w = SETTINGS_WIDTH;
			h = SETTINGS_HEIGHT + (0.022 * safezoneH);

			class controls {
				class Background: RscText {
					idc = -1;
					x = 0;
					y = 0;
					w = SETTINGS_WIDTH;
					h = SETTINGS_HEIGHT;
					colorBackground[] = DARK_COLOR;
				};
				class Header: RscText {
					idc = -1;
					x = 0;
					y = 0;
					w = SETTINGS_WIDTH;
					h = SETTINGS_HEADER_HEIGHT * 2;
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25);
					colorBackground[] = COLOR_PRIMARY(1.0);
					colorText[] = COLOR_BRIGHT(1.0);
					text = "  USER SETTINGS";
					shadow = 0;
				};

				class ViewDistance: WWR_Slider {
					y = SETTINGS_HEADER_HEIGHT * 3;
					class controls: controls {
						class OptionName: OptionName {
							text = "VIEW DISTANCE:";
						};
						class Slider: Slider {
							idc = 100;
							onLoad = "(_this select 0) sliderSetRange [500, 12000];(_this select 0) sliderSetPosition (viewDistance);";
							onSliderPosChanged = "setViewDistance (_this select 1);((findDisplay 2000) displayCtrl 101) ctrlSetText (str (round (_this select 1)) + 'm');((findDisplay 2000) displayCtrl 102) sliderSetRange [500, _this select 1];";
						};
						class OptionValue: OptionValue {
							idc = 101;
							onLoad = "(_this select 0) ctrlSetText (str viewDistance + 'm');"
						};
					};
				};

				class ObjectDistance: WWR_Slider {
					y = SETTINGS_HEADER_HEIGHT * 6;
					class controls: controls {
						class OptionName: OptionName {
							text = "OBJECT DISTANCE:";
						};
						class Slider: Slider {
							idc = 102;
							onLoad = "(_this select 0) sliderSetRange [500, viewDistance];(_this select 0) sliderSetPosition (getObjectViewDistance select 0);"
							onSliderPosChanged = "setObjectViewDistance [_this select 1, getObjectViewDistance select 1];((findDisplay 2000) displayCtrl 103) ctrlSetText (str (round (_this select 1)) + 'm');";
						};
						class OptionValue: OptionValue {
							idc = 103;
							onLoad = "(_this select 0) ctrlSetText (str (getObjectViewDistance select 0) + 'm')";
						};
					};
				};

				class ShadowDistance: WWR_Slider {
					y = SETTINGS_HEADER_HEIGHT * 9;
					class controls: controls {
						class OptionName: OptionName {
							text = "SHADOW DISTANCE:";
						};
						class Slider: Slider {
							idc = 104;
							onLoad = "(_this select 0) sliderSetRange [0, 200];(_this select 0) sliderSetPosition (getObjectViewDistance select 1)";
							onSliderPosChanged = "setObjectViewDistance [getObjectViewDistance select 0, _this select 1];((findDisplay 2000) displayCtrl 105) ctrlSetText (str (round (_this select 1)) + 'm');";
						};
						class OptionValue: OptionValue {
							idc = 105;
							onLoad = "(_this select 0) ctrlSetText (str (getObjectViewDistance select 1) + 'm')";
						};
					};
				};
				class Return: RscButtonMenu
				{
					idc = 1;
					text = "RETURN"; //--- ToDo: Localize;
					x = SETTINGS_WIDTH - (0.0825 * safezoneW);
					y = SETTINGS_HEIGHT;
					w = 0.0825 * safezoneW;
					h = 0.022 * safezoneH;
					colorBackground[] = DARK_COLOR;
				};
			};
		};

	};
};
