class houseMenu {
	idd = 75001;
	name = "houseMenu";
	location = "fadeOnly";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0;
			y = 0.14;
			w = 1;
			h = 0.06;
		};
		class RscBackground: Life_RscText {
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0;
			y = 0.2;
			w = 1;
			h = 0.72;
		};
		class RscTitleText: Life_RscTitle {
			idc = 75002;
			text = "";
			x = 0;
			y = 0.14;
			w = 1;
			h = 0.06;
			colorText[] = {0.95,0.95,0.95,1};
		};
		class VehicleWeight: RscTitleText {
			idc = 75003;
			style = 1;
			text = "";
			x = 0;
			y = 0.14;
			w = 1;
			h = 0.06;
			colorText[] = {0.95,0.95,0.95,1};
		};
		class RscTrunkText: Life_RscText {
			idc = -1;
			text = "房屋库存";
			sizeEx = 0.04;
			x = 0.275;
			y = 0.3;
			w = 0.3375;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};
		class RscPlayerText: Life_RscText {
			idc = -1;
			text = "玩家库存";
			sizeEx = 0.04;
			x = 0.6375;
			y = 0.3;
			w = 0.3375;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};
	};

	class Controls {

		class PlayerGear: Life_RscListBox {
			idc = 75004;
			onLBDblClick = "if (oev_virtualItems) then {[75004,75007,false] call OEC_fnc_doubleClickItem;};";
			sizeEx = 0.030;
			x = 0.6375;
			y = 0.34;
			w = 0.3375;
			h = 0.42;
		};
		class TrunkGear: Life_RscListBox {
			idc = 75005;
			onLBDblClick = "if (oev_virtualItems) then {[75005,75006,true] call OEC_fnc_doubleClickItem;};";
			sizeEx = 0.030;
			x = 0.275;
			y = 0.34;
			w = 0.3375;
			h = 0.42;
		};
		class TrunkEdit: Life_RscEdit {
			idc = 75006;

			text = "0";
			x = 0.275;
			y = 0.78;
			w = 0.3375;
			h = 0.04;
		};
		class PlayerEdit: Life_RscEdit {
			idc = 75007;

			text = "0";
			x = 0.6375;
			y = 0.78;
			w = 0.3375;
			h = 0.04;
		};
		class TakeItem: Life_RscButtonMenu {
			idc = 75008;
			onButtonClick = "[] call OEC_fnc_houseTakeItem; ctrlEnable[75010,false];ctrlEnable[75008,false];[]spawn{sleep 0.5; ctrlEnable[75008,true];if (playerSide isEqualTo civilian) then {ctrlEnable[75010,true];};};";

			x = 0.275;
			y = 0.84;
			w = 0.3375;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};
		class UpgradeStorage: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";
			idc = 75009;
			x = 0.025;
			y = 0.66;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class StoreItem: Life_RscButtonMenu {
			idc = 75010;
			onButtonClick = "[] call OEC_fnc_houseStoreItem; ctrlEnable[75008,false];ctrlEnable[75010,false];[]spawn{sleep 0.5; ctrlEnable[75010,true];ctrlEnable[75008,true];};";

			x = 0.6375;
			y = 0.84;
			w = 0.3375;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};
		class ButtonClose: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75011;
			x = 0.025;
			y = 0.84;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class SellHouse: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75012;
			x = 0.025;
			y = 0.48;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class UnlockHouse: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75013;
			x = 0.025;
			y = 0.60;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class LightsOn: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75014;
			x = 0.025;
			y = 0.30;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class RepairDoors: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75015;
			x = 0.025;
			y = 0.54;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class OilStorage: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75016;
			x = 0.025;
			y = 0.42;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class ManageKeys: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";

			idc = 75017;
			x = 0.025;
			y = 0.36;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
		class SwitchType: Life_RscButtonMenu {
			onButtonClick = "if (oev_virtualItems) then {((findDisplay 75001) displayCtrl 75018) ctrlSetText ""切换到虚拟库存"";oev_virtualItems = false; [cursorTarget,oev_virtualItems] call OEC_fnc_houseInventory; ctrlShow[75006,false]; ctrlShow[75007,false]; ctrlEnable[75018,false]; []spawn{sleep 0.5;  ctrlEnable[75018,true];};} else {((findDisplay 75001) displayCtrl 75018) ctrlSetText ""切换到物理库存"";ctrlShow[75006,true];ctrlShow[75007,true];oev_virtualItems = true; [cursorTarget,oev_virtualItems] call OEC_fnc_houseInventory; ctrlEnable[75018,false];[]spawn{sleep 0.5; ctrlEnable[75018,true];};};";

			idc = 75018;
			x = 0.275;
			y = 0.22;
			w = 0.7;
			h = 0.06;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};
	};
};

