class life_market_location {
	idd = 50600;
	movingEnable = 0;
	enableSimulation = 1;
	name = "life_market_location";

	class controlsBackground {
		class life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = -0.125;
			y = 0;
			w = 1.25;
			h = (1 / 25);
		};

		class MainBackground: Life_RscText {
			colorBackground[] = {0,0,0,1};
			idc = -1;
			x = -0.125;
			y = 0.04;
			w = 1.25;
			h = 0.96;
		};

		class Title: Life_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = -1;
			text = "位置选择";
			x = -0.125;
			y = 0;
			w = 1.25;
			h = (1 / 25);
		};

		class MapView: Life_RscMapControl {
			idc = 50678;
			x = 0.2875;
			y = 0.08;
			w = 0.8125;
			h = 0.88;
			maxSatelliteAlpha = 0.75;//0.75;
			alphaFadeStartScale = 1.15;//0.15;
			alphaFadeEndScale = 1.29;//0.29;
			widthRailWay = 1;
			onMouseButtonClick = "{deleteMarkerLocal _x;} foreach oev_houseMarketIcons; oev_houseMarketIcons = []; [_this,false] spawn OEC_fnc_houseMarketScan";
			onMouseButtonDblClick = "[_this,true] spawn OEC_fnc_houseMarketScan;";
		};
	};
	class controls {
		class closeButton: Life_RscButtonMenu {
			idc = 50680;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "关闭";
			onButtonClick = "closeDialog 0;";
			x = -0.125;
			y = 1;
			w = 0.3125;
			h = (1 / 25);
		};
		class BuildingInfo: life_RscStructuredText {
			idc = 50681;
			text = "";
			x = -0.1;
			y = 0.08;
			w = 0.3625;
			h = 0.88;
		};
	};
};