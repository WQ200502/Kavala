if(isServer && isDedicated) exitWith {};

//  File: fn_broadcast.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Broadcast system used in the life mission for multi-notification purposes.
private["_type","_message","_targetGangID","_exit","_gate"];
_type = param [0,0,[[],0]];
_message = param [1,"",[""]];
_localize = param [2,false,[false]];
_gate = param [4, "", [""]];
_gate = missionNamespace getVariable [_gate, true];

// These notifications were suppressed
if (!_gate) exitWith {};

if(_message == "") exitwith {};

if(_message isEqualTo "你的车准备好了!" || _message isEqualTo "你的车准备好了！按U键锁定和解锁车辆。") then{
	if((O_stats_playtime_civ) <= 120) then {
		_message = "你的车准备好了！按U解锁或锁定车辆，T打开行李箱！任何服务站均可购买升级。";
	};
};

if(_localize) exitWith {
	_arr = _this select 3;
	_msg = switch(count _arr) do {
		case 0: {localize _message;};
		case 1: {format[localize _message,_arr select 0];};
		case 2: {format[localize _message,_arr select 0, _arr select 1];};
		case 3: {format[localize _message,_arr select 0, _arr select 1, _arr select 2];};
		case 4: {format[localize _message,_arr select 0, _arr select 1, _arr select 2, _arr select 3];};
	};

	if(_type isEqualType []) then {
		for "_i" from 0 to (count _type)-1 do
		{
			switch((_type select _i)) do
			{
				case 0: {systemChat _msg;};
				case 1: {hint _msg;};
				case 2: {titleText[_msg,"PLAIN DOWN"];};
			};
		};
	} else {
		switch (_type) do
		{
			case 0: {systemChat _msg;};
			case 1: {hint _msg;};
			case 2: {titleText[_msg,"PLAIN DOWN"];};
		};
	};
};

if(_type isEqualType []) then {
	for "_i" from 0 to (count _type)-1 do {
		switch((_type select _i)) do {
			case 0: {systemChat _message};
			case 1: {hint format["%1", _message]};
			case 2: {titleText[format["%1",_message],"PLAIN DOWN"];};
			case 3: {hint parseText format["%1", _message]};
			case 4: {hint format["%1", _message];life_action_gangInUse = nil;};
			case 5: {["WarKillConfirm",["你已经从一次确认的杀戮中获得了战争点！"]] call bis_fnc_showNotification;};
			case 6: {["ConquestAlert",[_message]] call bis_fnc_showNotification;};
			case 7: {["AirdropAlert",[_message]] call bis_fnc_showNotification;};
		};
	};
} else {
	switch (_type) do {
		case 0: {systemChat _message};
		case 1: {hint format["%1", _message]};
		case 2: {titleText[format["%1",_message],"PLAIN DOWN"];};
		case 3: {hint parseText format["%1", _message]};
		case 4: {hint format["%1", _message];life_action_gangInUse = nil;};
		case 5: {["WarKillConfirm",["杀死敌方帮派成员，获得了战争点！"]] call bis_fnc_showNotification;};
		case 6: {["ConquestAlert",[_message]] call bis_fnc_showNotification;};
		case 7: {["AirdropAlert",[_message]] call bis_fnc_showNotification;};
	};
};
