#include "..\..\macro.h"
//  File: fn_virt_sell.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Sell a virtual item to the store / shop

private["_type","_index","_price","_var","_amount","_name","_marketprice","_territory","_gangTax","_taxesPaid","_priceCut","_flagObject","_flagData"];
if (oev_purchActive) exitWith {hint "You currently have an active purchase or sale pending... please wait."};
ctrlEnable[2407,false];
oev_purchActive = true;

if((lbCurSel 2402) isEqualTo -1) exitWith {oev_purchActive = false; ctrlEnable[2407,true];};
_type = lbData[2402,(lbCurSel 2402)];

private _run = false;

private _mrktIndex = oev_market_arr find _type;
if (_mrktIndex isEqualTo -1) then {
	_price = -1;
} else {
	_price = ((serv_market_current select _mrktIndex) select 0);
	_marketprice = _price;
	_run = true;
};

if(_price isEqualTo -1) then {
	_index = [_type,__GETC__(oev_sell_array)] call OEC_fnc_index;
	if(_index != -1) then {
		_price = (__GETC__(oev_sell_array) select _index) select 1;
	};
};

private _convert = "";
if (_type in ["hash","crack","pheroin","mushroomu","acid"]) then {
	_convert = switch (_type) do {
		case "hash": {"marijuana"};
		case "acid": {"frogp"};
		case "mushroomu": {"mmushroom"};
		case "crack": {"cocainep"};
		case "pheroin": {"heroinp"};
		default {""};
	};
	if (_convert isEqualTo "") exitWith {_price = -1;};

	_mrktIndex = oev_market_arr find _convert;
	if (_mrktIndex isEqualTo -1) then {
		_price = -1;
	} else {
		_price = ((serv_market_current select _mrktIndex) select 0);
		_price = round(_price * 1.25);
		_marketprice = _price;
		_run = true;
	};
};

if(_price isEqualTo -1) exitWith {systemChat "无法获取项目价格。"; oev_purchActive = false; ctrlEnable[2407,true];};
_var = [_type,0] call OEC_fnc_varHandle;

_amount = ctrlText 2405;
if(!([_amount] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_Shop_Virt_NoNum"; oev_purchActive = false; ctrlEnable[2407,true];};
_amount = parseNumber (_amount);
if(_amount > (missionNameSpace getVariable _var)) exitWith {hint localize "STR_Shop_Virt_NotEnough"; oev_purchActive = false; ctrlEnable[2407,true];};
if (_amount > 120) exitWith {hint "一次卖出的商品不能超过120件。"; oev_purchActive = false; ctrlEnable[2407,true];};
if (_amount isEqualTo 0) exitWith {hint "您需要输入销售金额！"; oev_purchActive = false; ctrlEnable[2407,true];};

private _isGold = false;
if (_type isEqualTo "goldbar") then {_isGold = true;};

switch(_type) do {
	case "crystalmeth": {_territory = "Meth";};
	case "marijuana": {_territory = "Meth";};
	case "hash": {_territory = "Meth";};
	case "mmushroom": {_territory = "Mushroom";};
	case "cocainep": {_territory = "Mushroom";};
	case "crack": {_territory = "Mushroom";};
	case "mushroomu": {_territory = "Mushroom";};
	case "moonshine": {_territory = "Moonshine";};
	case "heroinp": {_territory = "Moonshine";};
	case "pheroin": {_territory = "Moonshine";};
	//case "frogp": {_territory = "Frog";};
	default {_territory = "";};
};

_gangTax = 1;
_priceCut = 0;
if(_territory != "" && (player distance2D (markerPos "drug_warzone") > 20)) then {
	_flagObject = call compile format["%1_flag",_territory];
	if(isNil "_flagObject" || isNull _flagObject) exitWith {};
	_flagData = _flagObject getVariable ["capture_data",[]];
	if(count _flagData isEqualTo 0) exitWith {};

	if(count oev_gang_data > 0) then {
		if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0)) then {
			_gangTax = 1;
			_priceCut = 0;
		} else {
			_gangTax = 0.90;
			_priceCut = 0.10;
		};
	} else {
		_gangTax = 0.90;
		_priceCut = 0.10;
	};
};

private _legalSellers = ["market","oil","fishmarket","glass","iron","diamond","salt","cement","silver","platinum","salvage"];
private _hasWPL = false;
private _bad = false;

//Drug Dealer interrogation
private _near = (getPos player) nearEntities["Man",10];
if({!isPlayer _x} count _near isEqualTo 0) exitWith {};
private _dealer = (_near select {!isPlayer _x}) select 0;

private _index = switch(_dealer) do {
	case dealer1: {0};
	case dealer2: {1};
	case dealer3: {2};
	case dealer4: {3};
	case dealer5: {4};
};

if (_index isEqualType 0) then { //switch returns true if no case is evaluated
	if(time - (oev_hasSoldAt select _index) < 1800 && !((oev_hasSoldAt select _index) isEqualTo 0)) exitWith {};

	[1, player, getPlayerUID player, serverTime, _index] remoteExec["OES_fnc_handleDrugSellers",2];
	oev_hasSoldAt set[_index, time];
};
//---------------


