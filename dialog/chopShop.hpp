class Chop_Shop
{
	idd = 39400;
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};

		class MainBackGround : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1; y = 0.2 + (11 / 250);
			w = 0.32; h = 0.6 - (22 / 250);
		};

		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = -1;
			text = "$STR_ChopShop_Title";
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};

		class priceInfo : Life_RscStructuredText
		{
			idc = 39401;
			text = "";
			sizeEx = 0.035;
			x = 0.11; y = 0.68;
			w = 0.2; h = 0.2;
		};
	};

	class controls
	{
		class vehicleList : Life_RscListBox
		{
			idc = 39402;
			onLBSelChanged = "_this call OEC_fnc_chopShopSelection";
			sizeEx = 0.04;
			x = 0.11; y = 0.25;
			w = 0.3; h = 0.38;
		};

		class BtnSell : Life_RscButtonMenu
		{
			idc = 39403;
			text = "$STR_Global_Sell";
			onButtonclick = "[] call OEC_fnc_ClchopShopSell; ctrlEnable[39403,false];[]spawn{sleep 1; ctrlEnable[39403,true];};closeDialog 0;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class BtnClaim : Life_RscButtonMenu
		{
			idc = 39408;
			text = "拿取";
			onButtonclick = "[] call OEC_fnc_claimVehicle; ctrlEnable[39408,false];[]spawn{sleep 1; ctrlEnable[39408,true];};closeDialog 0;";
			x = 0.1;
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class BtnClose : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0";
			x = 0.1;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};

class Boat_Chop_Shop
{
	idd = 39404;
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};

		class MainBackGround : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1; y = 0.2 + (11 / 250);
			w = 0.32; h = 0.6 - (22 / 250);
		};

		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = -1;
			text = "$STR_ChopShop_Title";
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};

		class priceInfo : Life_RscStructuredText
		{
			idc = 39405;
			text = "";
			sizeEx = 0.035;
			x = 0.11; y = 0.68;
			w = 0.2; h = 0.2;
		};
	};

	class controls
	{
		class vehicleList : Life_RscListBox
		{
			idc = 39406;
			onLBSelChanged = "_this call OEC_fnc_chopShopBoatSelection";
			sizeEx = 0.04;
			x = 0.11; y = 0.25;
			w = 0.3; h = 0.38;
		};

		class BtnSell : Life_RscButtonMenu
		{
			idc = 39407;
			text = "$STR_Global_Sell";
			onButtonclick = "[] call OEC_fnc_ClchopShopBoatSell; ctrlEnable[39407,false];[]spawn{sleep 1; ctrlEnable[39407,true];};";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class BtnClose : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0";
			x = 0.1;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};
