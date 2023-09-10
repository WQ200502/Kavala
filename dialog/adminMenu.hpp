class life_admin_menu {
	idd = 2900;
	name= "life_admin_menu";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "[] spawn OEC_fnc_adminMenu;";

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText {
			idc = -1;
			x = 0;
			y = -0.004;
			w = 1.3;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};
		class MainBackground: Life_RscText {
			idc = -1;
			x = 0;
			y = 0.036;
			w = 1.3;
			h = 0.92;
			colorBackground[] = {0,0,0,0.7};
		};
	};

	class controls {
		class Title: Life_RscTitle {
			idc = 2901;
			text = "管理菜单";
			x = 0;
			y = 0;
			w = 0.9;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};
		class PlayerList_Admin: Life_RscListBox {
			idc = 2902;
			onLBSelChanged = "[_this] spawn OEC_fnc_adminQuery";
			sizeEx = 0.0325;
			x = 0.01;
			y = 0.052;
			w = 0.3;
			h = 0.896;
		};
		class PlayerBInfo: Life_RscStructuredText {
			idc = 2903;
			x = 0.3225;
			y = 0.5;
			w = 0.35;
			h = 0.6;
		};
		class moneyEdit: Life_RscEdit {
			idc = 2988;
			text = "1";
			x = 0.4865;
			y = 0.315;
			w = 0.15625;
			h = 0.04;
		};
		class textEdit: Life_RscEdit {
			idc = 2989;
			text = "";
			x = 0.4865;
			y = 0.36;
			w = 0.15625;
			h = 0.04;
		};


		class CloseButtonKey: Life_RscButtonMenu {
			onButtonClick = "closeDialog 0;";
			idc = 1005;
			text = "关闭";
			x = 0;
			y = 0.96;
			w = 1.00125 + .3;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManagerUpdate: Life_RscButtonMenu {
			onButtonClick = "[0, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1030;
			text = "重新启动=更新";
			x = 0;
			y = 1.01;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManagerHard: Life_RscButtonMenu {
			onButtonClick = "[1, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1031;
			text = "重新启动=硬";
			x = 0;
			y = 1.055;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManagerSoft: Life_RscButtonMenu {
			onButtonClick = "[2, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1032;
			text = "重新启动=软";
			x = 0;
			y = 1.1;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManager60mins: Life_RscButtonMenu {
			onButtonClick = "[3, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1033;
			text = "60分钟后重新启动";
			x = 0.255;
			y = 1.01;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManager30mins: Life_RscButtonMenu {
			onButtonClick = "[4, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1034;
			text = "30分钟后重新启动";
			x = 0.255;
			y = 1.055;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManager15mins: Life_RscButtonMenu {
			onButtonClick = "[5, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1035;
			text = "15分钟后重新启动";
			x = 0.255;
			y = 1.1;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class CycleManager120mins: Life_RscButtonMenu {
			onButtonClick = "[8, player] spawn OEC_fnc_adminCycleAdjust;";
			idc = 1036;
			text = "120分钟后重启";
			x = 0.255;
			y = 1.145;
			w = 0.25;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class AdminID: Life_RscButtonMenu {
			onButtonClick = "[] spawn{[] spawn OEC_fnc_adminTpMap; closeDialog 0; sleep 0.1; closeDialog 0;};";
			idc = 1006;
			text = "传送地图";
			x = 0.3175;
			y = 0.048;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class TpHere: Life_RscButtonMenu {
			onButtonClick = "[] spawn OEC_fnc_adminTpHere;";
			idc = 1008;
			text = "传送到这";
			x = 0.3175;
			y = 0.092;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class TpTo: Life_RscButtonMenu {
			onButtonClick = "[] spawn OEC_fnc_adminTpTo;";
			idc = 1008;
			text = "传送过去";
			x = 0.3175;
			y = 0.136;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class GiveMoney: Life_RscButtonMenu {
			onButtonClick = "[] call OEC_fnc_adminGiveMoney;";
			idc = 1010;
			text = "给钱";
			x = 0.3175;
			y = 0.315;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class SetText: Life_RscButtonMenu {
			onButtonClick = "oev_payload ctrlSetText (ctrlText 2989);";
			idc = 1069;
			text = "-";
			x = 0.3175;
			y = 0.36;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class TelePosition: Life_RscButtonMenu {
			onButtonClick = "[] call OEC_fnc_adminTpPos;";
			idc = 1040;
			text = "传送XYZ坐标";
			x = 0.4865 + .2675;
			y = 0.225;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class idealWeather: Life_RscButtonMenu {
			onButtonClick = "if(((player getVariable ['isInEvent',['no']]) isEqualTo ['no']) && (!(oev_conquestData select 0))) exitWith {hint 'You can only use this button during conquest or an event';};if(oev_changeWeatherCD <= time) then {[3] remoteExec ['OES_fnc_changeWeather', 2]; oev_changeWeatherCD = time + 300;} else {hint '请等一下再换天气！';};";
			idc = 1052;
			text = "理想天气";
			x = 0.4865 + .2675;
			y = 0.315;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class SetTimeDay: Life_RscButtonMenu {
			onButtonClick = "if(((player getVariable ['isInEvent',['no']]) isEqualTo ['no']) && (!(oev_conquestData select 0))) exitWith {hint 'You can only use this button during conquest or an event';};if(((date select 3) >= 14 || (date select 3) < 8) && oev_changeWeatherCD <= time) then {[0] remoteExec ['OES_fnc_changeWeather', 2]; oev_changeWeatherCD = time + 300;} else {hint '已经是白天了！';};";
			idc = 1042;
			text = "设定时间";
			x = 0.4865 + .2675;
			y = 0.315 + 0.045;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class DisableRain: Life_RscButtonMenu {
			onButtonClick = "if(((player getVariable ['isInEvent',['no']]) isEqualTo ['no']) && (!(oev_conquestData select 0))) exitWith {hint 'You can only use this button during conquest or an event';};if(oev_changeWeatherCD <= time) then {[1] remoteExec ['OES_fnc_changeWeather', 2]; oev_changeWeatherCD = time + 300;} else {hint '请等一下再换天气！';};";
			idc = 1043;
			text = "禁用雨";
			x = 0.4865 + .2675;
			y = 0.36 + 0.045;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class DisableFog: Life_RscButtonMenu {
			onButtonClick = "if(((player getVariable ['isInEvent',['no']]) isEqualTo ['no']) && (!(oev_conquestData select 0))) exitWith {hint 'You can only use this button during conquest or an event';};if(oev_changeWeatherCD <= time) then {[2] remoteExec ['OES_fnc_changeWeather', 2]; oev_changeWeatherCD = time + 300;} else {hint '请等一下再换天气！';};";
			idc = 1044;

			text = "禁用雾";
			x = 0.4865 + .2675;
			y = 0.405 + 0.045;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class ConquestStart: Life_RscButtonMenu {
			onButtonClick = "if(!(oev_conquestData select 0) && !(oev_conquestVote)) then {[-1,parseNumber(lbData[1046,lbCurSel(1046)])] remoteExec ['OES_fnc_conquestVoteServ', 2];(findDisplay 2900 displayCtrl 1047) ctrlShow true} else {hint '已经有征服或征服投票活动！';};";
			idc = 1045;
			text = "开始征服";
			x = 0.4865 + .2675;
			y = 0.45 + 0.045;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class ConquestCancel: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 2) then {if(oev_conquestData select 0 || oev_conquestVote) then {[_this select 0] spawn{_areYouSure = ['你确定要取消征服/征服投票吗？','取消征服','是','否'] call BIS_fnc_guiMessage;if !(_areYouSure) exitWith {};(_this select 0) ctrlShow false;['cancelConquest'] remoteExec ['OES_fnc_conquestServer', 2];}} else {hint '没有任何征服或征服投票活动！';};} else {hint 'Insufficient Permissions';(_this select 0) ctrlShow false;}";
			onLoad = "if(!(oev_conquestData select 0) && !(oev_conquestVote) || !(call life_adminlevel > 2)) then {(_this select 0) ctrlShow false};";
			idc = 1047;
			text = "取消征服";
			x = 0.4875;
			y = 0.405 + 0.045;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class AirdropStart: Life_RscButtonMenu {
			onButtonClick = "[player] remoteExec ['OES_fnc_airdropServer', 2];";
			idc = 1070;
			text = "开始空投";
			x = 0.4865 + .2675;
			y = 0.495 + 0.045;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class ConquestZone: Life_RscCombo {
			idc = 1046;
			x = 0.4875;
			y = 0.45 + 0.045;
			w = 0.24;
			h = 0.04;
		};

		class TelePosEdit: Life_RscEdit {
			idc = 1041;
			text = "[0,0,0]";
			x = 0.4865 + .2675;
			y = 0.27;
			w = 0.24;
			h = 0.04;
		};

		class DeleteCursor: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 0) then {deleteVehicle cursorTarget; closeDialog 0; [[""event"",""Admin Deleted Vehicle""], [""player"",name player], [""player_id"",getPlayerUID player], [""vehicle_type"", getText(configFile >> 'CfgVehicles' >> (typeOf _curTarget) >> 'displayName')]] call OEC_fnc_logIt;} else {hint '权限不足';};";
			idc = 1011;
			text = "删除光标";
			x = 0.4875;
			y = 0.048;
			w = 0.25375;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class takekeys: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel < 1) then {hint 'Insufficient Permissions';} else {[] spawn OEC_fnc_adminTakeKeys; closeDialog 0; hint '你现在有了目标车辆的钥匙。';};";
			idc = 1020;
			text = "获取钥匙";
			x = 0.4865 + .2675;
			y = 0.048;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class VehicleComp: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 2) then {closeDialog 0; [4] call OEC_fnc_adminItemComp;}else{hint 'Insufficient Permissions'};";
			idc = 1051;
			text = "管理车辆补偿";
			x = 0.4865 + .2675;
			y = 0.092;
			w = 0.24;
			h = 0.04;

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class massRevive: Life_RscButtonMenu {
			onButtonClick = "[]spawn{if(call life_adminlevel < 1) then {hint 'Insufficient Permissions';} else {_prompt = ['是否确实要复活整个服务器玩家？','确认批量复活','是','否',findDisplay 2900] call BIS_fnc_guiMessage;if(!_prompt) exitWith {};{if !(isNull (_x getVariable ['oev_corpse', objNull])) then {[_x getVariable ['oev_corpse', objNull],true,true] spawn OEC_fnc_revivePlayer;};uiSleep 0.5;} forEach playableUnits;[[""event"",""Admin Mass Revive""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;};};"
			idc = -1;
			text = "集体复活";
			x = 0.4865 + .2675;
			y = 0.136;
			w = 0.24;
			h = 0.04;
			colorText[] = {1,0.5,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class invison: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 2) then {[[0,player],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP; hint 'You are now invisible'; [[""event"",""Admin Invis Activated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;} else {hint 'Insufficient Permissions';};";
			idc = 1012;
			text = "隐身开";
			x = 0.4865;
			y = 0.092;
			w = 0.12375;
			h = 0.04;
			colorText[] = {0,1,0,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class invisoff: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 2) then {[[1,player],'OES_fnc_adminInvis',false,false] spawn OEC_fnc_MP; hint 'You are now visible'; [[""event"",""Admin Invis Disabled""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;} else {hint 'Insufficient Permissions';};";
			idc = 1013;
			text = "隐身关";
			x = 0.61725;
			y = 0.092;
			w = 0.12375;
			h = 0.04;
			colorText[] = {1,0,0,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class spectate: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 1) then {[] spawn OEC_fnc_adminEnhancedSpec; closeDialog 0;[[""event"",""Admin Enhanced Spectate Activated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;} else {hint 'Insufficient Permissions';};";
			idc = 1050;
			text = "旁观";
			x = 0.3175;
			y = 0.225;
			w = 0.15625;
			h = 0.04;

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class godon: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 1) then {player allowdamage false; hint 'God Mode On'; oev_godmode = true; [[""event"",""Admin God Activated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;} else {hint 'Insufficient Permissions';};";
			idc = 1015;
			text = "上帝模式开";
			x = 0.4865;
			y = 0.136;
			w = 0.12375;
			h = 0.04;
			colorText[] = {0,1,0,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class godoff: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel > 1) then {player allowdamage true; hint 'God Mode Off'; oev_godmode = false; [[""event"",""Admin God Disabled""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;} else {hint 'Insufficient Permissions';};";
			idc = 1016;
			text = "上帝模式关";
			x = 0.61725;
			y = 0.136;
			w = 0.12375;
			h = 0.04;
			colorText[] = {1,0,0,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class espon: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel < 1) then {hint 'Insufficient Permissions';} else {hint 'ESP Enabled.'; oev_eventESP = true; player setVariable['adminesp',true,true]; [[""event"",""Admin ESP Activated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;};";
			idc = 1018;
			text = "透视开";
			x = 0.4865;
			y = 0.18;
			w = 0.12375;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class espoff: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel < 1) then {hint 'Insufficient Permissions';} else {hint 'ESP Disabled'; oev_eventESP = false; player setVariable['adminesp',nil,true]; [[""event"",""Admin ESP Deactivated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;};";
			idc = 1019;
			text = "透视关";
			x = 0.61725;
			y = 0.18;
			w = 0.12375;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class sespon: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel < 2) then {hint 'Insufficient Permissions';} else {hint 'Silent ESP Enabled.'; oev_eventESP = true; [[""event"",""Admin SESP Activated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;};";
			idc = -1;
			text = "超级透视开";
			x = 0.4865 + .2675;
			y = 0.18;
			w = 0.11;
			h = 0.04;
			colorText[] = {0,1,0,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class sespoff: Life_RscButtonMenu {
			onButtonClick = "if(call life_adminlevel < 2) then {hint 'Insufficient Permissions';} else {hint 'Silent ESP Disabled'; oev_eventESP = false; player setVariable['adminesp',nil,true]; [[""event"",""Admin SESP Deactivated""], [""player"",name player], [""player_id"",getPlayerUID player]] call OEC_fnc_logIt;};";
			idc = -1;
			text = "超级透视关";
			x = 0.4865 + .2675 + .1307;
			y = 0.18;
			w = 0.11;
			h = 0.04;
			colorText[] = {1,0,0,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class veh_List: Life_RscListBox {
			idc = 1501;
			sizeEx = 0.0325;
			x = 0.7525 + .26;
			y = 0.052;
			w = 0.2675;
			h = 0.844;
		};

		class veh_b_spawn: Life_RscButtonMenu {
			idc = 2409;
			onButtonClick = "[] spawn OEC_fnc_adminSpawnVehicle;";
			text = "生成载具";
			x = 0.7475 + .26;
			y = 0.908;
			w = 0.2775;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class player_b_restrain: Life_RscButtonMenu {
			idc = 2412;
			onButtonClick = "[] spawn OEC_fnc_adminRestrain;";
			text = "束缚";
			x = 0.3175;
			y = 0.27;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Restrains player";
		};

		class player_b_unrestrain: Life_RscButtonMenu {
			idc = 2413;
			onButtonClick = "[] spawn OEC_fnc_adminUnrestrain;";
			text = "解除束缚";
			x = 0.4865;
			y = 0.27;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Un-restrains players, stops them from being escorted and other stuff.";
		};

		class AdminRevive: Life_RscButtonMenu {
			idc = -1;
			text = "复活";
			onButtonClick = "private _debugPlayer = call compile format [""%1"", lbData [2902, lbCurSel 2902]]; [_debugPlayer getVariable [""oev_corpse"", objNull], true] spawn OEC_fnc_revivePlayer;";
			x = 0.3175;
			y = 0.18;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0, 0, 0, 0.8};
		};
	};
};
