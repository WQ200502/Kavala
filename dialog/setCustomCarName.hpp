class life_custom_car_name
{
	idd = 25555;
	name = "life_custom_car_name";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground :Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};

	class controls
	{
		class NameInput : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "您想给车辆起什么名字？";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class nameEdit : Life_RscEdit
		{
			idc = 5000;
			text = "";
			sizeEx = 0.030;
			x = 0.40; y = 0.30;
			w = 0.25; h = 0.03;
		};

		class Submit: Life_RscButtonMenu {
			idc = -1;
			text = "提交";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] spawn{_prompt = ['Are you sure you would like to rename your car? It will cost you $25,000.','Confirmation','Yes','No'] call BIS_fnc_guiMessage;if(_prompt) then {['setName'] spawn OEC_fnc_setCarName;};};";
			x = 0.45;
			y = 0.35;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class VehicleBox : Life_RscCombo
		{
			idc = 3000;
			x = 0.32;
			y = 0.4;
			w = 0.43;
			h = (1 / 25);
		};
	};
};
