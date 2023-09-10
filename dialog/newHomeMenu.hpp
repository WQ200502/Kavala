class newHomeMenu {
	idd = 110000;
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
			idc = 110100;
			text = "House Management";
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
			onButtonClick = "[110000, 'fadeOnly', false] spawn OEC_fnc_animateDialog;";
			x = 0;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class housetextstruct: life_RscStructuredText {
			idc = 110001;
			text = "";
			x = 0.24;
			y = 0.27;
			w = 0.50;
			h = 0.2;
		};

		class housebtn1: life_RscButtonMenu {
			idc = 110002;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.07;
			w = 0.20;
			h = 0.038;
		};

		class housebtn2: life_RscButtonMenu {
			idc = 110003;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.12;
			w = 0.20;
			h = 0.038;
		};

		class housebtn3: life_RscButtonMenu {
			idc = 110004;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.17;
			w = 0.20;
			h = 0.038;
		};

		class housebtn4: life_RscButtonMenu {
			idc = 110005;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.22;
			w = 0.20;
			h = 0.038;
		};

		class housebtn5: life_RscButtonMenu {
			idc = 110006;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.27;
			w = 0.20;
			h = 0.038;
		};

		class housebtn6: life_RscButtonMenu {
			idc = 110007;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.32;
			w = 0.20;
			h = 0.038;
		};

		class housebtn7: life_RscButtonMenu {
			idc = 110008;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.37;
			w = 0.20;
			h = 0.038;
		};

		class housebtn8: life_RscButtonMenu {
			idc = 110009;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.42;
			w = 0.20;
			h = 0.038;
		};

		class housebtn9: life_RscButtonMenu {
			idc = 110010;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.03;
			y = 0.2 + 0.47;
			w = 0.20;
			h = 0.038;
		};

		class housebtn10: life_RscButtonMenu {
			idc = 110011;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.32;
			w = 0.20;
			h = 0.038;
		};

		class housebtn11: life_RscButtonMenu {
			idc = 110012;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.37;
			w = 0.20;
			h = 0.038;
		};

		class housebtn12: life_RscButtonMenu {
			idc = 110013;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.42;
			w = 0.20;
			h = 0.038;
		};

		class housebtn13: life_RscButtonMenu {
			idc = 110014;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.24;
			y = 0.2 + 0.47;
			w = 0.20;
			h = 0.038;
		};

		class housebtn14: life_RscButtonMenu {
			idc = 110015;
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
