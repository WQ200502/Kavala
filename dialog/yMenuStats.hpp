class yMenuStats: yMenuBase {
	idd = 32000;
	onLoad = "[] spawn OEC_fnc_updateStatsTab;";

	class controlsBackground: controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家统计";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
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
	};

	class controls: controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{
			onButtonClick = "";
		};
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

		class PlaytimesHeader: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "游戏时间";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};

		class PlayerTagsHeader: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "其他统计数据";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.4;
			w = 0.46;
			h = 0.04;
		};

		class CivTimeText: life_RscText {
			idc = 32001;
			text = "平民:";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.4;
			h = 0.04;
		};

		class CopTimeText: CivTimeText {
			idc = 32002;
			text = "警察:";

			y = 0.30;
		};

		class MedTimeText: CivTimeText {
			idc = 32003;
			text = "医生:";
			y = 0.35;
		};

		class KillsDeaths: CivTimeText {
			idc = 32004;
			text = "K/D:";
			y = 0.45;
		};

		class Warpoints: CivTimeText {
			idc = 32008;
			text = "战争要点:";
			y = 0.5;
		};

		class VigilanteRank: CivTimeText {
			idc = 32009;
			text = "维吉兰特排名:";
			y = 0.55;
		};

		class VigilanteArrests: CivTimeText {
			idc = 32010;
			text = "治安警察逮捕:";
			y = 0.6;
		};

		class Revives: CivTimeText {
			idc = 32005;
			text = "复活:";
			y = 0.65;
		};

		class Arrests: CivTimeText {
			idc = 32006;
			text = "累计逮捕:";
			y = 0.7;
		};

		class PlayerUID: CivTimeText {
			idc = 32007;
			text = "UID:";
			y = 0.75;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = 32005;
			text = "关闭";
			onButtonClick = "[32000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};
