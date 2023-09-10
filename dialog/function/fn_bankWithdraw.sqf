// File: fn_bankWithdraw

private["_val"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
_val = parseNumber(ctrlText 2702);
if(_val > 999999) exitWith {hint localize "STR_ATM_WithdrawMax";};
if(_val <= 0) exitwith {hint "您需要输入金额才能取款！";};
if(!([str(_val)] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_val > oev_atmcash) exitWith {hint localize "STR_ATM_NotEnoughFunds"};
if(_val < 100 && oev_atmcash > 20000000) exitWith {hint localize "STR_ATM_WithdrawMin"}; //Temp fix for something.

oev_cash = oev_cash + _val;
oev_cache_cash = oev_cache_cash + _val;
oev_atmcash = oev_atmcash - _val;
oev_cache_atmcash = oev_cache_atmcash - _val;
hint format [localize "STR_ATM_WithdrawSuccess",[_val] call OEC_fnc_numberText];
[] call OEC_fnc_atmMenu;
[6] call OEC_fnc_ClupdatePartial;