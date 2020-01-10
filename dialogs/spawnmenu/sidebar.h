#include "constants.h"

class Sidebar_Container: RscControlsGroupNoScrollbars
{
	idc = -1;
	x = safeZoneX + safeZoneW - SIDEBAR_WIDTH;
	y = safeZoneY + safeZoneH * 0;
	w = SIDEBAR_WIDTH;
	h = safeZoneH * 1;
	onLoad = "uiNamespace setVariable ['rr_spawnmenu_sidebar', _this select 0]";
	font = "PuristaMedium";
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

	class WWR_Sidebar_Item: RscButtonMenu
	{
		idc = -1;
		size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
		color[] = {0,0,0,1};
		text = ""; //--- ToDo: Localize;
		x = 0;
		y = 0;
		w = SIDEBAR_WIDTH - 2 * SIDEBAR_BORDER;
		h = SIDEBAR_ITEM_HEIGHT;
		colorText[] = {0,0,0,1};
		colorBackground[] = PRIMARY_COLOR;
		colorDisabled[] = DISABLED_COLOR;
		colorBackgroundDisabled[] = DARK_COLOR;
	};

	class WWR_Sidebar_Header: RscText
	{
	  idc = -1;
	  text = ""; //--- ToDo: Localize;
	  x = 0;
	  y = 0;
	  w = SIDEBAR_CONTENT_WIDTH;
	  h = SIDEBAR_ITEM_HEIGHT / 2;
	  colorBackground[] = PRIMARY_COLOR;
	};

	class WWR_Sidebar_Listbox: RscListBox {
		idc = -1;
		sizeEx = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
		rowHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
		wholeHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
		x = SIDEBAR_BORDER;
		y = 0
		w = SIDEBAR_CONTENT_WIDTH;
		h = SIDEBAR_ITEM_HEIGHT * 3;
		colorBackground[] = DARK_COLOR;
		colorSelect[] = {1, 1, 1, 1};
		colorText[] = {1, 1, 1, 0.5};
		colorSelect2[] = {1, 1, 1, 1};
		colorSelectBackground[] = COLOR_BLACK(0.25);
		colorSelectBackground2[] = COLOR_BLACK(0.35);
	};

	class Controls {
		class AbortButton: WWR_Sidebar_Item
		{
		  action = "[] call client_fnc_saveStatistics; endMission 'MatchLeft';";
		  idc = 1000;
		  text = "QUIT TO LOBBY"; //--- ToDo: Localize;
		  x = SIDEBAR_BORDER;
		  y = SIDEBAR_BORDER;
		};

		class admin_area: WWR_Sidebar_Item
		{
			action = "[] call client_fnc_displayAdminArea";
			idc = 1301;
			text = "ADMIN AREA"; //--- ToDo: Localize;
			x = SIDEBAR_BORDER;
			y = 2 * SIDEBAR_BORDER + SIDEBAR_ITEM_HEIGHT;
		};

		class side_switch: RscControlsGroupNoScrollbars {
			idc = -1;
			x = SIDEBAR_BORDER;
			y = 4 * SIDEBAR_BORDER + 3 * SIDEBAR_ITEM_HEIGHT;
			w = SIDEBAR_CONTENT_WIDTH;
			h = SIDEBAR_ITEM_HEIGHT;
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			class Controls {
				class switch_side: RscButtonMenu
				{
					idc = 105;
					size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
					font = "PuristaBold";
					color[] = {0,0,0,1};
					action = "[] spawn client_fnc_sideSwitch;";
					text = "SWITCH SIDE"; //--- ToDo: Localize;
					x = 0;
					y = 0;
					w = SIDEBAR_CONTENT_WIDTH * 3/4 - SIDEBAR_BORDER;
					h = SIDEBAR_ITEM_HEIGHT;
					colorText[] = {0,0,0,1};
					colorBackground[] = PRIMARY_COLOR;
					colorDisabled[] = DISABLED_COLOR;
					colorBackgroundDisabled[] = DARK_COLOR;
				};
				class enemy_flag: RscPicture
				{
					idc = 1205;
					text = "";
					x = SIDEBAR_CONTENT_WIDTH * 3/4;
					y = 0;
					w = SIDEBAR_CONTENT_WIDTH * 1/4;
					h = SIDEBAR_ITEM_HEIGHT;
				};
			};
		};

		class GroupsButton: WWR_Sidebar_Item
		{
			action = "(findDisplay 5000) createDisplay 'RscDisplayDynamicGroups'";
			idc = 100;
			text = "VIEW GROUPS"; //--- ToDo: Localize;
			x = SIDEBAR_BORDER;
			y = 5 * SIDEBAR_BORDER + 4 * SIDEBAR_ITEM_HEIGHT;
		};

