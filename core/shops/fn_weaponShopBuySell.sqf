#include "..\..\macro.h"
//  File: fn_weaponShopBuySell.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Master handling of the weapon shop for buying / selling an item.
disableSerialization;
private["_price","_item","_itemInfo","_bad","_perkTier","_goalDis"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

_mode = param [0,false,[false]];
_item = "";

if(!_mode && (lbCurSel 38403) == -1) exitWith {hint localize "STR_Shop_Weapon_NoSelect"};

if(_mode) then {
	_item = param [1,"",[""]];
	_price = param [2,0,[0]];
	_goalDis = param [3,1,[0]];
}else{
	_price = lbValue[38403,(lbCurSel 38403)]; if(isNil "_price") then {_price = 0;};
	_item = lbData[38403,(lbCurSel 38403)];
	_goalDis = param [3,1,[0]];
};
if(_item == "") exitWith {};

_itemInfo = [_item] call OEC_fnc_fetchCfgDetails;

_bad = "";

private _adminIsle = false;
if (player distance2d (getMarkerPos "admin_island") < 120) then {_adminIsle = true;};

if !(_adminIsle) then {
	if((_itemInfo select 6) != "CfgVehicles") then {
		if((_itemInfo select 4) in [4096,131072]) then {
			if(!(player canAdd _item) && (uiNamespace getVariable["Weapon_Shop_Filter",0]) != 1) exitWith {_bad = (localize "STR_NOTF_NoRoom")};
		};
	};

	if(!(player canAdd _item) && !(_item isEqualTo "I_UAV_01_backpack_F") && !(isClass (configFile >> "CFGweapons" >> _item)) && (uiNamespace getVariable["Weapon_Shop_Filter",0]) != 1) then {_bad = (localize "STR_NOTF_NoRoom")};
};

if(_bad != "") exitWith {hint _bad};

if((_price > oev_warpts_count) && ((uiNamespace getVariable ["Weapon_Shop",""]) isEqualTo "war_market")) exitWith {hint "你没有足够的战争分数来完成这次交易!";};
if(_price > oev_atmcash && _price > oev_cash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};

_confirm = true;

if ((primaryWeapon player) != "" && _item isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
	_areYouSure = [
		format ["Are you sure you would like to buy a %1? It will replace your current primary weapon",_itemInfo select 1],
		"Confirm Weapon Purchase",
		"Yes",
		"No"
	] call BIS_fnc_guiMessage;
	if !(_areYouSure) exitWith {_confirm = false};
};

if (!((binocular player) isEqualTo "") && _item isKindOf ["Binocular", configFile >> "CfgWeapons"]) then {
	if(_item isKindOf ["NVGoggles", configFile >> "CfgWeapons"]) exitWith {};
	_areYouSure = [
		format ["Are you sure you would like to buy a %1? It will replace your current %2",_itemInfo select 1, binocular player],
		"Confirm Purchase",
		"Yes",
		"No"
	] call BIS_fnc_guiMessage;
	if !(_areYouSure) exitWith {_confirm = false};
};

if (!(headgear player isEqualTo "") && (_item isKindOf ["NVGoggles", configFile >> "CfgWeapons"]) && {(headgear player in ["H_PilotHelmetFighter_O","H_PilotHelmetFighter_B","H_PilotHelmetFighter_I"])}) then {
	_areYouSure = [
		format ["Are you sure you would like to buy a %1? It will replace your current headgear",_itemInfo select 1],
		"Confirm NVG Purchase",
		"Yes",
		"No"
	] call BIS_fnc_guiMessage;
	if !(_areYouSure) exitWith {_confirm = false};
};

if !(_confirm) exitWith {};

private _isWarShop = false;
if ((uiNamespace getVariable ["Weapon_Shop",""]) isEqualTo "war_market") then {_isWarShop = true;};

if !(_isWarShop) then {
	private _discount = 1;
	switch (uiNamespace getVariable ["Weapon_Shop",""]) do {
		// Gather Stats for kills
		case "rebel": {
			if (_item isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
				_perkTier = ["civ_kills"] call OEC_fnc_fetchStats;
				_discount = switch (_perkTier) do {
					case 1:{0.975};
					case 2:{0.95};
					case 3:{0.95};
					case 4:{0.95};
					case 5:{0.95};
					default {1};
				};
				_perkTier = ["civ_warKills"] call OEC_fnc_fetchStats;
				switch (_perkTier) do {
					case 1:{_discount = _discount - 0.02;};
					case 2:{_discount = _discount - 0.05;};
					case 3:{_discount = _discount - 0.10;};
					case 4:{_discount = _discount - 0.15;};
					case 5:{_discount = _discount - 0.15;};
					case 6:{_discount = _discount - 0.15;};
					default {_discount = _discount;};
				};
				if (_discount < 0.80) then {_discount = 0.80;}; // Cap at 80%
			};
			if ((2 - (_discount + _goalDis)) > (71 / 340)) then {
				_discount = (16 / 17);
			};
			_price = round (_price * _discount);
			if !(oev_armsCartel select 0 || oev_conquestData select 0) then {
				if !(_discount == 1) then {
					hint parseText format ["You bought a %1 for <t color='#8CFF9B'>$%2</t>. <br/> 15%3 of your purchase went to the owner of the Arms Cartel! <br/> You received a %4%3 discount for your total kills and war kills!",_itemInfo select 1,[_price] call OEC_fnc_numberText,"%",round((1 - _discount) * 100)];
				} else {
					hint parseText format ["You bought a %1 for <t color='#8CFF9B'>$%2</t>. <br/> 15%3 of your purchase went to the owner of the Arms Cartel!",_itemInfo select 1,[_price] call OEC_fnc_numberText,"%"];
				};
				private _update = (oev_armsCartel select 1);
				_update = _update + (_price * 0.15);
				oev_armsCartel set [1,_update];
			} else {
				if !(_discount == 1) then {
					hint parseText format ["You bought a %1 for <t color='#8CFF9B'>$%2</t>. <br/> You received a %4%3 discount for your total kills and war kills!",_itemInfo select 1,[_price] call OEC_fnc_numberText,"%",((1.0-_discount) * 100)];
				} else {
					hint parseText format ["You bought a %1 for <t color='#8CFF9B'>$%2</t>.",_itemInfo select 1,[_price] call OEC_fnc_numberText];
				};
			};
		};

		case "vigilante": {
			_perkTier = ["civ_vigiArrests"] call OEC_fnc_fetchStats;
			_discount = switch (_perkTier) do {
				case 1:{0.95};
				case 2:{0.925};
				case 3:{0.9};
				default{1};
			};
			_price = _price * _discount;
			if !(_discount == 1) then {
				hint parseText format["You bought a %1 for <t color='#8CFF9B'>$%2</t>. You received a %3%4 discount for your total arrests!",_itemInfo select 1,[_price] call OEC_fnc_numberText,((1.0-_discount) * 100),"%"];
			} else {
				hint parseText format[localize "STR_Shop_Weapon_BoughtItem",_itemInfo select 1,[_price] call OEC_fnc_numberText];
			};
		};

		case "cop_basic": {
			_perkTier = ["cop_pardons"] call OEC_fnc_fetchStats;
			_discount = switch (_perkTier) do {
				case 1:{0.97};
				case 2:{0.95};
				case 3:{0.93};
				case 4:{0.90};
				default {1};
			};
			_price = _price * _discount;
			if !(_discount == 1) then {
				hint parseText format["You bought a %1 for <t color='#8CFF9B'>$%2</t>. You received a %3%4 discount for your number of pardons!",_itemInfo select 1,[_price] call OEC_fnc_numberText,((1.0-_discount) * 100),"%"];
			} else {
				hint parseText format[localize "STR_Shop_Weapon_BoughtItem",_itemInfo select 1,[_price] call OEC_fnc_numberText];
			};
		};

		default {hint parseText format[localize "STR_Shop_Weapon_BoughtItem",_itemInfo select 1,[_price] call OEC_fnc_numberText];};
	};


	if (oev_cash >= _price) then {
		oev_cash = oev_cash - _price;
		oev_cache_cash = oev_cache_cash - _price;
	} else {
		oev_atmcash = oev_atmcash - _price;
		oev_cache_atmcash = oev_cache_atmcash - _price;
	};
} else {
	if(oev_armsCartel select 0) then {
		_price = round(_price * 0.85);
	};
	[[1,_price,player],"OES_fnc_warGetSetPts",false,false] spawn OEC_fnc_MP;
	hint parseText format ["You bought a %1 for <t color='#FF0000'>%2</t> pts.<br/>You have <t color='#8cff9b'>%3</t> pts left!",_itemInfo select 1,[_price] call OEC_fnc_numberText,(oev_warpts_count - _price)];
	oev_warpts_count = oev_warpts_count - _price;
	[
		["event","Warpoint Buy"],
		["player",name player],
		["player_id",getPlayerUID player],
		["item",_itemInfo select 1],
		["value",_price]
	] call OEC_fnc_logIt;
};

if (_adminIsle) then {
	private _crate = objNull;
	{
		if (((_x getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player)) exitWith {_crate = _x;};
	} forEach nearestObjects [player,["IG_supplyCrate_F"],50];
	if (isNull _crate) exitWith {closeDialog 0; hint "The purchase cannot be completed at this time. Please spawn a compensation crate!";};
	_crate addItemCargoGlobal [_item,1];
} else {
	//List of items to override the assignItem function in handleItem
	private _overrideItems = ["MineDetector"];
	//If the item is in the override items array then pass the parameter
	if (_item in _overrideItems) then {
		[_item,true,false,false,true] spawn OEC_fnc_handleItem;
	} else {
		[_item,true] spawn OEC_fnc_handleItem;
	};

	[false] call OEC_fnc_saveGear;

	if(_price >= 1000) then {
		[
			["event","Item Buy"],
			["player",name player],
			["player_id",getPlayerUID player],
			["item",_itemInfo select 1],
			["value",_price]
		] call OEC_fnc_logIt;
	};

	if(_price > 30000) then {
		[1] call OEC_fnc_ClupdatePartial;
	};
};
