class yMenuGroups : yMenuBase
{
	idd = 36000;
	onLoad = "[false] spawn OEC_fnc_groupManagement;";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家群组";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
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

		class GroupName : Life_RscText{
			idc = 36001;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "群组名";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{
			onButtonClick = "";
		};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class GroupMemberList: Life_RscListBox {
			idc = 36002;
			text = "";
			sizeEx = 0.035;

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.54;
		};

		class GroupLeave: Life_RscButton{
			idc = 36003;
			text = "离开";
			onButtonClick = "[] call OEC_fnc_leaveGroup";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.80;
			w = 0.145; // 0.225
			h = 0.05;
		};

		class GroupLock: GroupLeave{
			idc = 36004;
			text = "上锁";
			onButtonClick = "[] call OEC_fnc_lockGroup";

			x = (safeZoneX + safeZoneW) - 0.315;
		};

		class GroupUnlock: GroupLeave{
			idc = 36005;
			text = "解锁";
			onButtonClick = "[] call OEC_fnc_unlockGroup";

			x = (safeZoneX + safeZoneW) - 0.315;
		};

		class GroupLeader: GroupLeave{
			idc = 36006;
			text = "设置组长";
			onButtonClick = "[] call OEC_fnc_setGroupLeader";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.86;
		};

		class GroupKick: GroupLeader{
			idc = 36007;
			text = "踢出";
			onButtonClick = "[] call OEC_fnc_kickGroup";

			x = (safeZoneX + safeZoneW) - 0.315;
		};

		class GroupPassword: GroupLeader{
			idc = 36008;
			text = "设置密码";
			onButtonClick = "[ctrlText 36009] call OEC_fnc_changeGroupPassword";

			x = (safeZoneX + safeZoneW) - 0.155;
			y = 0.80;
		};

		class GroupPasswordText : Life_RscEdit {
			idc = 36009;
			text = "";
			sizeEx = 0.03;
			x = (safeZoneX + safeZoneW) - 0.155;
			y = 0.86;
			w = 0.145; // 0.225
			h = 0.05;
		};

		class GroupMemberCount : Life_RscText {
			idc = 36010;
			text = "";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.044;
			y = 0.17;
			w = 0.1; // 0.225
			h = 0.1;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[36000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class yMenuBrowseGroups : yMenuBase
{
	idd = 36100;
	onLoad = "[] spawn OEC_fnc_groupBrowser";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家群组";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
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

		class GroupName : Life_RscText{
			idc = 36101;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "组管理-当前组";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{
			onButtonClick = "[] spawn OEC_fnc_groupMenu;";
		};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class GroupMemberList: Life_RscListBox {
			idc = 36102;
			text = "";
			sizeEx = 0.035;

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.60;
		};

		class GroupJoin: Life_RscButton{
			idc = 36103;
			text = "加入";
			onButtonClick = "[] call OEC_fnc_joinGroup";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.86;
			w = 0.225;
			h = 0.05;

		};

		class GroupCreate: GroupJoin{
			idc = 36104;
			text = "创建新的";
			onButtonClick = "['yMenuCreateGroup'] spawn OEC_fnc_createDialog;";

			x = (safeZoneX + safeZoneW) - 0.235;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[36100, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class yMenuCreateGroup : yMenuBase
{
	idd = 36200;

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家群组";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
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

		class GroupName : Life_RscText{
			idc = 36201;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "群组管理-创建群组";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{
			onButtonClick = "[] spawn OEC_fnc_groupMenu;";
		};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class InfoMsg: Life_RscStructuredText{
			idc = -1;
			sizeEx = 0.020;
			text = "为您的群组选择一个名称。 团体是可以自由组建的。";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.1;
		};

		class createGroupText: Life_RscEdit{
			idc = 36202;
			text = "";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.35;
			w = 0.46;
			h = 0.04;
		};

		class PasswordMsg: Life_RscStructuredText{
			idc = -1;
			sizeEx = 0.020;
			text = "选择锁定组的密码。";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.4;
			w = 0.46;
			h = 0.1;
		};

		class passwordGroupText: Life_RscEdit{
			idc = 36205;
			text = "";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.5;
			w = 0.46;
			h = 0.04;
		};

		class GroupCreate: Life_RscButton{
			idc = 36203;
			text = "创建";
			onButtonClick = "[] call OEC_fnc_createGroup";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.55;
			w = 0.225;
			h = 0.05;
		};

		class GroupCancelCreation: GroupCreate{
			idc = 36204;
			text = "取消";
			onButtonClick = "[] spawn OEC_fnc_groupMenu;";

			x = (safeZoneX + safeZoneW) - 0.235;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[36200, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class yMenuJoinGroup : yMenuBase
{
	idd = 36300;

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "玩家群组";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab8PictureBackground: BaseTab8PictureBackground{};
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

		class GroupName : Life_RscText{
			idc = 36301;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "组管理-加入组";

			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};


	class controls : controlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{
			onButtonClick = "[] spawn OEC_fnc_groupMenu;";
		};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class InfoMsg: Life_RscStructuredText{
			idc = -1;
			sizeEx = 0.020;
			text = "密码";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.05;
		};

		class passwordGroupText: Life_RscEdit{
			idc = 36302;
			text = "";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.3;
			w = 0.46;
			h = 0.04;
		};

		class GroupEnter: Life_RscButton{
			idc = 36303;
			text = "进入";
			onButtonClick = "[] call OEC_fnc_joinGroup";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.4;
			w = 0.225;
			h = 0.05;
		};

		class GroupCancelJoin: GroupEnter{
			idc = 36304;
			text = "取消";
			onButtonClick = "[] spawn OEC_fnc_groupMenu;";

			x = (safeZoneX + safeZoneW) - 0.235;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[36300, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};
