class pInteraction_Menu {
	idd = 37400;
	location = "fadeOnly";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};

		class MainBackground: life_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.7};
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.6 - (22 / 250);
		};

		class Title: life_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "$STR_pInAct_Title";
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};
	};

	class controls {
		class ButtonClose: life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "[37400, 'fadeOnly', false] spawn OEC_fnc_animateDialog;";
			x = 0.35;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class ButtonOne: life_RscButtonMenu {
			idc = 37450;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.07;
			w = 0.24;
			h = 0.038;
		};

		class ButtonTwo: life_RscButtonMenu {
			idc = 37451;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.12;
			w = 0.24;
			h = 0.038;
		};

		class ButtonThree: life_RscButtonMenu {
			idc = 37452;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.17;
			w = 0.24;
			h = 0.038;
		};

		class ButtonFour: life_RscButtonMenu {
			idc = 37453;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.22;
			w = 0.24;
			h = 0.038;
		};

		class ButtonFive: life_RscButtonMenu {
			idc = 37454;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.27;
			w = 0.24;
			h = 0.038;
		};

		class ButtonSix: life_RscButtonMenu {
			idc = 37455;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.32;
			w = 0.24;
			h = 0.038;
		};

		class ButtonSeven: life_RscButtonMenu {
			idc = 37456;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.37;
			w = 0.24;
			h = 0.038;
		};

		class ButtonEight: life_RscButtonMenu {
			idc = 37457;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.42;
			w = 0.24;
			h = 0.038;
		};

		class ButtonNine: life_RscButtonMenu {
			idc = 37458;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.47;
			w = 0.24;
			h = 0.038;
		};
	};
};

class vInteraction_Menu {
	idd = 37400;
	location = "fadeOnly";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class RscTitleBackground: life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};

		class MainBackground: life_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.7};
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.55 - (22 / 250);
		};

		class Title: life_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "$STR_vInAct_Title";
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};
	};

	class controls {
		class ButtonClose: life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "[37400, 'fadeOnly', false] spawn OEC_fnc_animateDialog;";
			x = 0.35;
			y = 0.75 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class ButtonMark: life_RscButtonMenu {
			idc = 444444;
			text = "标记车辆";
			onButtonClick = "life_vInact_curTarget spawn OEC_fnc_markVehicle; closeDialog 0;";
			x = 0.5075;
			y = 0.75 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class ButtonOne: life_RscButtonMenu {
			idc = 37450;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.07;
			w = 0.24;
			h = 0.038;
		};

		class ButtonTwo: life_RscButtonMenu {
			idc = 37451;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.12;
			w = 0.24;
			h = 0.038;
		};

		class ButtonThree: life_RscButtonMenu {
			idc = 37452;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.17;
			w = 0.24;
			h = 0.038;
		};

		class ButtonFour: life_RscButtonMenu {
			idc = 37453;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.22;
			w = 0.24;
			h = 0.038;
		};

		class ButtonFive: life_RscButtonMenu {
			idc = 37454;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.27;
			w = 0.24;
			h = 0.038;
		};

		class ButtonSix: life_RscButtonMenu {
			idc = 37455;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.32;
			w = 0.24;
			h = 0.038;
		};

		class ButtonSeven: life_RscButtonMenu {
			idc = 37456;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.37;
			w = 0.24;
			h = 0.038;
		};

		class ButtonEight: life_RscButtonMenu {
			idc = 37457;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.35 + 0.03;
			y = 0.2 + 0.42;
			w = 0.24;
			h = 0.038;
		};
	};
};
