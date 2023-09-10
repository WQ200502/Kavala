class yMenuDispatch : yMenuBase
{
	idd = 49000;
	onLoad = "[] spawn OEC_fnc_dispatchMenu;";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "RnR Dispatch";
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
			idc = 49007;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Initializing";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};

		class DispatchOwner : Life_RscText{
			idc = 49008;
			text = "";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.61;
			w = 0.46;
			h = 0.04;
		};

		class RequestTime : Life_RscText{
			idc = 49009;
			text = "";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.66;
			w = 0.46;
			h = 0.04;
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
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class DeadList: Life_RscListBox {
			idc = 49003;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "[] call OEC_fnc_dispatchInfo";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.35;
		};

		class OnRouteButtonKey : Life_RscButton {
			idc = 49005;
			text = "在路线上";
			onButtonClick = "[0] call OEC_fnc_dispatchNotify";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.70;
			w = 0.46;
			h = 0.05;
		};

		class RnRDeniedButtonKey : Life_RscButton {
			idc = 49006;
			text = "被RnR拒绝";
			onButtonClick = "[1] call OEC_fnc_dispatchNotify";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.76;
			w = 0.225;
			h = 0.05;
		};

		class DNRdcbugButtonKey : Life_RscButton {
			idc = 49011;
			text = "DNR错误";
			onButtonClick = "[4] call OEC_fnc_dispatchNotify";

			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.76;
			w = 0.225;
			h = 0.05;
		};

		class RnRDeniedThirdButtonKey : Life_RscButton {
			idc = 49007;
			text = "被第三方拒绝";
			onButtonClick = "[2] call OEC_fnc_dispatchNotify";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.82;
			w = 0.46;
			h = 0.05;
		};

		class CancelDispatchButtonKey : Life_RscButton {
			idc = 49010;
			text = "取消状态";
			onButtonClick = "[3] call OEC_fnc_dispatchNotify";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.88;
			w = 0.46;
			h = 0.05;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[49000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};