class life_wantedadd2 {
	idd = 9900;
	name= "life_wantedadd2";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "[] spawn OEC_fnc_wanted2add;";

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.6 - (2 / 250);
		};
	};

	class controls {


		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2901;
			text = "通缉+";
			x = 0.1;
			y = 0.2;
			w = 0.7;
			h = (1 / 25);
		};

		class PlayerList_Admin : Life_RscListBox
		{
			idc = 9902;
			text = "";
			sizeEx = 0.035;
			//colorBackground[] = {0,0,0,0};
			onLBSelChanged = "[_this] spawn OEC_fnc_adminQuery";

			x = 0.11; y = 0.254;
			w = 0.3; h = 0.568;
		};


        class RSUCombo_2101: Life_RscListBox
        {
            idc = 9991;
			text = "";
			sizeEx = 0.035;
			x = 0.4325;
			y = 0.254;
			w = 0.4575;
			h = 0.568;
           // onLBSelChanged="call fnc_Cmb_changed;";
//--- action/function to call when listbox or combobox has been changed

        };



		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "关闭";
			onButtonClick = "closeDialog 0;";
			x = 0.09925;
			y = 0.84;
			w = 0.1575;
			h = 0.04;
		};


		class Adminwanted : Life_RscButtonMenu {
			idc = -1;
			text = "添加";
			onButtonClick = "[] call OEC_fnc_wanted3;";
			x = 0.26175;
			y = 0.84;
			w = 0.1575;
			h = 0.04;
		};



	};
};