		class ClassHeader: WWR_Sidebar_Header
		{
		  text = "CLASS SELECTION"; //--- ToDo: Localize;
		  x = SIDEBAR_BORDER;
		  y = 7 * SIDEBAR_BORDER + 6 * SIDEBAR_ITEM_HEIGHT;
		};

		class Classes: WWR_Sidebar_Listbox
		{
			idc = 300;
			y = 7 * SIDEBAR_BORDER + 6.5 * SIDEBAR_ITEM_HEIGHT;
			h = SIDEBAR_ITEM_HEIGHT * 3;
			onLBSelChanged = "_this call displays_fnc_spawnMenu_handleClassSelect";
		};
		/*
		class customizeClassButton: RscButtonMenu
		{
			idc = 301;
			style = "0x02 + 0x0c";
			action = "[] call displays_fnc_spawnMenu_handleClassCustomize";
			text = "CUSTOMIZE CLASS ABILITIES"; //--- ToDo: Localize;
			x = SIDEBAR_BORDER;
			y = 7 * SIDEBAR_BORDER + 9.5 * SIDEBAR_ITEM_HEIGHT;
			w = SIDEBAR_CONTENT_WIDTH;
			h = SIDEBAR_ITEM_HEIGHT / 2;
			colorText[] = {1,1,1,1};
			colorBackground[] = COLOR_BLACK(0.2);
		}; */

		class SpawnHeader: WWR_Sidebar_Header
		{
			text = "SPAWN POINTS"; //--- ToDo: Localize;
			x = SIDEBAR_BORDER;
			y = 9 * SIDEBAR_BORDER + 11 * SIDEBAR_ITEM_HEIGHT;
		};

		class Spawnpoints: WWR_Sidebar_Listbox
		{
			idc = 8;
			y = 9 * SIDEBAR_BORDER + 11.5 * SIDEBAR_ITEM_HEIGHT;
			h = SIDEBAR_ITEM_HEIGHT * 3;
			onLBSelChanged = "_this call displays_fnc_spawnMenu_handleSpawnSelect;";
		};

		class VehiclesHeader: WWR_Sidebar_Header
		{
			text = "VEHICLES"; //--- ToDo: Localize;
			x = SIDEBAR_BORDER;
			y = 9 * SIDEBAR_BORDER + 14.5 * SIDEBAR_ITEM_HEIGHT;
		};

		class Vehicles: WWR_Sidebar_Listbox
		{
			idc = 9;
			y = 9 * SIDEBAR_BORDER + 15.0 * SIDEBAR_ITEM_HEIGHT;
			h = SIDEBAR_ITEM_HEIGHT * 4;
			onLBSelChanged = "_this call displays_fnc_spawnMenu_handleSpawnSelect;";
		};

		class Deploy: RscControlsGroupNoScrollbars {
			idc = -1;
			x = SIDEBAR_BORDER;
			y = 10 * SIDEBAR_BORDER + 19.0 * SIDEBAR_ITEM_HEIGHT;
			w = SIDEBAR_CONTENT_WIDTH;
			h = SIDEBAR_ITEM_HEIGHT * 2;

			class Controls {
				class deploybutton: RscButtonMenu
				{
					action = "[] call client_fnc_spawnMenu_getClassAndSpawn";
					idc = 302;
					color[] = {0,0,0,1};
					font = "PuristaBold";
					size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
					text = ""; //--- ToDo: Localize;
					x = 0;
					y = 0;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT * 2;
					colorText[] = {0,0,0,1};
					colorDisabled[] = DISABLED_COLOR;
					colorBackground[] = PRIMARY_COLOR;
					colorBackgroundDisabled[] = COLOR_BLACK(0.2);
				};
				class button_text: RscText {
					idc = 303;
					style = 2 + 192;
					color[] = {0,0,0,1};
					font = "PuristaLight";
					size = "2.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
					sizeEx = SIDEBAR_CONTENT_WIDTH * 0.2;
					shadow = 0;
					text = "DEPLOY"; //--- ToDo: Localize;
					x = 0;
					y = 0;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT * 1.9;
				};
				class timeLeft: RscStructuredText
				{
					text = "";
					idc = 304;
					size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
					style = 1;
					x = 0;
					y = SIDEBAR_ITEM_HEIGHT + SIDEBAR_ITEM_HEIGHT / 4;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT;
					colorText[] = {1,1,1,1};
					colorBackground[] = {0,0,0,0};

					class Attributes {
						size = 0.8;
						font = "PuristaLight";
						color = "#848a8f";
						align = "center";
						valign = "middle";
						shadow = 0;
					};
				};
			};
		};
	};
};
