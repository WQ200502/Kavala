class yMenuMain: yMenuBase {
	idd = 30000;
	onLoad = "[] spawn OEC_fnc_updateMainMenuTab;";

	class controlsBackground: controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "主菜单";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
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

		class LicensesHeadder: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "证件";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.54;
			w = 0.46;
			h = 0.04;
		};

		class RestartTime: BaseTitle {
			idc = 30004;
			colorBackground[] = {0,0,0,0};
			text = "证件";
			style = 1;
		};
	};

	class controls: controlsBase {
		class Tab1: BaseTab1{
			onButtonClick = "";
		};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class CashPicture: Life_RscPicture {
			idc = -1;
			text = "images\icons\money.paa";
			x = (safeZoneX + safeZoneW) - 0.41375;
			y = 0.21;
			w = 0.1125;
			h = 0.1125 * 4 / 3;
		};

		class CashValue: Life_RscStructuredText {
			idc = 30001;
			text = "";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.355;
			w = 0.225;
			h = 0.04;
		};

		class BankPicture: Life_RscPicture {
			idc = -1;
			text = "images\icons\bank.paa";
			x = (safeZoneX + safeZoneW) - 0.17875;
			y = 0.21;
			w = 0.1125;
			h = 0.1125 * 4 / 3;
		};

		class BankValue: Life_RscStructuredText {
			idc = 30002;
			text = "";
			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.355;
			w = 0.225;
			h = 0.04;
		};

		class WebsiteText: Life_RscStructuredText {
			idc = 30009;
			text = "test";
			x = (safeZoneX + safeZoneW) - 0.19875;
			y = 0.4;
			w = 0.225;
			h = 0.04;
		};

		class TwitterText: Life_RscStructuredText {
			idc = 30010;
			text = "test";
			x = (safeZoneX + safeZoneW) - 0.196;
			y = 0.45;
			w = 0.225;
			h = 0.04;
		};

		class Licenses: life_RscListBox {
			idc = 30003;
			sizeEx = 0.0325;
			text = "";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.59;
			w = 0.46;
			h = 0.32;
		};

		class GiveMoneyEdit: Life_RscEdit {
			idc = 30006;
			text = "0";
			x = (safeZoneX + safeZoneW) - 0.425;
			y = 0.4;
			w = 0.1525;
			h = 0.03;
		};

		class GiveMoneyLB: Life_RscCombo {
			idc = 30007;
			//sizeEx = 0.004;
			x = (safeZoneX + safeZoneW) - 0.425;
			y = 0.44;
			w = 0.1525;
			h = 0.03;
		};

		class GiveMoneyButton: Life_RscButtonMenu {
			idc = 30008;
			text = "给现金";
			onButtonClick = "[] call OEC_fnc_giveMoney";
			x = (safeZoneX + safeZoneW) - 0.425;
			y = 0.48;
			w = 0.1525;
			h = 0.04;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose {
			idc = 30005;
			text = "关闭";
			onButtonClick = "[30000, 'right', false] spawn OEC_fnc_animateDialog";
		};
	};
};