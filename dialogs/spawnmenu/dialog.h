#include "..\globals.h"
#include "constants.h"


class rr_spawnmenu {
    idd = 5000;
    movingEnable = 0;
    enableSimulation = 1;
    fadein=2;
    duration = 999999;
	onLoad = "params ['_display']; uiNamespace setVariable ['rr_spawnmenu', _display];"; // if (call BIS_fnc_admin != 2) then {(_display displayCtrl 1301) ctrlShow false}";
	onKeyDown = "private _h = false; if (_this select 1 == 1) then { _h = true; }; _h";
	class ControlsBackground
	{
		class Sidebar_Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW - SIDEBAR_WIDTH;
			y = safeZoneY;
			w = SIDEBAR_WIDTH;
			h = safeZoneH * 1;
			style = 0;
			text = "";
			colorBackground[] = COLOR_DARK(1.0);
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Sidebar_Background_Frame
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW - SIDEBAR_WIDTH;
			y = safeZoneY - safeZoneH * 0.00694444;
			w = SIDEBAR_WIDTH + 0.007;
			h = safeZoneH * 1.01215278;
			style = 64;
			text = "";
			colorBackground[] = {0.96, 0.65, 0.12, 1};
			colorText[] = {0.96, 0.65, 0.12, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
	};

    class controls {
		#include "sidebar.h"
		#include "loadout.h"
		class RscText_1000513: RscText
		{
			idc = 201;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001573: RscText
		{
			idc = 202;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = BRIGHT_COLOR;
		};
		class exppoints: RscText
		{
			idc = 103;
			text = ""; //--- ToDo: Localize;
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.19 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
		};
		class RscText_10032353462: RscText
		{
			idc = 203;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.8564 * safezoneH + safezoneY;
			w = 0.004125 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = BRIGHT_COLOR;
		};
		class RscText_100412213: RscText
		{
			idc = 204;
			x = 0.555688 * safezoneW + safezoneX;
			y = 0.8564 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1019635243: RscProgress
		{
			idc = 101;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {0,0,0,0};
    		colorBackground[] = {0,0,0,0};
   	 		colorBar[] = {0.96,0.65,0.12,1};
		};
		class weapontounlock: RscStructuredText
		{
			idc = 102;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.863 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.121 * safezoneH;
		};
	};
};
