class oev_progress {
	idd = -1;
	duration = 99999999999;
	movingEnable = 0;
	fadein = 0;
	fadeout = 0;
	name = "oev_progress";
	onLoad = "uiNamespace setVariable ['oev_progress',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class background: Life_RscBackground {
			idc = -1;
			fade = 0;
			colorBackground[] = {0.34,0.34,0.34,1};
			x = 0.36140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.69;
			h = 0.05;
		};
		class ProgressBar: Life_RscProgress {
			idc = 38251;
			colorFrame[] = {0,0,0,0};
			x = 0.36140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.69;
			h = 0.05;
		};
		class ProgressText: Life_RscText {
			idc = 38252;
			fade = 0;
			text = "...";
			x = 0.366 * safezoneW + safezoneX;
			y = 0.0635 * safezoneH + safezoneY;
			w = 0.69;
			h = (1 / 25);
		};
	};
};

class life_progress {
	name = "life_progress";
	idd = 38200;
	fadein=0;
	duration = 99999999999;
	fadeout=0;
	movingEnable = 0;
	onLoad="uiNamespace setVariable ['life_progress',_this select 0]";
	objects[]={};

	class controlsBackground {
		class background: Life_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.7};
			x = 0.36140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.69;
			h = 0.05;
		};
		class ProgressBar: Life_RscProgress {
			idc = 38201;
			x = 0.36140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.69;
			h = 0.05;
		};

		class ProgressText: Life_RscText {
			idc = 38202;
			fade = 0;
			text = "...";
			x = 0.366 * safezoneW + safezoneX;
			y = 0.0635 * safezoneH + safezoneY;
			w = 0.69;
			h = (1 / 25);
		};
	};
};

class life_timer {
	name = "life_timer";
	idd = 38300;
	fadeIn = 0;
	duration = 99999999999;
	fadeout = 0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['life_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = 38309;
			text = "\a3\ui_f\data\IGUI\RscTitles\MPProgress\timer_ca.paa";
			fade = 0;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.04;
			h = 0.045;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38301;
			text = "";
			shadow = 0;
			fade = 0;
			x = 0.0204688 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY;
			w = 0.09125 * safezoneW;
			h = 0.055 * safezoneH;
		};
	};
};

class pharma_timer {
	name = "pharma_timer";
	idd = 38311;
	fadeIn = 0;
	duration = 99999999999;
	fadeout = 0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['pharma_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "\a3\ui_f\data\IGUI\RscTitles\MPProgress\timer_ca.paa";
			fade = 0;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY + 0.06;
			w = 0.04;
			h = 0.045;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38312;
			text = "";
			shadow = 0;
			fade = 0;
			x = 0.0204688 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY + 0.06;
			w = 0.09125 * safezoneW;
			h = 0.055 * safezoneH;
		};
	};
};

class jail_timer {
	name = "jail_timer";
	idd = 38308;
	fadeIn = 0;
	duration = 99999999999;
	fadeout = 0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['jail_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "\a3\ui_f\data\IGUI\RscTitles\MPProgress\timer_ca.paa";
			fade = 0;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY - 0.06;
			w = 0.04;
			h = 0.045;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38309;
			text = "";
			shadow = 0;
			fade = 0;
			x = 0.0204688 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY - 0.06;
			w = 0.09125 * safezoneW;
			h = 0.055 * safezoneH;
		};
	};
};

class bank_timer {
	name = "bank_timer";
	idd = 38314;
	fadeIn = 0;
	duration = 99999999999;
	fadeout = 0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['bank_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "\a3\ui_f\data\IGUI\RscTitles\MPProgress\timer_ca.paa";
			fade = 0;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY - 0.12;
			w = 0.04;
			h = 0.045;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38315;
			text = "";
			shadow = 0;
			fade = 0;
			x = 0.0204688 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY - 0.12;
			w = 0.09125 * safezoneW;
			h = 0.055 * safezoneH;
		};
	};
};

class life_epi_timer {
	name = "life_epi_timer";
	idd = 38302;
	fadeIn = 1;
	duration = 99999999999;
	fadeout = 1;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['life_epi_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "images\icons\brokenheart.paa";
			fade = 0;
			style = 0x30 + 0x800;
			x = (safeZoneX + safeZoneW) - 0.11;
			y = (safeZoneY + safeZoneH) - 0.475;
			w = 0.06;
			h = 0.06;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38303;
			text = "";
			fade = 0;
			x = (safeZoneX + safeZoneW) - 0.1175;
			y = (safeZoneY + safeZoneH) - 0.425;
			w = 0.17;
			h = 0.04;
		};
	};
};

class life_kidney_timer {
	name = "life_epi_timer";
	idd = 38306;
	fadeIn = 1;
	duration = 99999999999;
	fadeout = 1;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['life_kidney_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "images\icons\injured.paa";
			fade = 0;
			style = 0x30 + 0x800;
			x = (safeZoneX + safeZoneW) - 0.11;
			y = (safeZoneY + safeZoneH) - 0.575;
			w = 0.06;
			h = 0.06;
		};
	};
};

class life_autorun {
	name = "life_autorun";
	idd = 38307;
	fadeIn = 1;
	duration = 99999999999;
	fadeout = 1;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['life_autorun',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "images\icons\olympus_autorun.paa";
			fade = 0;
			style = 0x30 + 0x800;
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 0.63;
			w = 0.06;
			h = 0.06;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38310;
			text = "";
			fade = 0;
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 0.575;
			w = 0.17;
			h = 0.04;
		};
	};
};

class life_lethal_flag {
	name = "life_lethal_flag";
	idd = 38304;
	fadeIn = 1;
	duration = 99999999999;
	fadeout = 1;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['life_lethal_flag',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: Life_RscPicture {
			idc = -1;
			text = "images\icons\lethals.paa";
			fade = 0;
			style = 0x30 + 0x800;
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 0.53;
			w = 0.06;
			h = 0.06;
		};

		class TimerText: life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38305;
			text = "";
			fade = 0;
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 0.475;
			w = 0.17;
			h = 0.04;
		};
	};
};

class oev_conq_timer {
	name = "oev_conq_timer";
	idd = 38500;
	fadeIn = 0;
	duration = 99999999999;
	fadeout = 0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['oev_conq_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class ConquestIcon: Life_RscPicture {
			idc = 38501;
			text = "images\icons\shield_white.paa";
			fade = 0;
			colorText[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			colorBackground[] = {0,0,0,0};
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 1.005;
			w = 0.1;
			h = 0.125;
		};

		class ConquestTextBackground: Life_RscText {
			idc = 38502;
			text = "";
			shadow = 0;
			fade = 0;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			colorText[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 0.8748;
			w = 0.1;
			h = 0.04;
		};

		class ConquestText: Life_RscStructuredText {
			idc = 38503;
			text = "";
			shadow = 0;
			fade = 0;
			colorBackground[] = {0,0,0,0};
			x = safeZoneX + 0.02;
			y = (safeZoneY + safeZoneH) - 0.8748;
			w = 0.1;
			h = 0.04;
		};
	};
};
