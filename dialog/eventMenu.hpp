class life_event_menu {
	idd = 50000;
	name= "life_event_menu";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "[] spawn OEC_fnc_eventMenu;";

	class controlsBackground {
		class Life_RscTitleBackground: Life_RscText
		{
			idc = -1;

			x = 0;
			y = -0.004;
			w = 1;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class MainBackground: Life_RscText
		{
			idc = -1;

			x = 0;
			y = 0.036;
			w = 1;
			h = 0.92;
			colorBackground[] = {0,0,0,0.7};
		};

		class available_players_title_BG: Life_RscText
		{
			idc = -1;

			x = 0.005;
			y = 0.052;
			w = 0.41;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class selected_players_title_BG: Life_RscText
		{
			idc = -1;

			x = 0.585;
			y = 0.052;
			w = 0.41;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class event_list_title_BG: Life_RscText
		{
			idc = -1;

			x = 0.005;
			y = 0.496;
			w = 0.56;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class event_procedures_title_BG: Life_RscText
		{
			idc = -1;

			x = 0.585;
			y = 0.496;
			w = 0.41;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class vehicle_list_title_BG: Life_RscText
		{
			idc = -1;

			x = 1.0075;
			y = -0.004;
			w = 0.285;
			h = 0.04;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

	};

	class controls {
		//{ titles
		class Title: Life_RscTitle
		{
			idc = -1;

			text = "西海岸活动菜单";
			x = 0;
			y = -0.004;
			w = 0.6;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class available_players_title: Life_RscTitle
		{
			idc = -1;

			text = "可用玩家";
			x = 0.0025;
			y = 0.052;
			w = 0.4;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class selected_players_title: Life_RscTitle
		{
			idc = -1;

			text = "选定的玩家";
			x = 0.585;
			y = 0.052;
			w = 0.4;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class event_list_title: Life_RscTitle
		{
			idc = -1;

			text = "活动列表和活动信息";
			x = 0.005;
			y = 0.496;
			w = 0.5375;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class procedure_list_title: Life_RscTitle
		{
			idc = -1;

			text = "活动设置";
			x = 0.585;
			y = 0.496;
			w = 0.375;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class vehicle_list_title: RscText
		{
			idc = -1;

			text = "车辆选择";
			x = 1.0025;
			y = -0.004;
			w = 0.4;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class selected_players_amount: Life_RscTitle
		{
			idc = 50011;

			text = "0";
			onLoad = "[] spawn{waitUntil{_units = [];{if !(((_x getVariable ['isInEvent',['no']]) select 0) isEqualTo 'no')then{_units pushBack _x}}forEach allPlayers;((findDisplay 50000)displayCtrl 50011) ctrlSetText format['%1', count _units]; sleep 1; isNull findDisplay 50000}}";
			x = 0.94;
			y = 0.052;
			w = 0.4;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};

		class available_players_amount: Life_RscTitle
		{
			idc = 50012;

			text = "0";
			onLoad = "[] spawn{waitUntil{_units = [];{if (((_x getVariable ['isInEvent',['no']]) select 0) isEqualTo 'no')then{_units pushBack _x}}forEach allPlayers;((findDisplay 50000)displayCtrl 50012) ctrlSetText format['%1', count _units]; sleep 1; isNull findDisplay 50000}}";
			x = 0.36;
			y = 0.052;
			w = 0.4;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
		};
		//}

		//{ lists
		class Available_Players_List: Life_RscListBox
		{
			idc = 50001;

			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
			x = 0.0025;
			y = 0.096;
			w = 0.415;
			h = 0.332;
		};

		class Selected_Players_List: Life_RscListBox
		{
			idc = 50002;

			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
			x = 0.5825;
			y = 0.096;
			w = 0.415;
			h = 0.36;
		};

		class Event_List_type: Life_RscListBox
		{
			idc = 50003;
			onLBSelChanged = "[] spawn OEC_fnc_updateEventLocations; [] spawn OEC_fnc_getEventInfo; [] spawn OEC_fnc_loadEventActions; [] spawn OEC_fnc_updateEventVehicles; []call OEC_fnc_eventMessages;";
			sizeEx = 0.03;
			x = 0.005;
			y = 0.548;
			w = 0.231;
			h = 0.184;
		};

		class Event_List_location: Life_RscListBox
		{
			idc = 50004;
			onLBSelChanged = "[] spawn OEC_fnc_getEventInfo;";
			sizeEx = 0.03;
			x = 0.00675;
			y = 0.756;
			w = 0.231;
			h = 0.184;
		};

		class Event_Vehicle_List: Life_RscListBox
		{
			idc = 50005;
			sizeEx = 0.03;
			x = 1.0075;
			y = 0.036;
			w = 0.285;
			h = 0.96;
			colorBackground[] = {0,0,0,0.7};
		};

		class Event_Procedure_List: Life_RscListBox
		{
			idc = 50006;
			sizeEx = 0.03;
			x = 0.5825;
			y = 0.54;
			w = 0.415;
			h = 0.348;
		};
		//}

		class Event_Info: Life_RscStructuredText
		{
			idc = 50010;

			x = 0.24;
			y = 0.548;
			w = 0.3225;
			h = 0.396;
		};

		class moneyEdit: Life_RscEdit
		{
			idc = 2988;

			text = "1";
			x = 0.2375;
			y = 0.448;
			w = 0.1625;
			h = 0.03;
		};
		class GiveMoney: Life_RscButtonMenu
		{
			onButtonClick = "[] call OEC_fnc_eventGiveMoney;";
			idc = 1010;

			text = "给予奖励 ^";
			x = 0.0025;
			y = 0.44;
			w = 0.21625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		//{ buttons
		class addSelectedPlayer: Life_RscButtonMenu
		{
			onButtonClick = "[""add""] spawn OEC_fnc_changePlayerStatus;";
			idc = -1;

			text = "增加";
			x = 0.42;
			y = 0.134;
			w = 0.1585;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Adds the player to the list of selected players";
		};

		class removeSelectedPlayer: Life_RscButtonMenu
		{
			onButtonClick = "[""remove""] spawn OEC_fnc_changePlayerStatus;";
			idc = -1;

			text = "移除";
			x = 0.42;
			y = 0.194;
			w = 0.1585;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Removes the player from the list of selected players";
		};
		class allowPlayerJoin: Life_RscButtonMenu
		{
			onButtonClick = "[""autojoin""] spawn OEC_fnc_changePlayerStatus;";
			idc = -1;

			text = "自动加入";
			x = 0.42;
			y = 0.245;
			w = 0.1585;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Toggles ability for players to join the event with ;ejoin or leave with ;eleave";
		};

		class clearSelectedList: Life_RscButtonMenu
		{
			onButtonClick = "[""wipeSelected""] spawn OEC_fnc_changePlayerStatus;";
			idc = -1;

			text = "清除选择";
			x = 0.41995;
			y = 0.296;
			w = 0.1585;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Removes all selected players in the list";
		};

		class clearPlayableUnits: Life_RscButtonMenu
		{
			onButtonClick = "[""wipeEvent""] spawn OEC_fnc_changePlayerStatus;";
			idc = -1;

			text = "全部清除";
			x = 0.42;
			y = 0.356;
			w = 0.1585;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			tooltip = "Removes event status from every player on the server";
		};

		class activateSelectedProcedure: Life_RscButtonMenu
		{
			onButtonClick = "[] spawn OEC_fnc_executeEventProcedure; ctrlEnable[50015,false];[]spawn{sleep 1; ctrlEnable[50015,true];}; [] spawn{sleep 0.5; [] spawn OEC_fnc_updateEventPlayers;}";

			idc = 50015;
			text = "激活所选";
			x = 0.5825;
			y = 0.9;
			w = 0.4125;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};

		class eventMessageList: Life_RscListBox
		{
			onLBSelChanged = "[]call OEC_fnc_eventMessages;";
			idc = 50044;
			sizeEx = 0.03;
			x = -0.293;
			y = 0.036;
			w = 0.285;
			h = 0.461;

			colorBackground[] = {0,0,0,0.7};
		};

		class eventMessageTitle: RscText
		{
			idc = 50045;

			text = "活动讯息";
			x = -0.293;
			y = -0.004;
			w = 0.285;
			h = 0.039;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			colorText[] = {0.95,0.95,0.95,1};
		};

		class eventMessageText: RscStructuredText
		{
			idc = 50046;

			text = "";
			x = -0.293;
			y = 0.536;
			w = 0.285;
			h = 0.464;
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {0.95,0.95,0.95,1};
			class TextPos
			{
				left = 0.05;
				top = 0.1;
				right = 0.05;
				bottom = 0.05;
			};
		};

		class sendEventMessageAll: Life_RscButtonMenu
		{
			onButtonClick = "['all']call OEC_fnc_eventMessages;";
			idc = 50047;

			text = "全部发送";
			x = -0.293;
			y = 0.496;
			w = 0.143;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.9};
			tooltip = "Broadcast event message to all players";
		};

		class sendEventMessagePart: Life_RscButtonMenu
		{
			onButtonClick = "['part']call OEC_fnc_eventMessages;";
			idc = 50048;

			text = "发送邀请";
			x = -0.15;
			y = 0.496;
			w = 0.143;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.9};
			tooltip = "Broadcast event message to players in the event";
		};

		class CloseButtonKey: Life_RscButtonMenu
		{
			onButtonClick = "closeDialog 0;";
			idc = -1;

			text = "关闭";
			x = 0;
			y = 0.96;
			w = 1.00125;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		//}
	};
};
