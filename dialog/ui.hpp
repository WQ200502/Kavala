class playerHUD {
	idd=-1;
	duration = 1e+1000;
	movingEnable=0;
	fadein=0;
	fadeout=0;
	name="playerHUD";
	onLoad="uiNamespace setVariable ['playerHUD',_this select 0]";
	objects[]={};

	class controls
	{
		class mainBackground: Life_RscBackground
		{
			fade = 0;
			idc = -1;

			x = (safeZoneX + safeZoneW) - 0.22;
			y = (safeZoneY + safeZoneH) - 0.28;
			w = 0.22;
			h = 0.28;
			colorText[] = {0.1,0.1,0.1,1};
			colorBackground[] = {0,0,0,0};
		};


		//---------------------- PERCENTAGE BARS
		class iconEarplugs: Life_RscPicture {
			idc = 23528;
			fade = 0;
			x = (safeZoneX + safeZoneW) - 0.05;
			y = (safeZoneY + safeZoneH) - 0.33;
			w = 0.03;
			h = 0.04;
			text = "\a3\ui_f\data\GUI\Cfg\Hints\Voice_ca.paa";
			shadow = 2;
		};


		//---------------------- PERCENTAGE BARS
		class barStamina: Life_RscProgress{
			idc = 23527;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.26;
			w = 0.16;
			h = 0.04;
		};

		class barFood: Life_RscProgress{
			idc = 23502;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.21;
			w = 0.16;
			h = 0.04;
		};

		class barWater: Life_RscProgress{
			idc = 23512;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.16;
			w = 0.16;
			h = 0.04;
		};

		class barHealth: Life_RscProgress{
			idc = 23517;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.11;
			w = 0.16;
			h = 0.04;
		};

		class barWanted: Life_RscProgress{
			idc = 23522;
			colorBar[] = {1,0,0,0.7};

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.06;
			w = 0.16;
			h = 0.04;
		};


		//--------------------------------TEXT FOR BARS
		class staminaText: Life_RscText{
			idc = 23525;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.26;
			w = 0.12;
			h = 0.04;
		};

		class foodText: Life_RscText{
			idc = 23500;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.21;
			w = 0.08;
			h = 0.04;
		};

		class waterText: Life_RscText{
			idc = 23510;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.16;
			w = 0.08;
			h = 0.04;
		};

		class healthText: Life_RscText{
			idc = 23515;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.11;
			w = 0.08;
			h = 0.04;
		};

		class wantedText: Life_RscText{
			idc = 23520;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.17;
			y = (safeZoneY + safeZoneH) - 0.06;
			w = 0.16;
			h = 0.04;
		};

		//---------------- ICONS
		class iconStamina: Life_RscPicture{
			idc = 23526;
			fade = 0;

			text = "images\icons\olympus_inventory.paa"; //--- ToDo: Localize;
			x = (safeZoneX + safeZoneW) - 0.21;
			y = (safeZoneY + safeZoneH) - 0.26;
			w = 0.03;
			h = 0.04;
		};

		class iconFood: Life_RscPicture{
			idc = 23501;
			fade = 0;

			text = "images\icons\olympus_food.paa"; //--- ToDo: Localize;
			x = (safeZoneX + safeZoneW) - 0.21;
			y = (safeZoneY + safeZoneH) - 0.21;
			w = 0.03;
			h = 0.04;
		};

		class iconWater: Life_RscPicture{
			idc = 23511;
			fade = 0;

			text = "images\icons\olympus_water.paa"; //--- ToDo: Localize;
			x = (safeZoneX + safeZoneW) - 0.21;
			y = (safeZoneY + safeZoneH) - 0.16;
			w = 0.03;
			h = 0.04;
		};

		class iconHealth: Life_RscPicture{
			idc = 23516;
			fade = 0;

			text = "images\icons\olympus_health.paa"; //--- ToDo: Localize;
			x = (safeZoneX + safeZoneW) - 0.21;
			y = (safeZoneY + safeZoneH) - 0.11;
			w = 0.03;
			h = 0.04;
		};

		class iconWanted: Life_RscPicture{
			idc = 23521;
			fade = 0;

			text = "images\icons\olympus_bounty.paa"; //--- ToDo: Localize;
			x = (safeZoneX + safeZoneW) - 0.21;
			y = (safeZoneY + safeZoneH) - 0.06;
			w = 0.03;
			h = 0.04;
		};

		//Admin HUD for toggles
		class textGodmode: life_RscStructuredText{
			idc = 23529;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.16;
			y = (safeZoneY + safeZoneH) - 0.37;
			w = 0.16;
			h = 0.04;
		};

		class textInvis: life_RscStructuredText{
			idc = 23530;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.12;
			y = (safeZoneY + safeZoneH) - 0.40;
			w = 0.12;
			h = 0.04;
		};

		class textESP: life_RscStructuredText{
			idc = 23531;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.12;
			y = (safeZoneY + safeZoneH) - 0.43;
			w = 0.12;
			h = 0.04;
		};

		class textStase: life_RscStructuredText{
			idc = 23532;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.14;
			y = (safeZoneY + safeZoneH) - 0.46;
			w = 0.14;
			h = 0.04;
		};

		class textStreamer: life_RscStructuredText{
			idc = 23533;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.16;
			y = (safeZoneY + safeZoneH) - 0.49;
			w = 0.16;
			h = 0.04;
		};

		class textFly: life_RscStructuredText{
			idc = 23534;
			fade = 0;

			x = (safeZoneX + safeZoneW) - 0.12;
			y = (safeZoneY + safeZoneH) - 0.52;
			w = 0.12;
			h = 0.04;
		};
	};
};

