class propertyKeys {
	idd = 37500;
	name = "propertyKeys";
	location = "bottom";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "[0] spawn OEC_fnc_managePropertyKeys;";

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText {
			idc = -1;

			x = 0.2;
			y = 0.38;
			w = 0.5875;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class MainBackground: Life_RscText {
			idc = -1;

			x = 0.2;
			y = 0.38;
			w = 0.5875;
			h = 0.36;
			colorBackground[] = {0,0,0,0.7};
		};

		class Title: Life_RscTitle {
			idc = -1;
			text = "物业钥匙管理";

			x = 0.2;
			y = 0.34;
			w = 0.575;
			h = 0.12;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class Description: Life_RscStructuredText {
			idc = -1;
			text = "拥有钥匙的玩家无法在该物业产生或出售该物业。 您可以更改锁以清除具有钥匙的玩家列表。"; //--- ToDo: Localize;
			sizeEx = 0.015;

			x = 0.2125;
			y = 0.42;
			w = 0.575;
			h = 0.12;
		};
	};

	class controls {

		class NearPlayers: Life_RscCombo{
			idc = 37501;
			x = 0.2125;
			y = 0.56;
			w = 0.3125;
			h = 0.04;
		};

		class HouseKeyholders: Life_RscCombo{
			idc = 37502;
			x = 0.2125;
			y = 0.62;
			w = 0.3125;
			h = 0.04;
		};

		class GiveKey: Life_RscButton {
			idc = -1;
			text = "给钥匙";
			onButtonClick = "[1] spawn OEC_fnc_managePropertyKeys";

			x = 0.5625;
			y = 0.56;
			w = 0.2;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};

		class RemoveKey: Life_RscButton {
			idc = -1;
			text = "移除钥匙";
			onButtonClick = "[3] spawn OEC_fnc_managePropertyKeys";

			x = 0.5625;
			y = 0.62;
			w = 0.2;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};

		class ChangeLocks: Life_RscButton {
			idc = -1;
			text = "换锁";
			onButtonClick = "[2] spawn OEC_fnc_managePropertyKeys";

			x = 0.2125;
			y = 0.68;
			w = 0.175;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};

		class Close: Life_RscButton {
			idc = -1;
			text = "取消";
			onButtonClick = "[37500, 'bottom', false] spawn OEC_fnc_animateDialog;";

			x = 0.5875;
			y = 0.68;
			w = 0.175;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
		};
	};
};

