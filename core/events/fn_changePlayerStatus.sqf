//  File: fn_changePlayerStatus
//	Description: Changes the selected players event status
private["_mode","_unit","_display","_count","_eventType"];
_mode = param [0,"",[""]];
disableSerialization;

_display = findDisplay 50000;
_eventType = lbData[50003,lbCurSel (50003)];
_count = 0;
_canJoin = missionNamespace getVariable ["canJoinEvent", false];
_inEvent = player getVariable ["isInEvent",["no"]];
_restrained = player getVariable["restrained",false];
if(!(_eventType == ""))then{
	missionNamespace setVariable ["currentEvent", _eventType, true]
};

switch (_mode) do {
	case "add": //adds the player from the available list to the selected list
	{
		_unit = lbData[50001,lbCurSel (50001)];
		_unit = call compile format["%1", _unit];
		if(isNil "_unit") exitWith {hint "Invalid player selected";};
		if(isNull _unit) exitWith {hint "Invalid player selected";};
		_unit setVariable ["isInEvent",[_eventType],true];
		[_unit, "join"] remoteExec ["OES_fnc_eventPlayers", 2, false];
		hint format["%1 added to the selected players list.",_unit getVariable["realname",name _unit]];
	};
	case "autojoin": //toggles players to join the event
	{
		if(!(_canJoin)) then {  //if false, make it true
			missionNamespace setVariable ["canJoinEvent", true, true];
			hint "加入已禁用";
		}else{
			missionNamespace setVariable ["canJoinEvent", false, true];
			hint "加入已禁用";
		};
	};

	case "join": //adds to event when join chat command executed
	{
		if (!(_canJoin)) exitWith {hint "此事件尚未启用加入！"; systemChat "此事件尚未启用加入！"};
		if (!("no" in _inEvent)) exitWith {hint "你已经参加了一个活动！"; systemChat "你已经参加了一个活动！"};
		if (_restrained) exitWith {hint "你不能在受约束的情况下参加活动。。。"; systemChat "你不能在受约束的情况下参加活动。。。"};
		if (!(alive player)) exitWith {hint "如果你死了怎么参加活动？"; systemChat "如果你死了怎么参加活动？"};
		if ((oev_is_arrested select 0) isEqualTo 1) exitWith {hint "先在监狱里等你的时间。。。"; systemChat "先在监狱里等你的时间。。。"};
		[player, "join"] remoteExec ["OES_fnc_eventPlayers", 2, false];
	};
	case "leave": //leaves event when leave chat command executed
	{
		if ("no" in _inEvent) exitWith {hint "You're not in an event!"};
		if (!(_canJoin)) exitWith {hint "Leaving has been disabled"};
		[player, "leave"] remoteExec ["OES_fnc_eventPlayers", 2, false];
	};
	case "remove": //removes the selected player from the selected list
	{
		_unit = lbData[50002,lbCurSel (50002)];
		_unit = call compile format["%1", _unit];
		if(isNil "_unit") exitWith {hint "Invalid player selected";};
		if(isNull _unit) exitWith {hint "Invalid player selected";};
		[_unit, "leave"] remoteExec ["OES_fnc_eventPlayers", 2, false];
		hint format["%1 已从选定玩家列表中删除。",_unit getVariable["realname",name _unit]];
	};

	case "wipeSelected": //clears all players that are in the selected list
	{
		{
			if(((_x getVariable ["isInEvent",["no"]]) select 0) == "selected") then {
				_count = _count + 1;
				_x setVariable ["isInEvent",["no"],true];
			};
		}foreach playableUnits;
		[player, "remSel", _count] remoteExec ["OES_fnc_eventPlayers", 2, false];
		hint format["%1 从所选列表中删除的玩家。",_count];
	};

	case "wipeEvent": //wipes any event status from all players on the server
	{
		{
			if(((_x getVariable ["isInEvent",["no"]]) select 0) != "no") then {
				_x setVariable ["isInEvent",["no"],true];
				_count = _count + 1;
			};
		}foreach playableUnits;
		[player, "remAll"] remoteExec ["OES_fnc_eventPlayers", 2, false];
		hint format["%1 服务器上的玩家已删除其事件状态。",_count];
	};
};

uiSleep 0.1;
[] spawn OEC_fnc_updateEventPlayers;