class conqHUD {
	idd=-1;
	duration = 1e+1000;
	movingEnable=0;
	fadein=0;
	fadeout=0;
	name="conqHUD";
	onLoad="uiNamespace setVariable ['conqHUD',_this select 0]";
	objects[]={};

	class controlsBackground {
		class prizeText: Life_RscText {
			idc = 23800;
			fade = 0;
			shadow = 1;
			style = 0;

			text = "";
			x = safeZoneX + 0.03;
			y = safeZoneY + 0.64;
			w = 0.4;
			h = 0.04;
			colorText[] = {0,0.8,0.6,1};
			colorShadow[] = {0,0,0,0.2};
		};
		class yourPlace: prizeText {
			idc = 23804;
			fade = 0;
			shadow = 1;
			style = 0;

			text = "";
			y = safeZoneY + 0.44;
			colorText[] = {0.95,0.95,0.95,1};
			colorShadow[] = {0,0,0,0.2};
		};
		class onePlace: yourPlace {
			idc = 23801;
			fade = 0;
			shadow = 1;
			style = 0;

			text = "";
			y = safeZoneY + 0.5;
			colorText[] = {1,0.8,0,1};
		};
		class twoPlace: yourPlace {
			idc = 23802;

			text = "";
			y = safeZoneY + 0.54;
			colorText[] = {0.95,0.95,0.95,1};
		};
		class threePlace: yourPlace {
			idc = 23803;

			text = "";
			y = safeZoneY + 0.58;
			colorText[] = {0.68,0.54,0.37,1};
		};
		class scoreDivider: Life_RscBackground {
			fade = 0;
			idc = -1;

			x = safeZoneX + 0.03;
			y = safeZoneY + 0.48;
			w = 0.3;
			h = 0.001;
			colorBackground[] = {1,1,1,0.7};
		};
		class prizeDivider: Life_RscBackground {
			fade = 0;
			idc = -1;

			x = safeZoneX + 0.03;
			y = safeZoneY + 0.64;
			w = 0.3;
			h = 0.001;
			colorBackground[] = {1,1,1,0.7};
		};
	};
};
