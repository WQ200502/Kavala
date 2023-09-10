class Life_Voting_Booth {
	idd = 99111;
	name= "Life_Voting_Booth";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "['setup'] spawn OEC_fnc_votingBooth";

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			text = "投票亭";
			x = 0.125;
			y = 0.13;
			w = 0.7625;
			h = 0.04;
		};

		class MainBackground: Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.125;
			y = 0.18;
			w = 0.7625;
			h = 0.56;
		};

		class VotingBar: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			text = "候选人";
			x = 0.1375;
			y = 0.2;
			w = 0.2375;
			h = 0.04;
		};

		class DescriptionBar: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			text = "描述";
			x = 0.4125;
			y = 0.2;
			w = 0.45;
			h = 0.04;
		};
	};

	class controls {
		class DescriptionBox: Life_RscStructuredText {
			idc = 99113;
			text = "";
			x = 0.4125;
			y = 0.26;
			w = 0.45;
			h = 0.46;
			colorBackground[] = {0,0,0,0.7};
		};

		class VoteList: Life_RscListBox {
			idc = 99112;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "['LBSelChanged'] spawn OEC_fnc_votingBooth";
			x = 0.1375;
			y = 0.26;
			w = 0.2375;
			h = 0.46;
			colorBackground[] = {0,0,0,0.7};
		};

		class CloseButtonKey: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.725;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
		class YesButton: Life_RscButtonMenu {
			idc = 99115;
			text = "投票";
			colorBackground[] = {0.9,0.5,0.1,1};
			onButtonClick = "['vote'] spawn OEC_fnc_votingBooth";
			x = 0.125;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
	};
};