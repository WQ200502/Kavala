class life_gang_bank_history {
	idd = 100300;
	name = "life_gang_bank_history";
	movingEnable = 0;
	enableSimulation = 1;
	//onLoad = "";

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText	{
			idc = -1;
			x = 0;
			y = -0.004;
			w = 1;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class MainBackground: Life_RscText {
			idc = -1;
			x = 0;
			y = 0.036;
			w = 1;
			h = 0.92;
			colorBackground[] = {0,0,0,0.7};
		};
	};

	class controls {
		class Title: Life_RscTitle {
			idc = 100301;

			text = "帮派银行分类账";
			x = 0;
			y = 0;
			w = 1;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class gangHistoryList: Life_RscListBox {
			idc = 100302;
			onLBSelChanged = "";
			type = 102;
			columns[] = {0.002,0.5,0.75};
			sizeEx = 0.0325;
			rowHeight = 0.04;
			idcLeft = -1;
			idcRight = -1;
			drawSideArrows = 0;
			maxHistoryDelay = 1;
			x = 0.01;
			y = 0.052;
			w = 0.98;
			h = 0.896;
		};

		class CloseButtonKey: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";
			idc = -1;
			text = "关闭";
			x = 0;
			y = 0.96;
			w = (6.25 / 40);
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
	};
};