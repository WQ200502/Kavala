class yMenuPhone : yMenuBase
{
	idd = 34000;
	onLoad = "[3,nil,34000] spawn OEC_fnc_smartphone; ctrlEnable [34006,false]";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "手机";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
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
		class MessageTitle : Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 34003;
			text = "";
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
		class Tab5: BaseTab5{
			onButtonClick = "";
		};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class SelAMsg : Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 34002;
			text = "选择一条消息";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25 + 0.3 + (1 / 25);
			w = 0.46;
			h = 0.04;
		};

		class MessageList : Life_RscListNBox
		{
			idc = 34004;
			onLBSelChanged = "[(lbCurSel 34004)] spawn OEC_fnc_showMsg; ctrlEnable [34006,true]";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorBackground[] = {0, 0, 0, 0.0};
			columns[] = {0,0.4};
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.3;
		};

		class TextShow : Life_RscControlsGroup {
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.64;
			w = 0.46;
			h = 0.25;
			class HScrollbar : HScrollbar {
				height = 0;
			};
			class controls {
				class showText : Life_RscStructuredText {
					//idc = 88887;
					idc = 34005;
					text = "";
					colorBackground[] = {0.28,0.28,0.28,0.28};
					size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					shadow = 0;
					x = 0;
					y = 0;
					w = 0.45;
					h = 1;
				};
			};
		};

		class ComposeButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "电话&消息";
			onButtonClick = "['Life_newMsg'] spawn OEC_fnc_createDialog;";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.89;
			w = 0.152;
			h = (1 / 25);
		};

		class ServicesButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "服务&打车";
			onButtonClick = "['Life_Services'] spawn OEC_fnc_createDialog;";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			x = (((safeZoneX + safeZoneW) - 0.47) + 0.153) + 0.153;
			y = 0.89;
			w = 0.152;
			h = (1 / 25);
		};

		class ReplyButtonMenu : Life_RscButtonMenu {
			idc = 34006;
			text = "回复";
			onButtonClick = "[(lnbData [34004,[(lnbCurSelRow 34004),0]])] call OEC_fnc_reply";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			x = ((safeZoneX + safeZoneW) - 0.47) + 0.153;
			y = 0.89;
			w = 0.152;
			h = (1 / 25);
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = 34001;
			text = "关闭";
			onButtonClick = "[34000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};

class Life_newMsg : yMenuBase
{
	idd = 34100;
	onLoad = "[0,nil,34100] spawn OEC_fnc_smartphone";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "手机";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
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
	};
	class controls : ControlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{
			onButtonClick = "";
		};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[34100, 'right', false] spawn OEC_fnc_animateDialog;";
		};
		class PlayerList : Life_RscListBox
		{
			idc = 34101;
			onLBSelChanged = "ctrlEnable [34102,true]; ctrlEnable [34103,true]";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.55;
		};
		class BackButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "返回";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			onButtonClick = "['yMenuPhone'] spawn OEC_fnc_createDialog";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.87;
			w = 0.46;
			h = 0.06;
		};
		class ComposeButton : Life_RscButtonMenu {
			idc = 34102;
			text = "发消息";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			onButtonClick = "[0,(lbData[34101,(lbCurSel 34101)])] spawn OEC_fnc_newMsg; ['Life_textMsg'] spawn OEC_fnc_createDialog";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.81;
			w = 0.46;
			h = 0.06;
		};
		class callphone : Life_RscButtonMenu {
			idc = 34103;
			text = "打电话";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			onButtonClick = "[true] spawn OEC_fnc_phoneCall";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.75;
			w = 0.46;
			h = 0.06;
		};
	};
};

class Life_textMsg : yMenuBase {
	idd = 34200;

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "手机";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
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
		class MessageTitle : Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = 34201;
			text = "发送给: ";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};
	class controls : ControlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{
			onButtonClick = "";
		};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		class TextEditMenu : Life_RscEdit {
			idc = 34202;
			text = "";
			sizeEx = 0.03;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.30;
			w = 0.46;
			h = 0.03;
		};
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[34200, 'right', false] spawn OEC_fnc_animateDialog";
		};
		class SendButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "发送";
			onButtonClick = "[1,-1,(ctrlText 34202)] call OEC_fnc_newMsg";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.35;
			w = 0.46;
			h = 0.06;
		};
		class PrivateAdminMsg : Life_RscButtonMenu {
			idc = 34203;
			text = "单独发送管理消息";
			onButtonClick = "[5,-1,(ctrlText 34202)] call OEC_fnc_newMsg";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.42;
			w = 0.46;
			h = 0.06;
		};
		class BackButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "返回";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			onButtonClick = "['Life_newMsg'] spawn OEC_fnc_createDialog";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.87;
			w = 0.46;
			h = 0.06;
		};
	};
};

class Life_Services : yMenuBase {
	idd = 34300;
	onLoad = "[0] spawn OEC_fnc_services; [true] spawn OEC_fnc_eventMessages";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "手机";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{};
		class Tab5PictureBackground: BaseTab5PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab6PictureBackground: BaseTab6PictureBackground{};
		class Tab7PictureBackground: BaseTab7PictureBackground{};
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
		class MessageTitle : Life_RscTitle {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			idc = -1;
			text = "管理员消息";
			sizeEx = 0.04;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.20;
			w = 0.46;
			h = 0.04;
		};
	};

	class controls : ControlsBase {
		class Tab1: BaseTab1{};
		class Tab2: BaseTab2{};
		class Tab3: BaseTab3{};
		class Tab4: BaseTab4{};
		class Tab5: BaseTab5{
			onButtonClick = "";
		};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		class TextEditMenu : Life_RscEdit {
			idc = 34301;
			text = "";
			sizeEx = 0.03;
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.30;
			w = 0.46;
			h = 0.03;
		};
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[34300, 'right', false] spawn OEC_fnc_animateDialog";
		};
		class SendButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "发送";
			onButtonClick = "[1] spawn OEC_fnc_services";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.35;
			w = 0.46;
			h = 0.06;
		};
		class dididache : Life_RscButtonMenu {
			idc = -1;
			text = "滴滴打车";
			onButtonClick = "[] spawn OEC_fnc_Taxi";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			x = safeZoneX + safeZoneW * 0.80664063;
			y = safeZoneY + safeZoneH * 0.46701389;
			w = safeZoneW * 0.18945313;
			h = safeZoneH * 0.03298612;
		};
		class dididafeiji : Life_RscButtonMenu {
			idc = -1;
			text = "滴滴打飞机";
			onButtonClick = "[] spawn OEC_fnc_Air";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			x = safeZoneX + safeZoneW * 0.80664063;
			y = safeZoneY + safeZoneH * 0.515625;
			w = safeZoneW * 0.18945313;
			h = safeZoneH * 0.03298612;
		};
		class SendToText : Life_RscText {
			idc = -1;
			text = "发送至:";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.64;
			h = (1 / 25);
		};
		class SendToDropDown : Life_RscCombo {
			idc = 34302;
			sizeEx = 0.04;
			x = ((safeZoneX + safeZoneW) - 0.47) + 0.1;
			y = 0.25;
			w = 0.2;
			h = 0.04;
		};
		class BackButtonMenu : Life_RscButtonMenu {
			idc = -1;
			text = "返回";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
			onButtonClick = "['yMenuPhone'] spawn OEC_fnc_createDialog";
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.87;
			w = 0.46;
			h = 0.06;
		};
	};
};
