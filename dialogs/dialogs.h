#define PRIMARY_COLOR {0.96,0.65,0.12,0.8}
#define COLOR_PRIMARY(ALPHA) {0.96,0.65,0.12,ALPHA}
#define DARK_COLOR {0.12,0.14,0.16,0.8}
#define COLOR_DARK(ALPHA) {0.12,0.14,0.16,ALPHA}
#define BRIGHT_COLOR {1,1,1,0.8}
#define COLOR_BRIGHT(ALPHA) {1,1,1,ALPHA}
#define WHITE_SHADOW {1,1,1,0.1}
#define COLOR_BLACK(ALPHA) {0,0,0,ALPHA}
#define DISABLED_COLOR {0.52,0.54,0.56,1}
#define DISABLED_SETTING \
	colorDisabled[] = DISABLED_COLOR;\
	colorBackgroundDisabled[] = DARK_COLOR

#include "spawnmenu\dialog.h"

class rr_info_box {
    idd = 10000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
    class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.286 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,1};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			text = "INFORMATION"; //--- ToDo: Localize;
			x = 0.340156*safezoneW+safezoneX;
			y = 0.346*safezoneH+safezoneY;
			w = 0.309375*safezoneW;
			h = 0.033*safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};
		class text: RscStructuredText
		{
			idc = 0;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.299062 * safezoneW;
			h = 0.209 * safezoneH;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 1;
			text = "OKAY"; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.6144 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,1};
		};
	};
};

#include "class_customization\dialog.h"

class AdminAreaLB: RscListBox {
	rowHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.5)";
	wholeHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.5)";
	sizeEx = "1.00 * pixelH * pixelGridNoUIScale * 1.4";
	colorSelect[] = BRIGHT_COLOR;
	colorText[] = {1, 1, 1, 0.5};
	colorSelect2[] = BRIGHT_COLOR;
	colorSelectBackground[] = PRIMARY_COLOR;
	colorSelectBackground2[] = PRIMARY_COLOR;
	period = 1;
};

class PlayerSelectorLB: AdminAreaLB {
	onLBSelChanged = "cl_admin_player_sel = ((_this select 0) lbData (_this select 1)) call BIS_fnc_objectFromNetId;";
	onSetFocus = "params ['_ctrl']; private _display = ctrlParent _ctrl; (_display displayCtrl ([1500,1501] select (ctrlIDC _ctrl == 1500))) lbSetCurSel -1;";
};

class rr_modal {
	idd = 8000;
	movingEnable = 0;
	enableSimulation = 1;
	duration = 999999;
	onUnload = "params ['_display', '_exitCode'];if (_exitCode != 1) exitWith {};[ctrlText 1400] call (uiNamespace getVariable ['rr_modal_callback', {}])";
	class controls {
		class RscText_1000: RscText
		{
			idc = 1000;

			x = 0.323679 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.352643 * safezoneW;
			h = 0.131655 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = 1001;

