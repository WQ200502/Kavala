#include "..\..\macro.h"
//	Author: Bryan "Tonic" Boardwine
//	File: fn_buyHouse.sqf
//	Description: Buys the house?

params [
	["_house",objNull,[objNull]]
];
private _uid = getPlayerUID player;
if(oev_houseTransaction) exitWith {hint "You currently have an active transaction, please wait.";};
if (player distance (getMarkerPos "admin_island") < 1200) exitWith {hint "You cannot buy houses on admin island.";};
if (_house getVariable ["restricted_house",false]) exitWith {};

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};
if((_house getVariable["house_owned",false]) && ((_house getVariable ["for_sale",""]) isEqualTo "")) exitWith {hint "这房子已经被拥有了，即使你不应该看到这个消息。。。"};
if(!isNil {(_house getVariable "house_sold")}) exitWith {hint localize "STR_House_Sell_Process"};
if(!license_civ_home) exitWith {hint localize "STR_House_License"};
if(count life_houses >= (__GETC__(oev_houseLimit))) exitWith {hint format[localize "STR_House_Max_House",__GETC__(oev_houseLimit)]};
closeDialog 0;

private _houseCfg = [(typeOf _house)] call OEC_fnc_houseConfig;
if(count _houseCfg == 0) exitWith {};

private _exit = false;
if !((_house getVariable ["for_sale",""]) isEqualTo "") then {
	if (oev_atmcash < ((_house getVariable ["for_sale",""]) select 1) && oev_cash < ((_house getVariable ["for_sale",""]) select 1)) exitWith {
		hint format [localize "STR_House_NotEnough"];
		_exit = true;
	};
} else {
	if(oev_atmcash < (_houseCfg select 0) && oev_cash < (_houseCfg select 0)) exitWith {hint format [localize "STR_House_NotEnough"]; _exit = true;};
};
if(oev_houseTransaction) exitWith {hint "您当前有一个活动事务，请稍候。";};
//if ((player getVariable ["ahHouseCount",-1]) >= (call oev_houseLimit)) exitWith {hint "You've reached your property limit. Sell other properties or wait for any active auctions to complete.";};
if (_exit) exitWith {};
oev_houseTransaction = true;
oev_action_inUse = true;

private _price = -1;
if !((_house getVariable ["for_sale",""]) isEqualTo "") then {
	_price = ((_house getVariable ["for_sale",""]) select 1);
	if (oev_cash >= _price) then {
		oev_cash = oev_cash - _price;
		oev_cache_cash = oev_cache_cash - _price;
	} else {
		oev_atmcash = oev_atmcash - _price;
		oev_cache_atmcash = oev_cache_atmcash - _price;
	};
} else {
	if(oev_cash >= (_houseCfg select 0)) then {
		oev_cash = oev_cash - (_houseCfg select 0);
		oev_cache_cash = oev_cache_cash - (_houseCfg select 0);
	} else {
		oev_atmcash = oev_atmcash - (_houseCfg select 0);
		oev_cache_atmcash = oev_cache_atmcash - (_houseCfg select 0);
	};
};

[6] call OEC_fnc_ClupdatePartial;
[[player,_house,_price],"OES_fnc_addHouse",false,false] spawn OEC_fnc_MP;
hint "正在向房地产经纪人发送购买请求。。。";
