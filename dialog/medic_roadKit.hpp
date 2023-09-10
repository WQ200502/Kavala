class life_medic_roadKit {
	idd = 7365;
	name= "life_medic_roadKit";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "['load'] spawn OEC_fnc_roadKit";

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.4;
		};
	};
	class controls {
		class PickupList: Life_RscListBox {
			idc = 2857;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "";
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.4;
			colorBackground[] = {0,0,0,0.7};
		};
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "公路工具箱";
			x = 0.35;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		class SelectButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "选择";
			onButtonClick = "['select'] spawn OEC_fnc_roadKit";
			x = 0.35;
			y = 0.2 + (11 / 250) + 0.4;
			w = (0.3/2);
			h = (1 / 25);
		};
		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.35 + (0.3/2);
			y = 0.2 + (11 / 250) + 0.4;
			w = (0.3/2);
			h = (1 / 25);
		};
	};
};