if ((life_shop_type in _legalSellers) && !(_isGold) && (license_civ_wpl)) then {_gangTax = 1.15; _hasWPL = true;};
if(__GETC__(oev_restrictions)) then {_bad = true; _hasWPL = false; _gangTax = 0.85;};

private _wplPrice = round((_price * _amount) * 0.15);
_taxesPaid = (_price * _amount) * _priceCut;
_price = round((_price * _amount) * _gangTax);
_name = [_var] call OEC_fnc_varToStr;

if (_isGold && life_donation_fedLoot) then {
	_price = _price * 1.25;
};
if (life_donation_active) then {
	if (!(_isGold) && _run) then {_price = _price * 1.10;};
};
// $2.5 mil check on selling virtual
if (_price > 2500000) exitWith {
	[ ["event","Hacked Sold Price"],["player",name player],["player_id",getPlayerUID player],["item",_name],["amount",_amount],["value",_price],["market_value",_marketprice],["position",getPosATL player] ] call OEC_fnc_logIt;

	[[profileName,format["Hacked Selling Price Detected! (Item Sold = %1) (Amount Sold = %2) (Total Price = $%3)",_name,_amount,[_price] call OEC_fnc_numberText]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[5,player,[_name,[_price] call OEC_fnc_numberText]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

private _highPrice = 0;
if (_mrktIndex != -1) then {
	if !(_type in ["hash","crack","pheroin","mushroomu","acid","goldbar"]) then {
		_highPrice = (((__GETC__(oev_market_config) select _mrktIndex) select 2) * 1.20) * _amount;
	} else {
		_highPrice = (((__GETC__(oev_market_config) select _mrktIndex) select 2) * 1.30) * _amount;
	};
};

if (_mrktIndex != -1 && {_price > _highPrice}) exitWith {
	[ ["event","Hacked Sold Price"],["player",name player],["player_id",getPlayerUID player],["item",_name],["amount",_amount],["value",_price],["market_value",_marketprice],["position",getPosATL player] ] call OEC_fnc_logIt;
	[[profileName,format["Hacked Selling Price Detected! (Item Sold = %1) (Amount Sold = %2) (Total Price = $%3)",_name,_amount,[_price] call OEC_fnc_numberText]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[5,player,[_name,[_price] call OEC_fnc_numberText]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if([false,_type,_amount] call OEC_fnc_handleInv) then {
	oev_cash = oev_cash + _price;
	oev_cache_cash = oev_cache_cash + _price;

	if(_taxesPaid > 0) then {
		hint format[(localize "STR_Shop_Virt_SellItem") + ". \n 你交了%4元的帮派税。",_amount,_name,[_price] call OEC_fnc_numberText, [_taxesPaid] call OEC_fnc_numberText];
		[[2,(_flagData select 0),player,_taxesPaid],"OES_fnc_gangBank",false,false] spawn OEC_fnc_MP;
	} else {
		if !(_hasWPL) then {
			hint format[(localize "STR_Shop_Virt_SellItem"),_amount,_name,[_price] call OEC_fnc_numberText];
		} else {
			hint format[(localize "STR_Shop_Virt_SellItem") + ". \n 您的工人保护许可证在这次销售中为您赢得了额外的%4元。",_amount,_name,[_price] call OEC_fnc_numberText,[_wplPrice] call OEC_fnc_numberText];
		};
	};

	[
		["event","Item Sold"],
		["player",name player],
		["player_id",getPlayerUID player],
		["item",_name],
		["amount",_amount],
		["value",_price]
	] call OEC_fnc_logIt;
	if !(_marketprice isEqualTo -1) then {
		if (_type in ["hash","crack","pheroin","mushroomu","acid"]) then {
			_type = _convert;
			[[_type,_amount],"OES_fnc_marketCache",false,false] spawn OEC_fnc_MP;
			[_type,_amount] call OEC_fnc_statArrUp;
		} else {
			[[_type,_amount],"OES_fnc_marketCache",false,false] spawn OEC_fnc_MP;
			[_type,_amount] call OEC_fnc_statArrUp;
		};
	};

	[] call OEC_fnc_virt_update;
	if (_type in ["topazr","wpearl","bpearl","amethyst","emerald","coin","scrap"]) then {["salvagenum",_amount] call OEC_fnc_statArrUp; ["salvagemon",_price] call OEC_fnc_statArrUp;};
	if (_type in ["salema","ornate","mackerel","mullet","tuna","catshark"]) then {["fishnum",_amount] call OEC_fnc_statArrUp; ["fishmon",_price] call OEC_fnc_statArrUp;};
};
/*
if(life_shop_type == "heroin") then {
	private["_array","_ind","_val"];
	_array = life_shop_npc getVariable["sellers",[]];
	_ind = [getPlayerUID player,_array] call life_fnc_index;
	if(_ind != -1) then {
		_val = (_array select _ind) select 2;
		_val = _val + _price;
		_array set[_ind,[getPlayerUID player,profileName,_val]];
		life_shop_npc setVariable["sellers",_array,true];
	} else {
		_array pushBack [getPlayerUID player,profileName,_price];
		life_shop_npc setVariable["sellers",_array,true];
	};
};
*/
[0] call OEC_fnc_ClupdatePartial;
[false] call OEC_fnc_saveGear;

if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};

oev_purchActive = false;
ctrlEnable[2407,true];
