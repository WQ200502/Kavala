class yMenuMarket: yMenuBase{
	idd = 38000;

	class controlsBackground: controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "市场价值";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
		class Tab9PictureBackground: BaseTab9PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
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
			idc = 38001;
			text = "物品信息";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
		class InformationTitle: Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 38003;
			text = "价格信息";
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
		class Tab9: BaseTab9{
			onButtonClick = "";
		};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		class ItemList: Life_RscListBox {
			idc = 38002;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.45;
			onLBSelChanged = "[] call OEC_fnc_refreshMarketView";
			sizeEx = 0.04;
		};
		class PriceText: Life_RscText {
			idc = 38004;
			text = "目前的价格: $0";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.61 + 0.15;
			w = 0.96;
			h = 0.04;
			sizeEx = 1.3 * 0.04;
		};
		class SinceRestartText: Life_RscText {
			idc = -1;
			text = "重新启动后:";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.7 + 0.15;
			w = 0.96;
			h = 0.04;
			sizeEx = 1.2 * 0.04;
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
		class picTrendLocal: Life_RscPicture {
			idc = 38007;
			text = "images\icons\trendup.paa";
			x = (safeZoneX + safeZoneW) - 0.28;
			y = 0.7 + 0.13;
			w = 3 * 0.025;
			h = 2.5 * 0.04;
		};
		class TrendLocalText: Life_RscText {
			idc = 38008;
			text = "$10,000";
			x = ((safeZoneX + safeZoneW) - 0.28) + (3 * 0.025);
			y = 0.7 + 0.15;
			w = 0.96;
			h = 0.04;
			sizeEx = 1.2 * 0.04;
		};
		class ButtonClose: BaseButtonClose {
			idc = -1;
			text = "关闭";
			onButtonClick = "[38000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};