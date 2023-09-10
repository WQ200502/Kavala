class yMenuGangs : yMenuBase {
	idd = 37000;
	onLoad = "[] spawn OEC_fnc_gangMenu;";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家帮派s";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};

		class GangName : Life_RscText{
			idc = 37001;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "帮派名称";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};

		class GangBank : GangName {
			idc = 37002;
			style = 1;//align right
			text = "";
			colorBackground[] = {0,0,0,0};
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{
			onButtonClick = "";
		};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class GangMemberList: Life_RscListBox {
			idc = 37003;
			text = "";
			sizeEx = 0.035;

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.35;
			h = 0.58;
		};

		class GangLeader: Life_RscButton{
			idc = 37004;
			text = "领导";
			onButtonClick = "[] spawn OEC_fnc_gangNewLeader";

			x = (safeZoneX + safeZoneW) - 0.11;
			y = 0.25;
			w = 0.1;
			h = 0.05;
		};

		class GangKick: GangLeader{
			idc = 37005;
			text = "提出";
			onButtonClick = "[] call OEC_fnc_gangKick";

			y = 0.31;
		};

		class GangLeave: GangLeader{
			idc = 37006;
			text = "离开";
			onButtonClick = "[] call OEC_fnc_gangLeave";

			y = 0.37;
		};

		class GangDisband: GangLeader{
			idc = 37007;
			text = "解散";
			onButtonClick = "[] spawn OEC_fnc_gangDisband";

			y = 0.43;
		};

		class GangInvite: GangLeader{
			idc = 37008;
			text = "邀请";
			onButtonClick = "[] spawn OEC_fnc_gang1InvitePlayer";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.84;
			w = 0.225;
			h = 0.05;
		};

		class AvailablePlayers : Life_RscCombo{
			idc = 37009;

			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.84;
			w = 0.225;
			h = 0.05;
		};

		class GangPromote: Life_RscButton{
			idc = 37010;
			text = "提升";
			onButtonClick = "[1] spawn OEC_fnc_manageRank;";

			x = (safeZoneX + safeZoneW) - 0.11;
			y = 0.55;
			w = 0.1;
			h = 0.05;
		};

		class GangDemote: GangPromote{
			idc = 37011;
			text = "降职";
			onButtonClick = "[2] spawn OEC_fnc_manageRank;";

			y = 0.61;
		};

		class GangWarView: GangPromote{
			idc = 37012;
			text = "战争";
			onButtonClick = "['yMenuGangWars'] spawn OEC_fnc_createDialog";

			y = 0.73;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[37000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class yMenuCreateGang: yMenuBase {
	idd = 37100;
	onLoad = "[] spawn{((findDisplay 37100) displayCtrl 37102) ctrlSetText format['Cost: $%1 ',[(call oev_gangPrice)] call OEC_fnc_numberText];};";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家帮派";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};

		class GangName : Life_RscText{
			idc = 37101;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "创建帮派";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};

		class GangCost : GangName {
			idc = 37102;
			style = 1;//align right
			text = "";
			colorBackground[] = {0,0,0,0};
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{
			onButtonClick = "";
		};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class InfoMsg: Life_RscStructuredText{
			idc = -1;
			sizeEx = 0.020;
			text = "为你的帮派选择一个名字。没有不恰当的名字，例如种族歧视，恐怖分子的名字等。";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.15;
		};

		class createGangText: Life_RscEdit{
			idc = 37103;
			text = "";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.45;
			w = 0.46;
			h = 0.04;
		};

		class GangCreate: Life_RscButton{
			idc = 37104;
			text = "创建";
			onButtonClick = "[] call OEC_fnc_createGang";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.5;
			w = 0.46;
			h = 0.05;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[37100, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class yMenuGangWars: yMenuBase {
	idd = 37200;
	onLoad = "[] spawn OEC_fnc_warMenu;";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家帮派";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};

		class GangWarTitle: Life_RscText{
			idc = 37201;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "战争管理";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};


	class controls: controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{
			onButtonClick = "";
		};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class GangWarActives: Life_RscListBox {
			idc = 37202;
			text = "";
			sizeEx = 0.035;

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.35;
			h = 0.58;
		};

		class GangWarEndBtn: Life_RscButton{
			idc = 37203;
			text = "结束";
			onButtonClick = "";

			x = (safeZoneX + safeZoneW) - 0.11;
			y = 0.25;
			w = 0.1;
			h = 0.05;
		};

		class GangWarStatsBtn: GangWarEndBtn{
			idc = 37204;
			text = "统计数据";
			onButtonClick = "";

			y = 0.31;
		};

		class GangInvite: Life_RscButton{
			idc = 37205;
			text = "发起战争";
			onButtonClick = "";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.84;
			w = 0.225;
			h = 0.05;
		};

		class AvailGangWars: Life_RscCombo{
			idc = 37206;
			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.84;
			w = 0.225;
			h = 0.05;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[37200, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class yMenuGangWarStats: yMenuBase {
	idd = 37300;
	onLoad = "";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家帮派";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
		class Tab8PictureBackground: BaseTab8PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab9PictureBackground: BaseTab9PictureBackground{};
		class Tab10PictureBackground: BaseTab10PictureBackground{};
		class Tab11PictureBackground: BaseTab11PictureBackground{};
		class Tab12PictureBackground: BaseTab12PictureBackground{};
		class Tab1Picture: BaseTab1Picture{};
		class Tab2Picture: BaseTab2Picture{};
		class Tab3Picture: BaseTab3Picture{};
		class Tab4Picture: BaseTab4Picture{};
		class Tab5Picture: BaseTab5Picture{};
		class Tab6Picture: BaseTab6Picture{};
		class Tab7Picture: BaseTab7Picture{};
		class Tab8Picture: BaseTab8Picture{};
		class Tab9Picture: BaseTab9Picture{};
		class Tab10Picture: BaseTab10Picture{};
		class Tab11Picture: BaseTab11Picture{};
		class Tab12Picture: BaseTab12Picture{};

		class GangWarStatsTitle: Life_RscText{
			idc = 37301;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "战争统计";

			sizeEx = 0.03;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};

	class controls: controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{
			onButtonClick = "";
		};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class GangWarGKills: life_RscText {
			idc = 37302;
			text = "帮派杀手：加载。。。";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.4;
			h = 0.04;
		};
		class GangWarGDeaths: GangWarGKills {
			idc = 37303;
			text = "帮派死亡：加载。。。";

			y = 0.30;
		};
		class GangWarEKills: GangWarGKills {
			idc = 37304;
			text = "敌人杀死：加载。。。";

			y = 0.35;
		};
		class GangWarEDeaths: GangWarGKills {
			idc = 37305;
			text = "敌人的死亡：加载。。。";

			y = 0.40;
		};
		class GangWarLength: GangWarGKills {
			idc = 37306;
			text = "有效期为x天";

			y = 0.50;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[37300, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};