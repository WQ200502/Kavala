class depositBox {
	idd = 80000;
	movingEnable = 1;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.6;
			h = 0.4;
		};
	};

	class controls {
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "存款箱";
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "[80000, 'grow', false] spawn OEC_fnc_animateDialog;";
			x = 0.1;
			y = 0.644;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class ClaimButtonKey : Life_RscButtonMenu {
			idc = 80002;
			text = "拿取";
			onButtonClick = "[80000, 'grow', false] spawn OEC_fnc_animateDialog; [] spawn OEC_fnc_depositClaim;";
			x = 0.54375;
			y = 0.644;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class depositInfo : Life_RscListBox {
			idc = 80001;
			sizeEx = 0.04;
			onLBSelChanged = "if ((lbSize 80001) > 0) then {ctrlEnable [80002,true]}";
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.6;
			h = 0.4;
		};
	};
};