			x = 0.323679 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.352643 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1002: RscText
		{
			idc = 1002;

			text = "TITLE"; //--- ToDo: Localize;
			x = 0.328087 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.343827 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
		class RscButtonMenuOK_2600: RscButtonMenu
		{
			idc = 1;

			text = "CONFIRM"; //--- ToDo: Localize;
			x = 0.610201 * safezoneW + safezoneX;
			y = 0.54702 * safezoneH + safezoneY;
			w = 0.0661205 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscButtonMenuCancel_2700: RscButtonMenu
		{
			idc = 2;

			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.54408 * safezoneW + safezoneX;
			y = 0.54702 * safezoneH + safezoneY;
			w = 0.0661205 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			text = "";
			maxChars = 256;
			x = 0.328087 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.343827 * safezoneW;
			h = 0.0658275 * safezoneH;
			colorBackground[] = {1,1,1,0.1};
		};
		class RscText_1003: RscText
		{
			idc = 1003;

			text = "Description"; //--- ToDo: Localize;
			x = 0.328087 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.343827 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
	};
};

class rr_admin_area {
    idd = 7000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
	onLoad = "_this call client_fnc_populateAdminArea;";
	class controls {
		class RscText_1000: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.385561 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1009: RscText
		{
			idc = -1;

			x = 0.501763 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.220402 * safezoneW;
			h = 0.385561 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.446975 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			shadow = 2;

			text = "ADMIN AREA"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.211586 * safezoneW;
			h = 0.0282118 * safezoneH;
			sizeEx = 2.00 * pixelH * pixelGridNoUIScale;
		};
		class RscText_1003: RscText
		{
			idc = 1001;
			shadow = 2;
			style = 2;

			text = "Attackers"; //--- ToDo: Localize;
			x = 0.279598 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 1;

			text = "RETURN"; //--- ToDo: Localize;
			x = 0.638412 * safezoneW + safezoneX;
			y = 0.650463 * safezoneH + safezoneY;
			w = 0.0837527 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1006: RscText
		{
			idc = 1002;
			shadow = 2;
			style = 2;

			text = "Defenders"; //--- ToDo: Localize;
			x = 0.389799 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1000;
			shadow = 2;

			text = "Next map:"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.207178 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class map_picker: RscButtonMenu
		{
			idc = 100;
			action = "[] call admin_fnc_selectNextMap";

			text = "CHOOSE MAP"; //--- ToDo: Localize;
			x = 0.614609 * safezoneW + safezoneX;
			y = 0.481192 * safezoneH + safezoneY;
			w = 0.101385 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class kick_player: RscButtonMenu
		{
			idc = 101;
			action = "[] call admin_fnc_kickPlayer";

			text = "KICK PLAYER"; //--- ToDo: Localize;
			x = 0.279598 * safezoneW + safezoneX;
			y = 0.594039 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscButtonMenu_2403: RscButtonMenu
		{
			idc = 102;
			action = "[] spawn admin_fnc_switchPlayer";

			text = "SWITCH PLAYER"; //--- ToDo: Localize;
			x = 0.389799 * safezoneW + safezoneX;
			y = 0.594039 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class kill_player: RscButtonMenu
		{
			idc = 103;
			action = "[] call admin_fnc_killPlayer";

			text = "KILL PLAYER"; //--- ToDo: Localize;
			x = 0.279598 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscButtonMenu_2405: RscButtonMenu
		{
			idc = 1;
			action = "[] spawn admin_fnc_spectate";

			text = "SPECTATOR MODE"; //--- ToDo: Localize;
			x = 0.389799 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class attackers_list: PlayerSelectorLB
		{
			idc = 1500;

			x = 0.279598 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.253906 * safezoneH;
			colorText[] = {1,1,1,0.5};
			sizeEx = 1.00 * pixelH * pixelGridNoUIScale;
		};
		class defenders_list: PlayerSelectorLB
		{
			idc = 1501;

			x = 0.389799 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.253906 * safezoneH;
			colorText[] = {1,1,1,0.5};
			sizeEx = 1.00 * pixelH * pixelGridNoUIScale;
		};
		class map_list: AdminAreaLB
		{
			idc = 1502;
			onLBSelChanged = "params ['_ctrl', '_idx']; cl_admin_sel_map = _ctrl lbData _idx;";

			x = 0.506171 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.211586 * safezoneW;
			h = 0.141059 * safezoneH;
			colorText[] = {1,1,1,0.5};
			sizeEx = 1.00 * pixelH * pixelGridNoUIScale;
		};
		class RscButtonMenu_2406: RscButtonMenu
		{
			idc = 100;
			action = "[] spawn { _result = ['Are you sure you want to end the round?', 'Confirm', true, true] call BIS_fnc_guiMessage; if (_result) then {[] remoteExec ['server_fnc_endRound', 2]};}";
			text = "END ROUND"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.481192 * safezoneH + safezoneY;
			w = 0.101385 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscButtonMenu_2407: RscButtonMenu
		{
			idc = 100;
			action = "if (isNull (findDisplay 8000)) then {createDialog 'rr_admin_params';};";
			type = 1;
			style = ST_CENTER;
			text = "EDIT PARAMS"; //--- ToDo: Localize;
			x = 0.54408 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.136649 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = {1,1,1,1};
			color[] = {1,1,1,1};
			color2[] = {0,0,0,1};
			colorBackground[] = WHITE_SHADOW;
			colorBackgroundActive[] = BRIGHT_COLOR;
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			DISABLED_SETTING;
			period = 0;
			colorShadow[] = {0,0,0,0};
			colorBorder[]= DARK_COLOR;
			borderSize = 0;
		};
	};
};

class rr_admin_params {
    idd = 8000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
	onLoad = "_this call client_fnc_populateAdminParams";
	onUnload = "_this call admin_fnc_setParams";
	class controls {
		class RscText_1100: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.293114 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.376157 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1101: RscText
		{
			idc = -1;

			x = 0.5 * safezoneW + safezoneX;
			y = 0.293114 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.376157 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1102: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.446975 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1103: RscText
		{
			idc = -1;
			shadow = 2;

			text = "PARAMS"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.0282118 * safezoneH;
			sizeEx = 2.00 * pixelH * pixelGridNoUIScale;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 2;

			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.570529 * safezoneW + safezoneX;
			y = 0.669271 * safezoneH + safezoneY;
			w = 0.0837527 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscButtonMenu_2401: RscButtonMenu
		{
			idc = 1;

			text = "CONFIRM"; //--- ToDo: Localize;
			x = 0.656926 * safezoneW + safezoneX;
			y = 0.669271 * safezoneH + safezoneY;
			w = 0.069647 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class ParamTitle: RscText {
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1)";
		};
		class RscText_1000: ParamTitle
		{
			idc = 1000;

			text = "Text_0"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1001: ParamTitle
		{
			idc = 1001;

			text = "Text_1"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1002: ParamTitle
		{
			idc = 1002;

			text = "Text_2"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1003: ParamTitle
		{
			idc = 1003;

			text = "Text_3"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1004: ParamTitle
		{
			idc = 1004;

			text = "Text_4"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1005: ParamTitle
		{
			idc = 1005;

			text = "Text_5"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1006: ParamTitle
		{
			idc = 1006;

			text = "Text_6"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1007: ParamTitle
		{
			idc = 1007;

			text = "Text_7"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1008: ParamTitle
		{
			idc = 1008;

			text = "Text_8"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1009: ParamTitle
		{
			idc = 1009;

			text = "Text_9"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1010: ParamTitle
		{
			idc = 1010;

			text = "Text_10"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1011: ParamTitle
		{
			idc = 1011;

			text = "Text_11"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1012: ParamTitle
		{
			idc = 1012;

			text = "Text_12"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1013: ParamTitle
		{
			idc = 1013;

			text = "Text_13"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1014: ParamTitle
		{
			idc = 1014;

			text = "Text_14"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1015: ParamTitle
		{
			idc = 1015;

			text = "Text_15"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1016: ParamTitle
		{
			idc = 1016;

			text = "Text_16"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1017: ParamTitle
		{
			idc = 1017;

			text = "Text_17"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1018: ParamTitle
		{
			idc = 1018;

			text = "Text_18"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1019: ParamTitle
		{
			idc = 1019;

			text = "Text_19"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1020: ParamTitle
		{
			idc = 1020;

			text = "Text_20"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1021: ParamTitle
		{
			idc = 1021;

			text = "Text_21"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1022: ParamTitle
		{
			idc = 1022;

			text = "Text_22"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1023: ParamTitle
		{
			idc = 1023;

			text = "Text_23"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1024: ParamTitle
		{
			idc = 1024;

			text = "Text_24"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1025: ParamTitle
		{
			idc = 1025;

			text = "Text_25"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1100: RscCombo
		{
			idc = 1100;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1101: RscCombo
		{
			idc = 1101;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1102: RscCombo
		{
			idc = 1102;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1103: RscCombo
		{
			idc = 1103;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1104: RscCombo
		{
			idc = 1104;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1105: RscCombo
		{
			idc = 1105;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1106: RscCombo
		{
			idc = 1106;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1107: RscCombo
		{
			idc = 1107;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1108: RscCombo
		{
			idc = 1108;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1109: RscCombo
		{
			idc = 1109;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1110: RscCombo
		{
			idc = 1110;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1111: RscCombo
		{
			idc = 1111;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1112: RscCombo
		{
			idc = 1112;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1113: RscCombo
		{
			idc = 1113;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1114: RscCombo
		{
			idc = 1114;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1115: RscCombo
		{
			idc = 1115;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1116: RscCombo
		{
			idc = 1116;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1117: RscCombo
		{
			idc = 1117;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1118: RscCombo
		{
			idc = 1118;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1119: RscCombo
		{
			idc = 1119;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1120: RscCombo
		{
			idc = 1120;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1121: RscCombo
		{
			idc = 1121;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1122: RscCombo
		{
			idc = 1122;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1123: RscCombo
		{
			idc = 1123;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1124: RscCombo
		{
			idc = 1124;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1125: RscCombo
		{
			idc = 1125;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
	};
};
