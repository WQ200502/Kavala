class conquestVote  {
	idd = 70002;
	onLoad = "[] spawn OEC_fnc_conqVoteMenu;";
	class controlsBackground {
		class life_RscTitleBackground: Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
		  x = -0.1;
			y = -0.06;
      w = 1.25;
			h = 0.04;
		};
		class MainBackground: Life_RscText {
			colorBackground[] = {0.1,0.1,0.1,0.8};
			idc = -1;
			x = -0.1;
			y = -0.02;
			w = 1.25;
			h = 0.97;
		};
		class Title: Life_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = -1;
			text = "征服投票";
			x = -0.1;
			y = -0.11;
			w = 1.25;
			h = 0.14;
		};
	};

	class controls {
		class voteButton: Life_RscButtonMenu {
			idc = 70003;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "投票";
			onButtonClick = "if(oev_conquestSelected != -1) then {oev_conquest_add_vote = [oev_conquestSelected,getPlayerUID player]; publicVariableServer 'oev_conquest_add_vote'; player setVariable['votedConquest',true,true]; oev_conquestSelected = -1; closeDialog 0;} else {hint 'You need to select a location!'};";
			x = 0.329;
			y = 0.85;
			w = 0.4;
			h = 0.06;
		};

		class closeButton: Life_RscButtonMenu {
			idc = 70004;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "关闭";
			onButtonClick = "closeDialog 0;";
			x = 0.837;
			y = 0.95;
			w = 0.3125;
			h = 0.04;
		};

		class ghosthotelButton: Life_RscButton {
			idc = 70005;
			onButtonClick = "oev_conquestSelected = 1;";
			tooltip = "幽灵酒店";
			fade = 0;
			period = 0.8;
			x = -0.04;
			y = 0.02;
			w = 0.32;
			h = 0.23;
		};
		class ghosthotelPic: Life_RscPicture {
			idc = 70006;
			text = "images\conquest\ghosthotel.jpg";
			tooltip = "幽灵酒店";
			fade = 0;
			x = -0.02;
			y = 0.04;
			w = 0.28;
			h = 0.19;
		};

		class nifiButton: Life_RscButton {
			idc = 70007;
			onButtonClick = "oev_conquestSelected = 2;";
			tooltip = "尼菲";
			fade = 0;
			period = 0.8;
			x = 0.37;
			y = 0.02;
			w = 0.32;
			h = 0.23;
		};
		class nifiPic: Life_RscPicture {
			idc = 70008;
			text = "images\conquest\nifi.jpg";
			tooltip = "尼菲";
			fade = 0;
			x = 0.39;
			y = 0.04;
			w = 0.28;
			h = 0.19;
		};

		class kavalaButton: Life_RscButton {
			idc = 70009;
			onButtonClick = "oev_conquestSelected = 3;";
			tooltip = "卡瓦拉";
			fade = 0;
			period = 0.8;
			x = 0.78;
			y = 0.02;
			w = 0.32;
			h = 0.23;
		};
		class kavalaPic: Life_RscPicture {
			idc = 70010;
			text = "images\conquest\kavala.jpg";
			tooltip = "卡瓦拉";
			fade = 0;
			x = 0.80;
			y = 0.04;
			w = 0.28;
			h = 0.19;
		};

		class syrtaButton: Life_RscButton {
			idc = 70011;
			onButtonClick = "oev_conquestSelected = 4;";
			tooltip = "锡尔塔";
			fade = 0;
			period = 0.8;
			x = -0.04;
			y = 0.30;
			w = 0.32;
			h = 0.23;
		};
		class syrtaPic: Life_RscPicture {
			idc = 70012;
			text = "images\conquest\syrta.jpg";
			tooltip = "锡尔塔";
			fade = 0;
			x = -0.02;
			y = 0.32;
			w = 0.28;
			h = 0.19;
		};

		class oreokastroButton: Life_RscButton {
			idc = 70013;
			onButtonClick = "oev_conquestSelected = 5;";
			tooltip = "奥雷奥卡斯特罗";
			fade = 0;
			period = 0.8;
			x = 0.37;
			y = 0.30;
			w = 0.32;
			h = 0.23;
		};
		class oreokastroPic: Life_RscPicture {
			idc = 70014;
			text = "images\conquest\oreokastro.jpg";
			tooltip = "奥雷奥卡斯特罗";
			fade = 0;
			x = 0.39;
			y = 0.32;
			w = 0.28;
			h = 0.19;
		};

		class warzoneButton: Life_RscButton {
			idc = 70015;
			onButtonClick = "oev_conquestSelected = 6;";
			tooltip = "战区";
			fade = 0;
			period = 0.8;
			x = 0.78;
			y = 0.30;
			w = 0.32;
			h = 0.23;
		};
		class warzonePic: Life_RscPicture {
			idc = 70016;
			text = "images\conquest\warzone.jpg";
			tooltip = "战区";
			fade = 0;
			x = 0.80;
			y = 0.32;
			w = 0.28;
			h = 0.19;
		};

		// class northWarzoneButton: Life_RscButton {
		// 	idc = 70017;
		// 	onButtonClick = "oev_conquestSelected = 7;";
		// 	tooltip = "North Warzone";
		// 	fade = 0;
		// 	period = 0.8;
		// 	x = -0.04;
		// 	y = 0.58;
		// 	w = 0.32;
		// 	h = 0.23;
		// };
		// class northWarzonePic: Life_RscPicture {
		// 	idc = 70018;
		// 	text = "images\conquest\northWarzone.jpg";
		// 	tooltip = "North Warzone";
		// 	fade = 0;
		// 	x = -0.02;
		// 	y = 0.60;
		// 	w = 0.28;
		// 	h = 0.19;
		// };

		class panagiaButton: Life_RscButton {
			idc = 70019;
			onButtonClick = "oev_conquestSelected = 8;";
			tooltip = "巴拿马";
			fade = 0;
			period = 0.8;
			x = 0.165;
			y = 0.58;
			w = 0.32;
			h = 0.23;
		};
		class panagiaPic: Life_RscPicture {
			idc = 70020;
			text = "images\conquest\panagia.jpg";
			tooltip = "巴拿马";
			fade = 0;
			x = 0.185;
			y = 0.60;
			w = 0.28;
			h = 0.19;
		};

		class sofiaButton: Life_RscButton {
			idc = 70021;
			onButtonClick = "oev_conquestSelected = 9;";
			tooltip = "索菲亚";
			fade = 0;
			period = 0.8;
			x = 0.575;
			y = 0.58;
			w = 0.32;
			h = 0.23;
		};
		class sofiaPic: Life_RscPicture {
			idc = 70022;
			text = "images\conquest\sofia.jpg";
			tooltip = "索菲亚";
			fade = 0;
			x = 0.595;
			y = 0.60;
			w = 0.28;
			h = 0.19;
		};
	};
};
