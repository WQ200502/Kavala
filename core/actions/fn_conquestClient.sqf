// File: fn_conquestClient.sqf
// Author: Civak

(if (typeName (_this select 0) != typeName "") then [{(_this select 3)}, {_this}]) params [
	["_mode", "", [""]],
	["_flag", objNull, [objNull]]
];

if (!(_mode in ["cost","payout"]) && (isNull _flag || typeOf _flag != "Flag_White_F")) exitWith {};

switch (_mode) do {
	case "payout": {
		_amount = _this select 2;
		hint parseText format["<t color='#00ff00' size='2' align='center'>资金存入</t><br/><br/>$%1 已经被放入您的储蓄箱中，以参与征服!你可以到阿尔蒂斯银行取钱!",[_amount] call OEC_fnc_numberText];
	};
	case "addAction": {
		private _spawns = [format["conq_%1_%2", switch (oev_conquestData select 1 select 0) do {
			case "Ghost Hotel": {0};
			case "Nifi": {1};
			case "Kavala": {2};
			case "Syrta": {3};
			case "Oreokastro": {4};
			case "Warzone": {5};
			case "Panagia": {6};
			case "Sofia": {7};
			default {0};
		}, _flag getVariable ["phonetic", "Alpha"]]];
		_obj_main = _flag;
		_obj_main addAction ["占领区域", OEC_fnc_conquestClient, ["capture", _obj_main], 1.5, true, true, "", "playerSide == civilian && isNull objectParent player", 10];
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && (count oev_gang_data > 0) && {_target getVariable ["owner", [-1]] select 0 == (oev_gang_data select 0)}',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && (count oev_gang_data > 0) && {_target getVariable ["owner", [-1]] select 0 == (oev_gang_data select 0)}',6];
	};
	case "removeAction": {
		private _spawns = [format["conq_%1_%2", switch (_this select 2 select 1 select 0) do {
			case "Ghost Hotel": {0};
			case "Nifi": {1};
			case "Kavala": {2};
			case "Syrta": {3};
			case "Oreokastro": {4};
			case "Warzone": {5};
			case "Panagia": {6};
			case "Sofia": {7};
			default {0};
		}, _flag getVariable ["phonetic", "Alpha"]]];
		_obj_main = _flag;
		_otherFlag = _flag;
 		removeAllActions _otherFlag;
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];

	};
	case "capture": {
		if (playerSide != civilian) exitWith {hint "只有平民才能参与征服！";};
		if (oev_gang_data isEqualTo []) exitWith {hint "你需要是帮派成员才可以占领！";};
		if (_flag getVariable ["owner", [-1]] select 0 == (oev_gang_data select 0)) exitWith {hint "你的帮派已经拥有这个占领点了！";};
		if ((group player) getVariable["bigGangCD",serverTime] > serverTime) exitWith {hint format["你的团队仍然在冷却，因为最近有超过12个玩家在战斗征服！剩余时间: %1",[round(((group player) getVariable["bigGangCD",serverTime]) - serverTime),"MM:SS"] call BIS_fnc_secondsToString];};
		if ({(getPos _x) inPolygon (oev_conquestData select 1 select 1) && isPlayer _x} count units group player > 12) exitWith {
			(group player) setVariable["bigGangCD",serverTime+300,true];
			[1, "您的团队或帮派现在有5分钟的积分捕获冷却时间，可以与超过12名玩家进行征服战斗！"] remoteExec["OEC_fnc_broadcast", group player];
		};
		if (currentWeapon player == "" || currentMagazine player in ["30Rnd_9x21_Mag", "16Rnd_9x21_Mag", "11Rnd_45ACP_Mag", "30Rnd_9x21_Mag_SMG_02", "6Rnd_45ACP_Cylinder", "9Rnd_45ACP_Mag"]) exitWith {hint "You need a 5.56 caliber gun or higher to capture!";};
		if (currentMagazine player == "") exitWith {hint "你需要弹药来抓捕！";};
		if (oev_action_inUse) exitWith {hint "你已经在执行另一个动作了！";};
		oev_action_inUse = true;
		_flag setVariable ["capturing", true, true];
		private _phonetic = _flag getVariable ["phonetic", "Unknown"];
		//[6, format ["Capture Point %1 is being taken by: %2", _phonetic, (oev_gang_data select 1)]] remoteExec ["OEC_fnc_broadcast", playableUnits select {side _x == civilian && position _x inPolygon (oev_conquestData select 1 select 1)}];

		if (!(player getVariable["conquestDeath",false]) && !(isNull player)) then {
			oev_conquest_add_homie = [getPlayerUID player,(player getVariable["gang_data",[]]) select 0,player];
			publicVariableServer "oev_conquest_add_homie";
			player setVariable["conquestDeath",true];
		};

		disableSerialization;
		5 cutRsc ["life_progress", "PLAIN DOWN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
		_titleText ctrlSetText format ["%1... 1%2", "占领点", "%"];
		_progress = 0.01;
		_progressBar progressSetPosition _progress;
		_rate = 0.0025;

		hint "你需要保持在15米以内的点继续占领。";

		private _exit = false;
		while {true} do {
			uiSleep 0.1;
			if (isNull _ui) then {
				5 cutRsc ["life_progress", "PLAIN DOWN"];
				_ui = uiNamespace getVariable "life_progress";
				_progressBar = _ui displayCtrl 38201;
				_titleText = _ui displayCtrl 38202;
			};
			_progress = _progress + _rate;
			_progressBar progressSetPosition _progress;
			_titleText ctrlSetText format ["%1... %2%3", "占领点", round(_progress * 100), "%"];
			if (_progress >= 1) exitWith {};
			if !(alive player) exitWith {_exit = true;};
			if !(isNull objectParent player) exitWith {_exit = true; hint "你必须保持步行才能占领！";};
			if (player distance _flag > 15) exitWith {_exit = true; hint "你必须呆在旗子附近才能占领！";};
		};

		5 cutText ["", "PLAIN DOWN"];
		player playMoveNow "stop";
		if (_exit) exitWith {
			_flag setVariable ["capturing", false, true];
			oev_action_inUse = false;
		};

		uiSleep 1;

		[6, format ["占领点%1已被占领: %2", _phonetic, (oev_gang_data select 1)]] remoteExec ["OEC_fnc_broadcast", playableUnits select {side _x == civilian && position _x inPolygon (oev_conquestData select 1 select 1)}];
		private _idx = ["Alpha","Bravo","Charlie","Delta","Echo"] find _phonetic;
		if (_idx > -1) then {
			format ["conqPoint_%1", _idx] setMarkerText (format [" Capture Point %1 - %2", _phonetic, (oev_gang_data select 1) select [0, 10]]);
		};
		_flag setVariable ["owner", [oev_gang_data select 0, oev_gang_data select 1, group player], true];
		_flag setVariable ["capturing", false, true];
		["conq_captures",1] call OEC_fnc_statArrUp;
		oev_action_inUse = false;
	};
	case "cost": {
		private _cost = 0;
		private _items = [];

		{
			if (_x isEqualType []) then {
				{
					if (_x isEqualType []) then {
						{
							if (_x isEqualType []) then {
								_items pushBack (_x select 0);
							} else {
								if (typeName _x != "SCALAR") then {
									_items pushBack _x;
								};
							};
						} forEach _x;
					} else {
						_items pushBack _x;
					};
				} forEach _x;
			} else {
				_items pushBack _x;
			};
		} forEach oev_loadout;

		{
			_curItem = _x;
			{
				if ((_x select 0) isEqualTo _curItem) exitWith {
					_cost = _cost + round(_x select 1);
				};
			} forEach oev_conqGear;
		} forEach _items;

		_cost;
	};
};
