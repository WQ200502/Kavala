// File: fn_buyLotteryTicket.sqf
// Author: Fusah
// Description: Puts the user into the lottery!

params["_type"];
private _exit = false;
switch (_type) do {
	case "start": {
		if (life_lotteryCooldown) exitWith {hint "彩票系统正在冷却，此时您不能购买彩票！"};
		if !(isNull objectParent player) exitWith {hint "你不能在车里买彩票！"};
		if (oev_action_inUse) exitWith {hint "你已经在执行另一个操作了！"};
		if (player getVariable ["restrained",false]) exitWith {};
		if (oev_isDowned) exitWith {};
		if (oev_cash < oev_lotteryPrice && oev_atmcash < oev_lotteryPrice) exitWith {hint "你没有足够的钱买彩票！"};

		if !(life_runningLottery) then {
			if (isNil "serverStartTime" || isNil "serverCycleLength") exitWith {_exit = true};
			private _restartTime = round((serverCycleLength - (serverTime - serverStartTime)) / 60);
			if (_restartTime < 35) exitWith {_exit = true};
		};
		if (_exit) exitWith {hint "你现在买不到彩票了！"};

		oev_action_inUse = true;
		["check",player] remoteExec ["OES_fnc_handleLottery",2,false];
		titleText ["购买中...","PLAIN DOWN",.3];
		uiSleep 3;
		if (oev_inLottery) exitWith {hint "您已经在当前彩票中购买了彩票！"; oev_action_inUse = false};
		oev_action_inUse = false;
		hint "您最多只能购买10张彩票。";
		["life_buy_ticket"] call OEC_fnc_createDialog;
	};
	case "end": {
		private _val = ctrlText 3653;
		closeDialog 0;
		if !(isNil _val) exitWith {};
		if (!([_val] call OEC_fnc_isNumeric)) exitWith {hint "请输入有效数字！"};
		_val = parseNumber _val;
		if ((_val) > 10) exitWith {hint "你最多只能买10张彩票。"};
		if ((_val) <= 0) exitWith {}; // Why bother
		if (oev_cash < (_val * oev_lotteryPrice) && oev_atmcash < (_val * oev_lotteryPrice)) exitWith {hint "你没有足够的钱买那么多彩票！"};
		private _buy = [
			format ["您确定要用%1美元购买%2票%3吗？如果你中奖，你必须在彩票结束时在线领取奖品。",[oev_lotteryPrice*_val] call OEC_fnc_numberText, _val,if (_val > 1) then {"s"} else {""}],
			"确认",
			"是",
			"否"
		] call BIS_fnc_guiMessage;
		private _loss = _val * oev_lotteryPrice;
		if (_buy) then {
		if !(oev_cash < _loss) then {
			oev_cash = oev_cash - _loss;
			oev_cache_cash = oev_cache_cash - _loss;
			[0] call OEC_fnc_ClupdatePartial;
		} else {
			oev_atmcash = oev_atmcash - _loss;
			oev_cache_atmcash = oev_cache_atmcash - _loss;
			[1] call OEC_fnc_ClupdatePartial;
		};
		oev_inLottery = true;
		hint "谢谢你买彩票。。祝你好运！";
		["add",player,_val] remoteExec ["OES_fnc_handleLottery",2,false];
		[
			["event","Bought Lottery Tickets"],
			["player",name player],
			["player_id",getPlayerUID player],
			["tickets",_val],
			["value",[_loss] call OEC_fnc_numberText],
			["location",getPosATL player]
		] call OEC_fnc_logIt;
		};
	};
};
