//	File: fn_betMoney.sqf
//	Author: Fusah
//	Description: Handles betting money against another player.
#include "..\..\macro.h"
params [
	["_type",""],
	["_val",0],
	["_player",objNull]
];

switch (_type) do {
	case "amount": {
		if (oev_betCooldown) exitWith {hint "你最近已经下注了。请稍后再试。"};
		if (__GETC__(life_adminlevel) > 2) exitWith {hint "工作人员不能下注！";};
		if (playerSide isEqualTo independent) exitWith {hint "医生不能下注！"};
		if (playerSide isEqualTo west) exitWith {hint "警察不能下注!"};
		if (oev_inBet) exitWith {hint "你已经下注了！"};
		if (life_bettingVer) exitWith {hint "您当前已禁用下注！"};
		if (O_stats_playtime_civ < 1800) exitWith {hint "您必须在服务器上至少有30个小时才能下注！"};
		["life_bet_money"] call OEC_fnc_createDialog;
	};
	case "bet": {
		_val = ctrlText 3652;
		closeDialog 0;
		if !(isNil _val) exitWith {};
		if (!([_val] call OEC_fnc_isNumeric)) exitWith {hint "请输入有效数字！"};
		_val = parseNumber _val;
		if (O_stats_playtime_civ < 1800) exitWith {hint "您必须在服务器上至少有30个小时才能下注！"};
		if ((_val) < 1000) exitWith {hint "你至少要下注1000元。"};
		if ((_val) > 5000000) exitWith {hint "每次下注不得超过500万元。"};
		if ((_val) <= 0) exitWith {}; // Why bother
		if (oev_cash < (_val) && oev_atmcash < (_val)) exitWith {hint "你没那么多钱可赌！"};
		private _unit = life_pInact_curTarget;
		if(isNull _unit) exitWith {};
		if(!isPlayer _unit) exitWith {};
		if (_unit getVariable ["restrictions", false]) exitWith {hint "另一个玩家受到限制，不能下注。";};
		if (side _unit isEqualTo independent) exitWith {hint "你不能和医生赌博！";};
		if (__GETC__(oev_restrictions)) exitWith {hint "您受到限制，无法下注。";};
		if ((_unit distance player) > 20) exitWith {hint "另一个玩家距离太远！ 再试一次。"};
		if (life_bettingVer) exitWith {hint "您当前已禁用下注！"};
		_exit = false;
		if (_val > 5000000) then {
			private _action = [
				format ["你确定要下注%1元吗",[_val] call OEC_fnc_numberText],
				"确认",
				"是",
				"否"
			] call BIS_fnc_guiMessage;
			if !(_action) then {_exit = true;};
		};
		if !(_exit) then {
			uiSleep floor random 5;
			oev_inBet = true;
			oev_use_atm = false;
			oev_action_inUse = true;
			["confirm",_val,player] remoteExec ["OEC_fnc_betMoney",_unit,false];
			oev_betCooldown = true;
			[] spawn{
				uiSleep 180;
				oev_betCooldown = false;
				oev_inBet = false; //failsafe
				oev_action_inUse = false;
				oev_use_atm = true;
			};
		};
	};
	case "confirm": {
		if(!isNull (findDisplay 2700) || !isNull (findDisplay 3200)) then {
			closeDialog 0;
		};
		if (oev_action_inUse || oev_inCasino) exitWith {
			["failU"] remoteExec ["OEC_fnc_betMoney",_player,false];
		};
		if (oev_cash < (_val) && oev_atmcash < (_val)) exitWith {
			["failM"] remoteExec ["OEC_fnc_betMoney",_player,false];
		};
		if (oev_inBet) exitWith {
			["failB"] remoteExec ["OEC_fnc_betMoney",_player,false];
		};
		if (oev_betCooldown) exitWith {
			["failC"] remoteExec ["OEC_fnc_betMoney",_player,false];
		};
		if (life_bettingVer || (__GETC__(life_adminlevel) > 2)) exitWith {
			["failE"] remoteExec ["OEC_fnc_betMoney",_player,false];
		};
		if (O_stats_playtime_civ < 1800) exitWith {
			["failT"] remoteExec ["OEC_fnc_betMoney",_player,false];
		};
		oev_inBet = true;
		oev_use_atm = false;
		oev_action_inUse = true;
		private _action = [
			format ["您想用%2下注%1元吗？",[_val] call OEC_fnc_numberText,name _player],
			"确认",
			"是",
			"否"
		] call BIS_fnc_guiMessage;
		if (_action) then {
			private _winNum = floor random 2;
			hint "掷硬币。。。";
			uiSleep 3;
			oev_betCooldown = true;
			[] spawn{
				uiSleep 180;
				oev_betCooldown = false;
				oev_inBet = false; //failsafe
				oev_use_atm = true;
				oev_action_inUse = false;
			};
			if (_winNum isEqualTo 1) then {
				if !([getPlayerUID _player] call OEC_fnc_isUIDActive) exitWith {hint "对你下注的人离开了游戏。。。真是个失败者。。"};
				_winNum = _val;
				["lose", _winNum, player] remoteExec ["OEC_fnc_betMoney",_player,false];
			} else {
				_winNum = _val;
				["lose", _winNum, _player] remoteExec ["OEC_fnc_betMoney", player];
			};
		} else {
			["no"] remoteExec ["OEC_fnc_betMoney",_player,false];
			oev_inBet = false;
			oev_use_atm = true;
			oev_action_inUse = false;
		};
	};
	case "win": {
		private _taxedVal = round(_val * 0.99);
		titleText [format["恭喜你赢得了价值%1元的赌注！",[_val] call OEC_fnc_numberText],"PLAIN DOWN"];
		oev_atmcash = oev_atmcash + _taxedVal;
		oev_cache_atmcash = oev_cache_atmcash + _taxedVal;
		["bets_won_value",_taxedVal] call OEC_fnc_statArrUp;
		["bets_won",1] call OEC_fnc_statArrUp;
		[1] call OEC_fnc_ClupdatePartial;
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failM": {
		hint "另一个玩家没有那么多钱下注！";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "no": {
		hint "另一个玩家拒绝了你的赌注。";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failB": {
		hint "另一个玩家已经下注了！";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failC": {
		hint "另一个玩家正在冷却！";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failD": {
		hint "你赌的人现在破产了，所以赌取消了。";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failE": {
		hint "您下注的对象当前已禁用下注，因此下注已取消。";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failT": {
		hint "您要下注的人在服务器上没有30个或更多小时！";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "failU": {
		hint "您要下注的人当前正忙。";
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
	};
	case "lose": {
		if !([getPlayerUID _player] call OEC_fnc_isUIDActive) exitWith {
			hint "对你下注的人离开了游戏。。。真是个失败者。。";
			oev_inBet = false;
			oev_use_atm = true;
			oev_action_inUse = false;
		};
		if (oev_cash < _val && oev_atmcash < _val) exitWith {
			["failD", _val, player] remoteExecCall ["OEC_fnc_betMoney", _player];
			[
				["event","Exploit Negative Money"],
				["player",name player],
				["player_id",getPlayerUID player],
				["target",name _player],
				["target_id",getPlayerUID _player],
				["value",[_val] call OEC_fnc_numberText],
				["location",getPosATL player]
			] call OEC_fnc_logIt;
			oev_inBet = false;
			oev_use_atm = true;
			oev_action_inUse = false;
		};
		if !(oev_cash < _val) then {
			oev_cash = oev_cash - _val;
			oev_cache_cash = oev_cache_cash - _val;
			[0] call OEC_fnc_ClupdatePartial;
		} else {
			oev_atmcash = oev_atmcash - _val;
			oev_cache_atmcash = oev_cache_atmcash - _val;
			[1] call OEC_fnc_ClupdatePartial;
		};
		hint "你输了赌注。祝你下次好运！";
		["bets_lost_value",_val] call OEC_fnc_statArrUp;
		["bets_lost",1] call OEC_fnc_statArrUp;
		oev_inBet = false;
		oev_use_atm = true;
		oev_action_inUse = false;
		["win", _val, player] remoteExec ["OEC_fnc_betMoney", _player];
		if (remoteExecutedOwner isEqualTo (owner player)) then {
			[0, format ["%1对%3输了一个值%2元的赌注！", name player, [_val] call OEC_fnc_numberText, name _player]] remoteExecCall ["OEC_fnc_broadcast", -2];
		} else {
			[0, format ["%1赢了价值%2元的赌注，赢了%3！", name _player, [_val] call OEC_fnc_numberText, name player]] remoteExecCall ["OEC_fnc_broadcast", -2];
		};
		[
			["event","Player Lost Bet"],
			["player",name player],
			["player_id",getPlayerUID player],
			["target",name _player],
			["target_id",getPlayerUID _player],
			["value",[_val] call OEC_fnc_numberText],
			["location",getPosATL player]
		] call OEC_fnc_logIt;
	};
};
