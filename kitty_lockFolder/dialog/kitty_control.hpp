class dialogTest
{
	idd = 1234;
	
	class controls
	{
		class baseFrame: IGUIBack
		{
			idc = 1800;

			x = 0.407227 * safezoneW + safezoneX;
			y = 0.323957 * safezoneH + safezoneY;
			w = 0.175238 * safezoneW;
			h = 0.451109 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class buttonOne: RscButton
		{
			idc = 1600;
			action = "null = ['1'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "1"; //--- ToDo: Localize;
			x = 0.417535 * safezoneW + safezoneX;
			y = 0.400976 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonTwo: RscButton
		{
			idc = 1601;
			action = "null = ['2'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "2"; //--- ToDo: Localize;
			x = 0.47423 * safezoneW + safezoneX;
			y = 0.400976 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonThree: RscButton
		{
			idc = 1602;
			action = "null = ['3'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "3"; //--- ToDo: Localize;
			x = 0.530924 * safezoneW + safezoneX;
			y = 0.400976 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonFour: RscButton
		{
			idc = 1603;
			action = "null = ['4'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "4"; //--- ToDo: Localize;
			x = 0.417535 * safezoneW + safezoneX;
			y = 0.477995 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonFive: RscButton
		{
			idc = 1604;
			action = "null = ['5'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "5"; //--- ToDo: Localize;
			x = 0.47423 * safezoneW + safezoneX;
			y = 0.477995 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonSix: RscButton
		{
			idc = 1605;
			action = "null = ['6'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "6"; //--- ToDo: Localize;
			x = 0.530924 * safezoneW + safezoneX;
			y = 0.477995 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonSeven: RscButton
		{
			idc = 1606;
			action = "null = ['7'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "7"; //--- ToDo: Localize;
			x = 0.417535 * safezoneW + safezoneX;
			y = 0.555013 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonEight: RscButton
		{
			idc = 1607;
			action = "null = ['8'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "8"; //--- ToDo: Localize;
			x = 0.47423 * safezoneW + safezoneX;
			y = 0.555013 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonNine: RscButton
		{
			idc = 1608;
			action = "null = ['9'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "9"; //--- ToDo: Localize;
			x = 0.530924 * safezoneW + safezoneX;
			y = 0.555013 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonZero: RscButton
		{
			idc = 1609;
			action = "null = ['0'] execVM 'kitty_lockFolder\actions\addToText.sqf'";

			text = "0"; //--- ToDo: Localize;
			x = 0.47423 * safezoneW + safezoneX;
			y = 0.632032 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
		};
		class buttonEnter: RscButton
		{
			idc = 1610;
			action = "null = [cursorObject] execVM 'kitty_lockFolder\actions\enterPressed.sqf'";

			text = "Enter"; //--- ToDo: Localize;
			x = 0.417535 * safezoneW + safezoneX;
			y = 0.632032 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
			colorText[] = {-1,1,-1,1};
		};
		class buttonClose: RscButton
		{
			idc = 1611;
			action = "closeDialog 1";

			text = "Close"; //--- ToDo: Localize;
			x = 0.530924 * safezoneW + safezoneX;
			y = 0.709051 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
			colorText[] = {1,-1,-1,1};
		};
		class inputText: RscText
		{
			idc = 1000;
			align = "center";

			x = 0.438151 * safezoneW + safezoneX;
			y = 0.345963 * safezoneH + safezoneY;
			w = 0.113389 * safezoneW;
			h = 0.033008 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class buttonLock: RscButton
		{
			idc = 1610;
			action = "null = [cursorObject] execVM 'kitty_lockFolder\actions\lockDoors.sqf'";

			text = "Lock"; //--- ToDo: Localize;
			x = 0.417535 * safezoneW + safezoneX;
			y = 0.709051 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
			colorText[] = {1,0,-1,1};
		};
		class buttonChange: RscButton
		{
			idc = 1610;
			action = "null = [cursorObject] execVM 'kitty_lockFolder\actions\setCode.sqf'";

			text = "Set Code"; //--- ToDo: Localize;
			x = 0.530924 * safezoneW + safezoneX;
			y = 0.632032 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
			colorText[] = {-1,1,-1,1};
		};
		class buttonClear: RscButton
		{
			idc = 1611;
			action = "ctrlSetText [1000, '']";

			text = "Clear"; //--- ToDo: Localize;
			x = 0.47423 * safezoneW + safezoneX;
			y = 0.709051 * safezoneH + safezoneY;
			w = 0.0412325 * safezoneW;
			h = 0.0550133 * safezoneH;
			colorText[] = {1,-1,-1,1};
		};
		class indicatorLocked: RscText
		{
			idc = 1001;
			align = "center";
			text = "";
			x = 0.407227 * safezoneW + safezoneX;
			y = 0.323957 * safezoneH + safezoneY;
			w = 0.0463866 * safezoneW;
			h = 0.0220053 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorText[] = {0, 0, 0, 1};
		};
	};
};