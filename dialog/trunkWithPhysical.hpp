class TrunkPhysicalMenu {
	idd = 4500;
	name = "TrunkPhysicalMenu";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1;
			y = 0.12;
			w = 0.7;
			h = 0.04;
		};

		class RscBackground: Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.16;
			w = 0.7;
			h = 0.68;
		};

		class RscTitleText: Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 4501;
			text = "";
			x = 0.1;
			y = 0.12;
			w = 0.7;
			h = 0.04;
		};

		class VehicleWeight: RscTitleText {
			idc = 4504;
			style = 1;
			text = "";
			x = 0.1;
			y = 0.12;
			w = 0.7;
			h = 0.04;
		};

		class RscTrunkText: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "$STR_Trunk_TInventory";
			sizeEx = 0.04;
			x = 0.125;
			y = 0.24;
			w = 0.3;
			h = 0.04;
		};

		class RscPlayerText: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "$STR_Trunk_PInventory";
			sizeEx = 0.04;
			x = 0.475;
			y = 0.24;
			w = 0.3;
			h = 0.04;
		};
	};

	class Controls {
		class TrunkGear: Life_RscListBox {
			idc = 4502;
			text = "";
			sizeEx = 0.030;
			onLBDblClick = "if (oev_virtualItems) then {[4502,4505,true,false] call OEC_fnc_doubleClickItem;} else {[4502,4505,true,true] call OEC_fnc_doubleClickItem;};";
			x = 0.125;
			y = 0.28;
			w = 0.3;
			h = 0.42;
		};

		class PlayerGear: Life_RscListBox {
			idc = 4503;
			text = "";
			sizeEx = 0.030;
			onLBDblClick = "if (oev_virtualItems) then {[4503,4506,false,false] call OEC_fnc_doubleClickItem;} else {[4503,4506,false,true] call OEC_fnc_doubleClickItem;};";
			x = 0.475;
			y = 0.28;
			w = 0.3;
			h = 0.42;
		};

		class TrunkEdit: Life_RscEdit {
			idc = 4505;
			text = "0";
			sizeEx = 0.030;
			x = 0.125;
			y = 0.72;
			w = 0.3;
			h = 0.03;
		};

		class PlayerEdit: Life_RscEdit {
			idc = 4506;
			text = "0";
			sizeEx = 0.030;
			x = 0.475;
			y = 0.72;
			w = 0.3;
			h = 0.03;
		};

		class SwitchType: Life_RscButtonMenu {
			onButtonClick = "if (oev_virtualItems) then {((findDisplay 4500) displayCtrl 4518) ctrlSetText ""切换到虚拟库存"";oev_virtualItems = false; if !(oev_adminForce) then {[oev_trunk_vehicle,oev_virtualItems] call OEC_fnc_houseInventory;} else {[oev_trunk_vehicle,oev_virtualItems] call OEC_fnc_adminHouseInv;}; ctrlEnable[4518,false]; []spawn{sleep 0.5;  ctrlEnable[4518,true];};} else {((findDisplay 4500) displayCtrl 4518) ctrlSetText ""切换到物理库存"";oev_virtualItems = true; if !(oev_adminForce) then {[oev_trunk_vehicle,oev_virtualItems] call OEC_fnc_houseInventory;} else {[oev_trunk_vehicle,oev_virtualItems] call OEC_fnc_adminHouseInv;}; ctrlEnable[4518,false];[]spawn{sleep 0.5; ctrlEnable[4518,true];};};";
			idc = 4518;
			x = 0.125;
			y = 0.18;
			w = 0.65;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};

		class MoveUp: Life_RscButtonMenu {
			onButtonClick = "[oev_virtualItems, true] call OEC_fnc_houseMoveItem";
			text = "/\";
			idc = 4519;
			x = 0.4375;
			y = 0.42;
			w = 0.025;
			h = 0.06;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};

		class MoveDown: Life_RscButtonMenu {
			onButtonClick = "[oev_virtualItems, false] call OEC_fnc_houseMoveItem";
			text = "\/";
			idc = 4520;
			x = 0.4375;
			y = 0.5;
			w = 0.025;
			h = 0.06;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.4};
		};

		class TakeItem: Life_RscButtonMenu {
			idc = 4507;
			text = "$STR_Trunk_Take";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_houseTakeItem; ctrlEnable[4507,false];ctrlEnable[4508,false];[]spawn{sleep 0.5; ctrlEnable[4507,true];ctrlEnable[4508,true];};";
			x = 0.2;
			y = 0.76;
			w = 0.15;
			h = 0.04;
		};

		class StoreItem: Life_RscButtonMenu {
			idc = 4508;
			text = "$STR_Trunk_Store";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_houseStoreItem; ctrlEnable[4507,false];ctrlEnable[4508,false];[]spawn{sleep 0.5; ctrlEnable[4507,true];ctrlEnable[4508,true];};";
			x = 0.55;
			y = 0.76;
			w = 0.15;
			h = 0.04;
		};

		class ButtonClose: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.84;
			w = 0.15;
			h = 0.04;
		};
	};
};