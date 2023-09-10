class Life_Vehicle_Shop_v2
{
	idd = 2300;
	name="life_vehicle_shop";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "ctrlShow [2330,false];";

	class controlsBackground
	{
		class Life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1;
			y = 0.112;
			w = 0.8;
			h = 0.04;
		};

		class MainBackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1;
			y = 0.156;
			w = 0.8;
			h = 0.7;
		};

		class Title : Life_RscTitle
		{
			idc = 2301;
			text = "";
			x = 0.1;
			y = 0.112;
			w = 0.8;
			h = 0.04;
		};

		class VehicleTitleBox : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_ShopStock";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.11;
			y = 0.168;
			w = 0.3;
			h = 0.04;
		};

		class VehicleInfoHeader : Life_RscText
		{
			idc = 2330;
			text = "$STR_GUI_VehInfo";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.42;
			y = 0.168;
			w = 0.46;
			h = 0.04;
		};

		class CloseBtn : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class BuyCar : life_RscButtonMenu
		{
			idc = 2309;
			text = "$STR_Global_Buy";
			onButtonClick = "[true, false] spawn OEC_fnc_vehicleShopBuy;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class BuyCarModify : life_RscButtonMenu
		{
			idc = 2311;
			text = "购买和修改";
			onButtonClick = "[true, true] spawn OEC_fnc_vehicleShopBuy;";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};

	class controls
	{
		class VehicleList : Life_RscListBox
		{
			idc = 2302;
			text = "";
			sizeEx = 0.04;
			colorBackground[] = {0.1,0.1,0.1,0.9};
			onLBSelChanged = "_this call OEC_fnc_vehicleShopLBChange";

			x = 0.11;
			y = 0.214;
			w = 0.303;
			h = 0.626;
		};

		class ColorList : Life_RscCombo
		{
			idc = 2304;
			x = 0.42;
			y = 0.796;
			w = 0.275;
			h = 0.03;
		};

		class vehicleInfomationList : Life_RscStructuredText
		{
			idc = 2303;
			text = "";
			sizeEx = 0.035;
			x = 0.41;
			y = 0.22;
			w = 0.465;
			h = 0.564;
		};
	};
};
