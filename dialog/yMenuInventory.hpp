class yMenuInventory : yMenuBase
{
	idd = 31000;
	onLoad = "[] spawn OEC_fnc_updateInventoryTab";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "Player Inventory";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
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

		class itemHeader : Life_RscText{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "$STR_PM_cItems";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};

		class carryWeight : itemHeader{
			idc = 31001;
			style = 1;//align right
			text = "";
			colorBackground[] = {0,0,0,0};
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{
			onButtonClick = "";
		};
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

		class itemList : life_RscListBox {
			idc = 31010;
			sizeEx = 0.04;
			colorBackground[] = {0.15,0.15,0.15,0.5};
			onLBDblClick = "[31010,31012,false] call OEC_fnc_doubleClickItem;";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.49;
		};

		class UseItem: Life_RscButton{
			idc = 31006;
			text = "使用物品";
			onButtonClick = "[] call OEC_fnc_useItem;";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.75;
			w = 0.46;
			h = 0.05;
		};

		class RemoveItem: Life_RscButton{
			idc = 31007;
			text = "丢弃";
			onButtonClick = "[] call OEC_fnc_removeItem;";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.87;
			w = 0.225;
			h = 0.05;
		};

		class GiveItem: RemoveItem{
			idc = 31008;
			text = "给与";
			onButtonClick = "[] call OEC_fnc_giveItem;";

			y = 0.81;
		};

		class NearbyPlayers: Life_RscCombo{
			idc = 31011;

			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.81;
			w = 0.225;
			h = 0.05;
		};

		class itemEdit : Life_RscEdit {
			idc = 31012;

			text = "0";
			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.87;
			w = 0.225;
			h = 0.05;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = 31005;
			text = "关闭";
			onButtonClick = "[31000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};
