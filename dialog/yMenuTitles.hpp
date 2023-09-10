class yMenuTitles: yMenuBase{
	idd = 41250;

	class controlsBackground: controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "称号菜单";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};
		class ItemsTitle: Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 41251;
			text = "标题";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
		class InformationTitle: Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 41253;
			text = "信息";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.56 + 0.15;
			w = 0.46;
			h = 0.04;
		};
	};

	class controls: controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{
			onButtonClick = "";
		};
		class Tab12: BaseTab12{};
		class TitleList: Life_RscListBox {
			idc = 41252;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.45;
			onLBSelChanged = "[] spawn OEC_fnc_titleSelect;";
			sizeEx = 0.035;
		};
		class AchievementDescription: Life_RscText {
			idc = 41254;
			text = "选择标题以查看进度！";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.76;
			w = 0.96;
			h = 0.04;
			sizeEx = 0.035;
		};
		class AchievementProgress: Life_RscText {
			idc = 41255;
			text = "";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.80;
			w = 0.96;
			h = 0.04;
			sizeEx = 0.035;
		};/*
		class picTrendGlobal: Life_RscPicture
		{
			idc = 38005;
			text = "images\icons\trendup.paa";
			x = (safeZoneX + safeZoneW) - 0.48;
			y = 0.75 + 0.15;
			w = 3 * 0.025;
			h = 2.5 * 0.04;
		};
		class TrendGlobalText : Life_RscText {
			idc = 38006;
			text = "$10,000";
			x = ((safeZoneX + safeZoneW) - 0.48) + 0.075;
			y = 0.77 + 0.15;
			w = 0.96;
			h = 0.04;
			sizeEx = 1.2 * 0.04;
		};
		class RecentlyText : Life_RscText {
			idc = -1;
			text = "Recently";
			x = (safeZoneX + safeZoneW) - 0.2;
			y = 0.7 + 0.15;
			w = 0.96;
			h = 0.04;
			sizeEx = 1.2 * 0.04;
		};*/
		class ButtonChangeTitle: BaseButtonClose {
			idc = 41256;
			text = "装备";
			x = (safeZoneX + safeZoneW) - 0.22;
			y = 0.81;
			w = 0.21;
			h = 0.0475; //.075
			onButtonClick = "[] spawn OEC_fnc_equipTitle;";
		};
		class ButtonChangeColorTitle: BaseButtonClose {
			idc = 41259;
			text = "改变颜色";
			x = (safeZoneX + safeZoneW) - 0.22;
			y = 0.86;
			w = 0.21;
			h = 0.0475; //.075
			onButtonClick = "[] spawn OEC_fnc_handleTitleColors;";
		};
		class TitleColors: Life_RscCombo{
			idc = 41258;

			x = (safeZoneX + safeZoneW) - 0.46;
			y = 0.86;
			w = 0.225;
			h = 0.0475;
		};
		class ButtonClose: BaseButtonClose {
			idc = -1;
			text = "关闭";
			onButtonClick = "[41250, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};