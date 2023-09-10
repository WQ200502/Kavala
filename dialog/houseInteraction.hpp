class houseAvailable {
	idd = 109000;
	location = "bottom";
	movingEnable = 1;
	enableSimulation = 1;

	class controlsBackground {
		class Background: Life_RscText {
			idc = -1;
			x = 0.1;
			y = (safeZoneY + safeZoneH) - 0.475;
			w = 0.8;
			h = 0.475;
			colorBackground[] = {0,0,0,0.6};
		};


		class HouseName: Life_RscText {
			idc = 109001;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "房屋名称";
			sizeEx = 0.04;
			x = 0.19;
			y = (safeZoneY + safeZoneH) - 0.475;
			w = 0.71;
			h = 0.04;
		};

		class HouseValue: HouseName {
			idc = 109002;
			style = 1;//align right
			text = "价值: $***,***";
			colorBackground[] = {0,0,0,0};
		};

		class HousePictureBackground: Life_RscText {
			idc = -1;

			x = 0.1;
			y = (safeZoneY + safeZoneH) - 0.475;
			w = 0.09;
			h = 0.09 * 4 / 3;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
		};

		class HousePicture: Life_RscPicture {
			idc = -1;
			text = "images\icons\house.paa";

			x = 0.11;
			y = (safeZoneY + safeZoneH) - 0.465;
			w = 0.07;
			h = 0.07 * 4 / 3;
		};
	};

	class controls {
		class HouseInfoMsg: Life_RscText {
			idc = 109003;
			text = "";

			x = 0.19;
			y = (safeZoneY + safeZoneH) - 0.415;
			w = 0.71;
			h = 0.04;
		};

		class TextLine1: Life_RscText {
			idc = 109004;
			text = "";

			x = 0.1;
			y = (safeZoneY + safeZoneH) - 0.345;
			w = 0.71;
			h = 0.04;
		};

		class TextLine2: TextLine1 {
			idc = 109005;
			text = "";
			y = (safeZoneY + safeZoneH) - 0.295;
		};

		class TextLine3: TextLine2 {
			idc = 109006;
			text = "";
			y = (safeZoneY + safeZoneH) - 0.245;
		};

		class TextLine4: TextLine3 {
			idc = 109007;
			text = "";
			y = (safeZoneY + safeZoneH) - 0.195;
		};

		class BuyHouse: Life_RscButton {
			idc = 109008;
			text = "";
			x = 0.11;
			y = (safeZoneY + safeZoneH) - 0.135;
			w = 0.1875;
			h = 0.05;
		};

		class AdminCheckKeys: Life_RscButton {
			idc = 109009;
			text = "";
			x = 0.31;
			y = (safeZoneY + safeZoneH) - 0.135;
			w = 0.1875;
			h = 0.05;
		};

		class ButtonClose: Life_RscButton {
			idc = -1;
			text = "关闭";
			onButtonClick = "[109000, 'bottom', false] spawn OEC_fnc_animateDialog;";

			x = 0.1;
			y = (safeZoneY + safeZoneH) - 0.075;
			w = 0.8;
			h = 0.075;
			colorText[] = {0.7,0.7,0.7,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
		};
	};
};
