//  File: fn_bankTransfer.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Figure it out again.
private["_val","_unit","_tax"];
_val = parseNumber(ctrlText 2702);
_unit = call compile format["%1",(lbData[2703,(lbCurSel 2703)])];
if(isNull _unit) exitWith {ctrlEnable[2705,true];};

if(call oev_restrictions) exitWith {hint "您受到玩家限制，无法执行此操作！如果您认为这是一个错误，请与管理员联系。";};
if(_unit getVariable ["restrictions", false]) exitWith {hint "此玩家受玩家限制，不能接受金钱转移。";};
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};
if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if (oev_warpts_count + (oev_random_cash_val - 10) > oev_warpts_cache) exitWith {
	[["event","Hacked Warpoints"],["player",name player],["player_id",getPlayerUID player],["value",oev_warpts_count - (oev_warpts_cache - oev_random_cash_val)],["position",getPos player]] call OEC_fnc_logIt;
	[profileName, format ["Hacked war points detected! (War Points hacked in = %1)", oev_warpts_count - (oev_warpts_cache - oev_random_cash_val)]] remoteExec ["OEC_fnc_notifyAdmins", -2, false];
	["HackedMoney", false, false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if((lbCurSel 2703) == -1) exitWith {hint localize "STR_ATM_NoneSelected"; ctrlEnable[2705,true];};
if(isNil "_unit") exitWith {hint localize "STR_ATM_DoesntExist"; ctrlEnable[2705,true];};
if(_val > 999999) exitWith {hint localize "STR_ATM_TransferMax"; ctrlEnable[2705,true];};
if(oev_bankMode == 1 && _val > 999) exitWith {hint "你不能转移超过999个战争点"; ctrlEnable[2705,true];};
if(oev_bankMode < 1 && _val < 100) exitwith {hint "转账金额不能少于100元"; ctrlEnable[2705,true];};
if(oev_bankMode == 1 && _val < 3) exitWith { hint "你不能转移少于3个战争点"; ctrlEnable[2705,true];};
if(!([str(_val)] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_ATM_notnumeric"; ctrlEnable[2705,true];};
if(oev_bankMode < 1 && _val > oev_atmcash) exitWith {hint localize "STR_ATM_NotEnoughFunds"; ctrlEnable[2705,true];};
if(oev_bankMode == 1 && _val > oev_warpts_count) exitWith {hint localize "STR_ATM_NotEnoughWarPoints"; ctrlEnable[2705,true];};
_tax = [_val] call OEC_fnc_taxRate;
if (oev_bankMode == 1) then {
	_tax = 0;
};
// We need to re-check cash transfers because they are taxed
if((_val + _tax) > oev_atmcash && oev_bankMode < 1) exitWith {hint format[localize "STR_ATM_SentMoneyFail",_val,_tax]; ctrlEnable[2705,true];};

private _confirmText = switch (oev_bankMode) do {
	case 0: { format ["确定要转账%1元给%2吗？您将被征税%3元。", [_val] call OEC_fnc_numberText, name _unit, [_tax] call OEC_fnc_numberText] };
	default { format ["确定要将%1转给%2吗？？", [_val] call OEC_fnc_numberText, name _unit] };
};

private _action = [
	_confirmText,
	"Confirm Transfer",
	"Transfer",
	localize "STR_Global_Cancel"
] call BIS_fnc_GUImessage;

if (_action) then {
	private _wireMode = if (oev_bankMode < 1) then {0} else {2};
	[_val, player, _wireMode, clientOwner] remoteExec ["OEC_fnc_clientWireTransfer", _unit, false];
	_log_event = "";
	if (oev_bankMode < 1) then {
		hint format[localize "STR_ATM_SentMoneySuccess",[_val] call OEC_fnc_numberText,_unit getVariable["realname",name _unit],[_tax] call OEC_fnc_numberText];
		_log_event = "游戏币转账";
	} else {
		hint format[localize "STR_ATM_SentWarPtsSuccess",[_val] call OEC_fnc_numberText,_unit getVariable["realname",name _unit]];
		_log_event = "战争点转账";
	};
	[
		["event",_log_event],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",name _unit],
		["target_id",getPlayerUID _unit],
		["value",_val],
		["position",getPosATL player]
	] call OEC_fnc_logIt;
} else {
	hint "转移已取消";
	ctrlEnable[2705,true];
};
