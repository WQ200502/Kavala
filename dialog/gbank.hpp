class Life_gang_atm_management {
	idd = 3200;
	name= "life_gang_atm_menu";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};

		class MainBackground: Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.6 - (22 / 250);
		};
	};

	class controls {

		class CashTitle: Life_RscStructuredText {
			idc = 3201;
			text = "";
			x = 0.39;
			y = 0.26;
			w = 0.3;
			h = .14;
		};

		class Title: Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "帮派资金管理";
			x = 0.35;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class WithdrawButton: life_RscButtonMenu {
			idc = 3202;
			text = "$STR_ATM_Withdraw";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_gangWithdraw; ctrlEnable[3202,false];";
			x = 0.425;
			y = 0.46;
			w = (6 / 40);
			h = (1 / 25);
		};

		class DepositButton: life_RscButtonMenu {
			idc = 3203;
			text = "$STR_ATM_Deposit";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_gangDeposit; ctrlEnable[3203,false];";
			x = 0.425;
			y = 0.52;
			w = (6 / 40);
			h = (1 / 25);
		};

		class DepositAllButton: life_RscButtonMenu {
			idc = 3206;
			text = "全部存入";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[true] call OEC_fnc_gangDeposit; ctrlEnable[3206,false];";
			x = 0.425;
			y = 0.58;
			w = (6 / 40);
			h = (1 / 25);
		};

		class GFundHistory: life_RscButtonMenu {
			idc = 3205;
			text = "分帐";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_gangBankHist;";
			x = 0.425;
			y = 0.64;
			w = (6 / 40);
			h = (1 / 25);
		};

		class moneyEdit: Life_RscEdit {
			idc = 3204;
			text = "0";
			sizeEx = 0.030;
			x = 0.4;
			y = 0.41;
			w = 0.2;
			h = 0.03;
		};

		class CloseButtonKey: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.35;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};