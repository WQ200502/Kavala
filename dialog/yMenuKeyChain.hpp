class yMenuKeyChain : yMenuBase
{
	idd = 33000;
	onLoad = "[] spawn OEC_fnc_updateKeyChainTab;";

	class controlsBackground : controlsBackgroundBase {
		class Background: BaseBackground{};
		class Title: BaseTitle{
			text = "钥匙链";
		};

		class Tab1PictureBackground: BaseTab1PictureBackground{};
		class Tab2PictureBackground: BaseTab2PictureBackground{};
		class Tab3PictureBackground: BaseTab3PictureBackground{};
		class Tab4PictureBackground: BaseTab4PictureBackground{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.5};
		};
		class Tab5PictureBackground: BaseTab5PictureBackground{};
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

		class KeysTitle : Life_RscText{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "钥匙链上的钥匙";

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
		class Tab4: BaseTab4{
			onButtonClick = "";
		};
		class Tab5: BaseTab5{};
		class Tab6: BaseTab6{};
		class Tab7: BaseTab7{};
		class Tab8: BaseTab8{};
		class Tab9: BaseTab9{};
		class Tab10: BaseTab10{};
		class Tab11: BaseTab11{};
		class Tab12: BaseTab12{};
		//Content can be added below this line ---------

		class KeyChainList : Life_RscListBox {
			idc = 33001;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "private _dialog = (findDisplay 33000); private _list = _dialog displayCtrl 33001; private _vehicle = _list lbData (lbCurSel _list); _vehicle = oev_vehicles select parseNumber(_vehicle); _vehicleClass = getText(configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'vehicleClass'); if(_vehicleClass in ['Car','Air','Ship','Armored','Submarine'] && !(_vehicle getVariable['marked',false]) && !(_vehicle getVariable['isBlackwater',false]) && !(_vehicle getVariable['bait',false])) then {(_dialog displayCtrl 33008) ctrlShow true;} else {(_dialog displayCtrl 33008) ctrlShow false;};";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.25;
			w = 0.46;
			h = 0.46;
		};

		class markVeh: Life_RscButton{
			idc = 33008;
			text = "标记";
			onButtonClick = "private _list = (findDisplay 33000) displayCtrl 33001; private _vehicle = _list lbData (lbCurSel _list); _vehicle = oev_vehicles select parseNumber(_vehicle); _vehicle call OEC_fnc_markVehicle;";
		
			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.74;
			w = 0.225;
			h = 0.05;
		};
		
		class GiveKey: Life_RscButton{
			idc = 33002;
			text = "给与";
			onButtonClick = "[] call OEC_fnc_keyGive";

			x = (safeZoneX + safeZoneW) - 0.47;
			y = 0.80;
			w = 0.225;
			h = 0.05;
		};

		class DropKey: GiveKey{
			idc = 33003;
			text = "丢弃";
			onButtonClick = "[] call OEC_fnc_keyDrop";

			y = 0.86;
		};

		class NearPlayers: Life_RscCombo{
			idc = 33004;

			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.80;
			w = 0.225;
			h = 0.05;
		};

		class UnderColors: NearPlayers{
			idc = 33006;
			y = 0.74;
		};

		class UnderApply: GiveKey{
			idc = 33007;
			text = "切换暗光";
			onButtonClick = "[vehicle player] spawn OEC_fnc_handleGlow";
			y = 0.74;
		};
		class ReportStolen: Life_RscButton {
			idc = 33005;
			text = "报告被盗";
			onButtonClick = "private _list = (findDisplay 33000) displayCtrl 33001; private _vehicle = _list lbData (lbCurSel _list); _vehicle = oev_vehicles select parseNumber(_vehicle); [_vehicle] call OEC_fnc_reportStolen;";

			x = (safeZoneX + safeZoneW) - 0.235;
			y = 0.86;
			w = 0.225;
			h = 0.05;
		};

		//Do not edit below
		class ButtonClose: BaseButtonClose{
			idc = -1;
			text = "关闭";
			onButtonClick = "[33000, 'right', false] spawn OEC_fnc_animateDialog;";
		};
	};
};
