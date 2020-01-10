#include "constants.h"

class rr_class_customization {
    idd = 8000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;

	class WWR_RscListBoxColumn: RscListBox {
		idc = -1;
		x = 0;
		y = CLASS_CUSTOMIZE_HEADER_HEIGHT;
		w = CLASS_CUSTOMIZE_COL_WIDTH;
		h = CLASS_CUSTOMIZE_HEIGHT - CLASS_CUSTOMIZE_HEADER_HEIGHT;
		sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
		rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
		wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
		shadow = 2;
		colorBackground[] = {0,0,0,0};
		colorSelect[] = {1, 1, 1, 1};
		colorText[] = {1, 1, 1, 0.5};
		colorSelect2[] = {1, 1, 1, 1};
		colorSelectBackground[] = PRIMARY_COLOR;
		colorSelectBackground2[] = PRIMARY_COLOR;
		onLBSelChanged = "[] call client_fnc_setUsedPerksForClass";
	};

	class WWR_RscTextHeaderColumn: RscText {
		idc = -1;
		x = 0;
		y = 0;
		w = CLASS_CUSTOMIZE_COL_WIDTH;
		h = CLASS_CUSTOMIZE_HEADER_HEIGHT;
		style = 192;
		text = "CLASS PERKS";
		colorText[] = COLOR_DARK(1.0);
		shadow = 0;
	};

    class controls {
		class Container: RscControlsGroupNoScrollbars {
			idc = -1;
			x = safeZoneX + safeZoneW / 2 - CLASS_CUSTOMIZE_WIDTH / 2;
			y = safeZoneY + safeZoneH / 2 - CLASS_CUSTOMIZE_HEIGHT / 2;
			w = CLASS_CUSTOMIZE_WIDTH;
			h = CLASS_CUSTOMIZE_HEIGHT;
			class controls {
				class Header_Background: RscText {
					idc = -1;
					x = 0;
					y = 0;
					w = CLASS_CUSTOMIZE_WIDTH;
					h = CLASS_CUSTOMIZE_HEADER_HEIGHT;
					colorBackground[] = COLOR_BRIGHT(1.0);
				};
				class Background: RscText {
					idc = -1;
					x = 0;
					y = CLASS_CUSTOMIZE_HEADER_HEIGHT;
					w = CLASS_CUSTOMIZE_WIDTH;
					h = CLASS_CUSTOMIZE_HEIGHT - CLASS_CUSTOMIZE_HEADER_HEIGHT;
					colorBackground[] = COLOR_DARK(0.8);
				};
				class Left_Column: RscControlsGroupNoScrollbars {
					idc = -1;
					x = 0;
					y = 0;
					w = CLASS_CUSTOMIZE_COL_WIDTH;
					h = CLASS_CUSTOMIZE_HEIGHT;

					class controls {
						class Header: WWR_RscTextHeaderColumn {
							text = "CLASS PERKS";
						};
						class lbClassPerks: WWR_RscListBoxColumn
						{
							idc = 0;
						};
					};
				};
				class Right_Column: RscControlsGroupNoScrollbars {
					idc = -1;
					x = CLASS_CUSTOMIZE_COL_WIDTH;
					y = 0;
					w = CLASS_CUSTOMIZE_COL_WIDTH;
					h = CLASS_CUSTOMIZE_HEIGHT;

					class controls {
						class Header: WWR_RscTextHeaderColumn {
							text = "SQUAD PERKS";
						};
						class lbSquadPerks: WWR_RscListBoxColumn
						{
							idc = 1;
						};
					};
				};
			};
		};
		class Return: RscButtonMenu
		{
			idc = 1;
			text = "RETURN"; //--- ToDo: Localize;
			x = safeZoneX + safeZoneW / 2 - CLASS_CUSTOMIZE_WIDTH / 2;
			y = safeZoneY + safeZoneH / 2 + CLASS_CUSTOMIZE_HEIGHT / 2;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
	};
};
