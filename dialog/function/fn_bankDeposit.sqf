//  File: fn_bankDeposit.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Figure it out.
private["_value"];
params[
	["_depositAll",false,[false]]
];

_value = 0;

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if !(_depositAll) then {
	_value = parseNumber(ctrlText 2702);
} else {
	_value = oev_cash;
};

if !(typeName _value isEqualTo "SCALAR") exitWith{};

//Series of stupid checks
if (!_depositAll && (_value > 999999)) exitWith {hint localize "STR_ATM_GreaterThan";};
if (!_depositAll && !([str(_value)] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if (_value <= 0) exitWith {hint "您需要输入存款金额!";};
if (_value > oev_cash) exitWith {hint localize "STR_ATM_NotEnoughCash"};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

oev_cash = oev_cash - _value;
oev_cache_cash = oev_cache_cash - _value;
oev_atmcash = oev_atmcash + _value;
oev_cache_atmcash = oev_cache_atmcash + _value;

hint format[localize "STR_ATM_DepositMSG",[_value] call OEC_fnc_numberText];
[] call OEC_fnc_atmMenu;
[6] call OEC_fnc_ClupdatePartial;
