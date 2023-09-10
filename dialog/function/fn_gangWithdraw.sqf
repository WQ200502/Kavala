#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	Description: Deposits money into the players gang bank. DESCRIPTIONEND

private["_value","_gangID","_gangName"];

if(oev_gang_funds == -1) exitWith {closeDialog 0;};
_gangID = (oev_gang_data select 0);
_gangName = (oev_gang_data select 1);

if(__GETC__(oev_restrictions)) exitWith {hint "您受到玩家的限制，无法执行此操作！ 如果您认为这是一个错误，请与管理员联系。";};
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

_value = parseNumber(ctrlText 3204);

//Series of stupid checks
if(_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if(_value <= 0) exitWith {hint "您需要输入提款金额！";};
if(!([str(_value)] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_value > oev_gang_funds) exitWith {hint "您的帮派资金太低。"};

(getControl(3200,3202)) ctrlEnable false;
(getControl(3200,3203)) ctrlEnable false;
oev_action_inUse = true;

hint format[localize "STR_ATM_WithdrawGang",[_value] call OEC_fnc_numberText];

[1,_gangID,player,-(_value),oev_cash,oev_cache_cash,false,_gangName] remoteExec ["OES_fnc_gangBank",2];
oev_cache_cash = oev_cache_cash + _value;

hint "提款有额外的延迟，以防止被利用，请耐心等待。";

oev_gangfund_ready = false;
oev_gang_funds = -1;

disableSerialization;
_display = findDisplay 3200;
_text = _display displayCtrl 3201;
_text ctrlSetStructuredText parseText format["<img size='1.7' image='images\icons\bank.paa'/> $%1<br/><img size='1.6' image='images\icons\money.paa'/> %2元"," 处理中...",[oev_cash] call OEC_fnc_numberText];

[] spawn{
	waitUntil{!oev_action_inUse};

	[[0,oev_gang_data select 0,player],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;

	waitUntil{oev_gangfund_ready};

	uiSleep 0.5;
	[6] call OEC_fnc_ClupdatePartial;
	disableSerialization;
	_display = findDisplay 3200;
	_text = _display displayCtrl 3201;
	_text ctrlSetStructuredText parseText format["<img size='1.7' image='images\icons\bank.paa'/> %1元<br/><img size='1.6' image='images\icons\money.paa'/> %2元",[oev_gang_funds] call OEC_fnc_numberText,[oev_cash] call OEC_fnc_numberText];

	if(oev_gang_funds < 1) then {
		(getControl(3200,3203)) ctrlEnable true;
	}else{
		if((oev_gang_data select 2) > 3) then {
			(getControl(3200,3202)) ctrlEnable true;
		};
		(getControl(3200,3203)) ctrlEnable true;
	};
};
