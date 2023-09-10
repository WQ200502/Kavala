class Life_Hitman_Contract {
	idd = 99220;
	name= "Life_Hitman_Contract";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "[] spawn OEC_fnc_hitmanContract";

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			text = "杀手合同请求";
			x = 0.125;
			y = 0.135;
			w = 0.275;
			h = 0.04;
		};

		class MainBackground: Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.125;
			y = 0.18;
			w = 0.275;
			h = 0.56;
		};

		class ContractTitle: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			style = 2;
			text = "合同要求";
			x = 0.1375;
			y = 0.2;
			w = 0.2475;
			h = 0.04;
		};

		class TargetTitle: Life_RscText {
			idc = -1;
			style = 2;
			text = "选择目标";
			x = 0.1375;
			y = 0.25;
			w = 0.2475;
			h = 0.04;
		};

		class BountyTitle: Life_RscText {
			idc = -1;
			style = 2;
			text = "输入赏金";
			x = 0.1375;
			y = 0.35;
			w = 0.2475;
			h = 0.04;
		};

		class totalPriceTitle: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			style = 2;
			text = "总成本";
			x = 0.1375;
			y = 0.485;
			w = 0.2475;
			h = 0.04;
		};

		class activeContractTitle: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			style = 2;
			text = "有效合同";
			x = 0.41;
			y = 0.2;
			w = 0.4;
			h = 0.04;
		};
	};

	class controls {

		class bountyEdit : Life_RscCombo {
			idc = 99221;
			style = 2;
			sizeEx = 0.04;
			x = 0.1375;
			y = 0.4;
			w = 0.2475;
			h = 0.04;
		};

		class totalBounty: Life_RscText {
			idc = 99223;
			text = "赏金: $0";
			x = 0.1375;
			y = 0.535;
			w = 0.2475;
			h = 0.04;
		};

		class totalFee: Life_RscText {
			idc = 99224;
			text = "费用: $0";
			x = 0.1375;
			y = 0.585;
			w = 0.2475;
			h = 0.04;
		};

		class totalPrice: Life_RscText {
			idc = 99225;
			text = "总计: $0";
			x = 0.1375;
			y = 0.635;
			w = 0.2475;
			h = 0.04;
		};

		class PlayerList: Life_RscCombo	{
			idc = 99222;
			x = 0.1375;
			y = 0.3;
			w = 0.2475;
			h = (1 / 25);
			colorBackground[] = {0,0,0,0.7};
		};

		class contractList : Life_RscListBox {
			idc = 99227;
			sizeEx = 0.03;
			x = 0.41;
			y = 0.245;
			w = 0.4;
			h = 0.488;
		};

		class CloseButtonKey: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.243;
			y = 0.75;
			w = 0.15625;
			h = 0.04;
		};

		class YesButton: Life_RscButtonMenu {
			idc = 99226;
			text = "发行命中";
			style = 2;
			colorBackground[] = {0.54,0,0,1};
			onButtonClick = "[] spawn OEC_fnc_issueHit;";
			x = 0.137;
			y = 0.685;
			w = 0.2475;
			h = 0.04;
		};
	};
};