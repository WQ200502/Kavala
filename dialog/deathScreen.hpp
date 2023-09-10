class DeathScreen
{
	idd = 7300;
	name = "Life_Death_Screen";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
	};

	class Controls
	{
		class MedicsOnline : Life_RscText
		{
			idc = 7304;
			colorBackground[] = {0,0,0,0};
			text = "医生在线: 0";
			x = 0.00190622 * safezoneW + safezoneX;
			y = 0.0292 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class MedicsNearby : Life_RscText
		{
			idc = 7305;
			colorBackground[] = {0,0,0,0};
			text = "附近的医务人员：无";
			x = 0.00190622 * safezoneW + safezoneX;
			y = 0.0492 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class MedicsRank : Life_RscText
		{
			idc = 7310;
			colorBackground[] = {0,0,0,0};
			text = "最高等级：无";
			x = 0.00190622 * safezoneW + safezoneX;
			y = 0.0692 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class RespawnBtn : Life_RscButtonMenu
		{
			idc = 7302;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			text = "开始新的生活";
			onButtonClick = "['respawn'] call OEC_fnc_requestMedic;";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.7};
			class Attributes
			{
				align = "center";
			};
		};

		class DummyBtn : Life_RscButtonMenu
		{
			idc = -1;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.0292 * safezoneH + safezoneY;
			w = 0.0015;
			h = 0.0015;
			onButtonClick = "";
			text = "";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.7};
			class Attributes
			{
				align = "center";
			};
		};

		class MedicBtn : Life_RscButtonMenu
		{
			idc = 7303;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.0292 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			onButtonClick = "['request'] call OEC_fnc_requestMedic;";
			text = "请求在线医生";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.7};
			class Attributes
			{
				align = "center";
			};
		};

		class EpipenBtn : Life_RscButtonMenu
		{
			idc = 7307;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.05339999 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			onButtonClick = "[] call OEC_fnc_allowRevive;";
			text = "我还可以抢救";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.7};
			class Attributes
			{
				align = "center";
			};
		};

		class adminDead : Life_RscButtonMenu
		{
			idc = 7322;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.07759998 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			onButtonClick = "if(call life_adminlevel < 1) then {hint 'Insufficient Permissions';} else {[player getVariable ['oev_corpse', objNull], true] spawn OEC_fnc_revivePlayer; [[""event"",""Admin revived themself while dead""], [""player"",name player], [""player_id"", getPlayerUID player], [""location"", getPos player]] call OEC_fnc_logIt;};";
			text = "管理员复活";
			colorBackground[] = {1,0,0,0.7};
			class Attributes
			{
				align = "center";
			};
		};

		class respawnTime : Life_RscStructuredText
		{
			idc = 7301;
			colorBackground[] = {0,0,0,0};
			text = "";
			x = (safeZoneX + (safeZoneWAbs / 2)) - (0.8 / 2);
			y = 0.918 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class bleedOutTime : Life_RscStructuredText
		{
			idc = 7308;
			colorBackground[] = {0,0,0,0};
			text = "";
			x = (safeZoneX + (safeZoneWAbs / 2)) - (0.8 / 2);
			y = 0.943 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class killerInfo : Life_RscStructuredText
		{
			idc = 7309;
			colorBackground[] = {0,0,0,0};
			text = "";
			x = (safeZoneX + (safeZoneWAbs / 2)) - (0.8 / 1.5);
			y = 0.0556 * safezoneH + safezoneY;
			w = 1.1;
			h = (1 / 25);
		}

		class dispatchReply : Life_RscStructuredText
		{
			idc = 7306;
			colorBackground[] = {0,0,0,0};
			text = "";
			x = (safeZoneX + (safeZoneWAbs / 2)) - (0.8 / 1.5);
			y = 0.0776 * safezoneH + safezoneY;
			w = 1.1;
			h = (1 / 25);
		};
	};
};
