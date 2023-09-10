class gangShedMenu {
	idd = 100000;
	location = "fadeOnly";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0;
			y = 0.2;
			w = 0.75;
			h = (1 / 25);
		};

		class MainBackground: life_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.8};
			x = 0;
			y = 0.2 + (11 / 250);
			w = 0.75;
			h = 0.6 - (22 / 250);
		};

		class Title: life_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = 100001;
			text = "帮派建筑管理";
			x = 0;
			y = 0.2;
			w = 0.75;
			h = (1 / 25);
		};
	};

	class controls {
		class ButtonClose: life_RscButtonMenu {
			idc = -1;
			colorBackground[] = {0,0,0,0.8};
			text = "$STR_Global_Close";
			onButtonClick = "[100000, 'fadeOnly', false] spawn OEC_fnc_animateDialog;";
			x = 0;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class BuildingInfo: life_RscStructuredText {
			idc = 100061;
			text = "";
			x = 0.24;
			y = 0.27;
			w = 0.50;
			h = 0.2;
		};

		class LightsButton: life_RscButtonMenu {
			idc = 100050;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.07;
			w = 0.20;
			h = 0.038;
		};

		class VirtualStorageButton: life_RscButtonMenu {
			idc = 100051;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.12;
			w = 0.20;
			h = 0.038;
		};

		class PhysicalStorageButton: life_RscButtonMenu {
			idc = 100052;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.17;
			w = 0.20;
			h = 0.038;
		};

		class UnlockButton: life_RscButtonMenu {
			idc = 100053;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.22;
			w = 0.20;
			h = 0.038;
		};

		class LockButton: life_RscButtonMenu {
			idc = 100054;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.27;
			w = 0.20;
			h = 0.038;
		};

		class UnlockPhysical: life_RscButtonMenu {
			idc = 100055;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.37;
			w = 0.20;
			h = 0.038;
		};

		class UnlockStorage: life_RscButtonMenu {
			idc = 100056;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.32;
			w = 0.20;
			h = 0.038;
		};

		class GaragePull: life_RscButtonMenu {
			idc = 100058;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.42;
			w = 0.20;
			h = 0.038;
		};

		class GarageStore: life_RscButtonMenu {
			idc = 100059;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.47;
			w = 0.20;
			h = 0.038;
		};

		class oilButton: life_RscButtonMenu {
			idc = 100062;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.37;
			w = 0.20;
			h = 0.038;
		};

		class PayButton: life_RscButtonMenu {
			idc = 100060;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.42;
			w = 0.20;
			h = 0.038;
		};

		class SellButton: life_RscButtonMenu {
			idc = 100057;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.47;
			w = 0.20;
			h = 0.038;
		};

		class AddGangVehicle: life_RscButtonMenu {
			idc = 100063;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.32;
			w = 0.20;
			h = 0.038;
		};
	};
};