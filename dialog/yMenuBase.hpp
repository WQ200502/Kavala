//The main class for the yMenu, the position of all the tabs, bacground, general layout is inherited from this

class yMenuBase{
	idd = -1;
	location = "right";
	movingEnable = 1;
	enableSimulation = 1;

	class controlsBackgroundBase {
		class BaseBackground: Life_RscText{
			idc = -1;

			x = (safeZoneX + safeZoneW) - 0.48;
			y = -0.06;
			w = 0.48;
			h = 1.075;
			colorBackground[] = {0,0,0,0.7};
		};

		class BaseTitle: Life_RscText{
			idc = -1;
			text = "标题";

			x = (safeZoneX + safeZoneW) - 0.48;
			y = -0.06;
			w = 0.48;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
		};


		//tab picture backgrounds
		class BaseTab1PictureBackground: Life_RscText{
			idc = -1;

			x = (safeZoneX + safeZoneW) - 0.48;
			y = -0.02;
			w = 0.08;
			h = 0.08 * 4 / 3;
			colorBackground[] = {0,0,0,0.6};
		};

		class BaseTab2PictureBackground: BaseTab1PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.4;
		};

		class BaseTab3PictureBackground: BaseTab2PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.32;
		};

		class BaseTab4PictureBackground: BaseTab3PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.24;
		};

		class BaseTab5PictureBackground: BaseTab4PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.16;
		};

		class BaseTab6PictureBackground: BaseTab5PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.08;
		};

		class BaseTab7PictureBackground: Life_RscText{
			idc = -1;

			x = (safeZoneX + safeZoneW) - 0.48;
			y = 0.086;
			w = 0.08;
			h = 0.08 * 4 / 3;
			colorBackground[] = {0,0,0,0.6};
		};

		class BaseTab8PictureBackground: BaseTab7PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.4;
		};

		class BaseTab9PictureBackground: BaseTab8PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.32;
		};

		class BaseTab10PictureBackground: BaseTab9PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.24;
		};

		class BaseTab11PictureBackground: BaseTab10PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.16;
		};

		class BaseTab12PictureBackground: BaseTab11PictureBackground{
			x = (safeZoneX + safeZoneW) - 0.08;
		};

		//Tab pictures
		class BaseTab1Picture: Life_RscPicture{//main menu
			idc = -1;
			text = "images\icons\house.paa";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = -0.01;
			w = 0.06;
			h = 0.06 * 4 / 3;
		};

		class BaseTab2Picture: BaseTab1Picture{//inventory
			text = "images\icons\carrying.paa";
			x = (safeZoneX + safeZoneW) - 0.39;
		};

		class BaseTab3Picture: BaseTab2Picture{//stats/levels/skills
			text = "images\icons\stats.paa";
			x = (safeZoneX + safeZoneW) - 0.31;
		};

		class BaseTab4Picture: BaseTab3Picture{//key chain
			text = "images\icons\key.paa";
			x = (safeZoneX + safeZoneW) - 0.23;
		};

		class BaseTab5Picture: BaseTab4Picture{//phone
			text = "images\icons\phone.paa";
			x = (safeZoneX + safeZoneW) - 0.15;
		};

		class BaseTab6Picture: BaseTab5Picture{//settings
			text = "images\icons\settings.paa";
			x = (safeZoneX + safeZoneW) - 0.07;
		};

		class BaseTab7Picture: Life_RscPicture{//groups
			idc = -1;
			text = "images\icons\group.paa";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.096;
			w = 0.06;
			h = 0.06 * 4 / 3;
		};

		class BaseTab8Picture: BaseTab7Picture{//gangs
			text = "images\icons\gang.paa";
			x = (safeZoneX + safeZoneW) - 0.39;
		};

		class BaseTab9Picture: BaseTab8Picture{//market
			text = "images\icons\market.paa";
			x = (safeZoneX + safeZoneW) - 0.31;
		};

		class BaseTab10Picture: BaseTab9Picture{//wanted list
			text = "images\icons\badge.paa";
			x = (safeZoneX + safeZoneW) - 0.23;
		};

		class BaseTab11Picture: BaseTab10Picture{//event menu
			text = "images\icons\event.paa";
			x = (safeZoneX + safeZoneW) - 0.15;
		};

		class BaseTab12Picture: BaseTab11Picture{//admin menu
			text = "images\icons\admin.paa";
			x = (safeZoneX + safeZoneW) - 0.07;
		};
	};

	class controlsBase {
		//Tab buttons
		class BaseTab1: Life_RscButton{
			idc = 30901;
			text = "";
			onButtonClick = "['yMenuMain'] spawn OEC_fnc_createDialog;";
			tooltip = "Main Menu";

			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0};
			colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.2};
			colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0};
			colorBackgroundDisabled[] = {0,0,0,0.7};

			x = (safeZoneX + safeZoneW) - 0.48;
			y = -0.02;
			w = 0.08;
			h = 0.08 * 4 / 3;
		};

		class BaseTab2: BaseTab1{
			idc = 30902;
			x = (safeZoneX + safeZoneW) - 0.4;
			onButtonClick = "['yMenuInventory'] spawn OEC_fnc_createDialog;";
			tooltip = "库存";
		};

		class BaseTab3: BaseTab2{
			idc = 30903;
			x = (safeZoneX + safeZoneW) - 0.32;
			onButtonClick = "['yMenuStats'] spawn OEC_fnc_createDialog;";
			tooltip = "统计数据";
		};

		class BaseTab4: BaseTab3{
			idc = 30904;
			x = (safeZoneX + safeZoneW) - 0.24;
			onButtonClick = "['yMenuKeyChain'] spawn OEC_fnc_createDialog;";
			tooltip = "钥匙链";
		};

		class BaseTab5: BaseTab4{
			idc = 30905;
			x = (safeZoneX + safeZoneW) - 0.16;
			onButtonClick = "['yMenuPhone'] spawn OEC_fnc_createDialog;";
			tooltip = "手机";
		};

		class BaseTab6: BaseTab5{
			idc = 30906;
			x = (safeZoneX + safeZoneW) - 0.08;
			onButtonClick = "['yMenuSettings'] spawn OEC_fnc_createDialog;";
			tooltip = "设置";
		};

		class BaseTab7: Life_RscButton{
			idc = 30907;
			text = "";
			onButtonClick = "[] spawn OEC_fnc_groupMenu;";
			tooltip = "群组";

			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0};
			colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.2};
			colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0};
			colorBackgroundDisabled[] = {0,0,0,0.7};

			x = (safeZoneX + safeZoneW) - 0.48;
			y = 0.086;
			w = 0.08;
			h = 0.08 * 4 / 3;
		};

		class BaseTab8: BaseTab7{
			idc = 30908;
			x = (safeZoneX + safeZoneW) - 0.4;
			onButtonClick = "if((count oev_gang_data) == 0) then {['yMenuCreateGang'] spawn OEC_fnc_createDialog;}else{['yMenuGangs'] spawn OEC_fnc_createDialog;};";
			tooltip = "帮派";
		};

		class BaseTab9: BaseTab8{
			idc = 30909;
			x = (safeZoneX + safeZoneW) - 0.32;
			onButtonClick = "[] spawn OEC_fnc_openMarketView;";
			tooltip = "市场";
		};

		class BaseTab10: BaseTab9{
			idc = 30910;
			x = (safeZoneX + safeZoneW) - 0.24;
			onButtonClick = "['yMenuWanted'] spawn OEC_fnc_createDialog;";
			tooltip = "通缉名单";
		};

		class BaseTab11: BaseTab10{
			idc = 30911;
			x = (safeZoneX + safeZoneW) - 0.16;
			onButtonClick = "[] spawn OEC_fnc_openTitleView;";
			tooltip = "称号菜单";
		};

		class BaseTab12: BaseTab11{
			idc = 30912;
			x = (safeZoneX + safeZoneW) - 0.08;
			onButtonClick = "['life_admin_menu'] spawn OEC_fnc_createDialog;";
			tooltip = "管理菜单";
		};

		//Bottom buttons
		class BaseButtonClose: Life_RscButton{
			idc = -1;
			text = "按钮1"; //--- ToDo: Localize;
			onButtonClick = "";

			x = (safeZoneX + safeZoneW) - 0.48;
			y = 0.94;
			w = 0.48;
			h = 0.075;
			colorText[] = {0.7,0.7,0.7,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
		};
	};
};