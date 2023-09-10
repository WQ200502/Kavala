class Life_atm_management {
	idd = 2700;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "oev_bankMode = 0";
	onUnload = "oev_bankMode = nil;";

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
			y = 0.24;
			w = 0.3;
			h = 0.665;
		};
	};

	class controls {
		class CashTitle: Life_RscStructuredText {
			idc = 2701;
			text = "";
			x = 0.39;
			y = 0.26;
			w = 0.3;
			h = .14;
		};

		class Title: Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_ATM_Title";
			x = 0.35;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};

		class WithdrawButton: life_RscButtonMenu {
			idc = 2709;
			text = "$STR_ATM_Withdraw";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_bankWithdraw";
			x = 0.43;
			y = 0.46;
			w = (6 / 40);
			h = (1 / 25);
		};


		class DepositButton: life_RscButtonMenu {
			idc = 2707;
			text = "$STR_ATM_Deposit";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[false] call OEC_fnc_bankDeposit";
			x = 0.432;
			y = 0.512;
			w = (6 / 40);
			h = (1 / 25);
		};

		class DepositAllButton: life_RscButtonMenu {
			idc = 2708;
			text = "全部存入";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[true] call OEC_fnc_bankDeposit";
			x = 0.43;
			y = 0.56;
			w = (6 / 40);
			h = (1 / 25);
		};


		class moneyEdit: Life_RscEdit {
			idc = 2702;
			text = "0";
			sizeEx = 0.030;
			x = 0.4;
			y = 0.41;
			w = 0.2;
			h = 0.03;
		};

		class PlayerList: Life_RscCombo	{
			idc = 2703;
			x = 0.4;
			y = 0.63;
			w = 0.2;
			h = 0.03;
		};

		class TransferButton: life_RscButtonMenu {
			idc = 2705;
			text = "$STR_ATM_Transfer";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] spawn OEC_fnc_bankTransfer; ctrlEnable[2705,false];";

			x = 0.43;
			y = 0.68;
			w = 0.15;
			h = (1 / 25);
		};

		class ManageWarPoints: life_RscButtonMenu {
			idc = 2706;
			text = "管理战争点";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_bankWarPointToggle;";
			y = 0.74;
			x = 0.365;
			w = 0.27;
			h = (1 / 25);
		};

		class GangDeposit: life_RscButtonMenu {
			idc = 2704;
			text = "管理帮派资金";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] call OEC_fnc_gangAtmMenu; ctrlEnable[2704,false];[]spawn{sleep 0.5; ctrlEnable[2704,true];};";
			y = 0.795;
			x = 0.365;
			w = 0.27;
			h = (1 / 25);
		};

		class CloseButtonKey: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.365;
			y = 0.85;
			w = 0.13;
			//w = 0.13;
			h = (1 / 25);
		};

		class DepositButtonKey: Life_RscButtonMenu {
			idc = -1;
			text = "存款箱";
			onButtonClick = "closeDialog 0; [] call OEC_fnc_clRedeemDepositBox;";
			x = 0.505;
			y = 0.85;
			w = 0.13;
			h = (1 / 25);
		};
	};
};
