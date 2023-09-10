class yMenuWanted : yMenuBase
{
	idd = 39000;
	onLoad = "[] spawn OEC_fnc_wantedMenu;";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家通缉名单";
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
		class Tab10PictureBackground: BaseTab10PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
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

		class MainTitle : Life_RscText{
			idc = 39007;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "犯罪数据库";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};

		class SelectedPlayer : Life_RscText{
			idc = 39001;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "******* ******";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.61;
			w = 0.46;
			h = 0.04;
		};

		class SelectedBounty : SelectedPlayer{
			idc = 39002;
			style = 1;
			colorBackground[] = {0,0,0,0};
			text = "赏金: $***,***";
		};


	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{
			onButtonClick = "";
		};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class WantedList: Life_RscListBox {
			idc = 39003;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "[] call OEC_fnc_wantedInfo";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.35;
		};

		class WantedDetails : Life_RscListBox{
			idc = 39004;
			text = "";
			sizeEx = 0.035;
			colorBackground[] = {0, 0, 0, 0};

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.65;
			w = 0.46;
			h = 0.22;
		};


		class PardonButtonKey : Life_RscButton {
			idc = 39005;
			text = "保释机会";
			onButtonClick = "[] spawn OEC_fnc_pardon;";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.88;
			w = 0.225;
			h = 0.05;
		};

		class ButtonWantedAdd : PardonButtonKey {
			idc = 39006;
			text = "审判玩家";
			onButtonClick = "['life_wantedadd2'] spawn OEC_fnc_createDialog;";

			x = (safeZoneX + safeZoneW) - 0.235;
		};


		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "Close";
			onButtonClick = "[39000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};