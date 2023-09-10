class TrunkMenu {
	idd = 3500;
	name = "TrunkMenu";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.7;
			h = (1 / 25);
		};

		class RscBackground: Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.7;
			h = 0.7 - (22 / 250);
		};

		class RscTitleText: Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 3501;
			text = "";
			x = 0.1;
			y = 0.2;
			w = 0.7;
			h = (1 / 25);
		};

		class VehicleWeight: RscTitleText {
			idc = 3504;
			style = 1;
			text = "";
		};

		class RscTrunkText: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "$STR_Trunk_TInventory";
			sizeEx = 0.04;
			x = 0.11;
			y = 0.25;
			w = 0.3;
			h = 0.04;
		};

		class RscPlayerText: Life_RscText {
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "$STR_Trunk_PInventory";
			sizeEx = 0.04;
			x = 0.49;
			y = 0.25;
			w = 0.3;
			h = 0.04;
		};
	};

	class Controls {
		class TrunkGear: Life_RscListBox {
			idc = 3502;
			text = "";
			sizeEx = 0.030;
			onLBDblClick = "[3502,3505,true] call OEC_fnc_doubleClickItem;";
			x = 0.11;
			y = 0.29;
			w = 0.3;
			h = 0.42;
		};

		class PlayerGear: Life_RscListBox {
			idc = 3503;
			text = "";
			sizeEx = 0.030;
			onLBDblClick = "[3503,3506,false] call OEC_fnc_doubleClickItem;";
			x = 0.49;
			y = 0.29;
			w = 0.3;
			h = 0.42;
		};

		class TrunkEdit: Life_RscEdit {
			idc = 3505;
			text = "0";
			sizeEx = 0.030;
			x = 0.11;
			y = 0.72;
			w = 0.3;
			h = 0.03;
		};

		class PlayerEdit: Life_RscEdit {
			idc = 3506;
			text = "0";
			sizeEx = 0.030;
			x = 0.49;
			y = 0.72;
			w = 0.3;
			h = 0.03;
		};

		class TakeItem: Life_RscButtonMenu {
			idc = 3507;
			text = "$STR_Trunk_Take";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_vehTakeItem; ctrlEnable[3507,false];[]spawn{sleep 0.5; ctrlEnable[3507,true];};";
			x = 0.19;
			y = 0.78;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class StoreItem: Life_RscButtonMenu {
			idc = 3508;
			text = "$STR_Trunk_Store";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_vehStoreItem; ctrlEnable[3508,false];[]spawn{sleep 0.5; ctrlEnable[3508,true];};";
			x = 0.57; y = 0.78;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class ButtonClose: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};