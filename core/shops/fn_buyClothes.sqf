#include "..\..\macro.h"
//  File: fn_buyClothes.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Buys the current set of clothes and closes out of the shop interface.
private["_price"];

if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

if((lbCurSel 3101) == -1 && !(missionNamespace getVariable ["oev_clothing_usedLoadout", false])) exitWith {titleText[localize "STR_Shop_NoClothes","PLAIN DOWN"];};

_price = 0;
{
	if(_x != -1) then
	{
		_price = _price + _x;
	};
} foreach oev_clothing_purchase;

if((_price > oev_warpts_count) && (life_clothing_store isEqualTo "war")) exitWith {hint "你没有足够的战争分数来完成这次交易!";};
if(_price > oev_atmcash && _price > oev_cash) exitWith {titleText[localize "STR_Shop_NotEnoughClothes","PLAIN DOWN"];};

private _pDLC = getDlcs 1;
private _nDLC = false;
private _type = "";

{
	if (_x != "") then {
		if (_x isEqualTo oev_clothing_data#4) then {_type = "CfgVehicles"} else {_type = "CfgWeapons"};
		switch (getText (configFile >> _type >> _x >> 'DLC')) do {
			case 'Expansion': {
				if !(395180 in _pDLC) exitWith {_nDLC = true};
			};
			case 'Jets': {
				if !(601670 in _pDLC) exitWith {_nDLC = true};
			};
			case 'Orange': {
				if !(571710 in _pDLC) exitWith {_nDLC = true};
			};
			case 'Kart': {
				if !(288520 in _pDLC) exitWith {_nDLC = true};
			};
			case 'Heli': {
				if !(304380 in _pDLC) exitWith {_nDLC = true};
			};
			default {};
		};

	};
} forEach oev_clothing_data;

if (_nDLC) then {
	private _action = [
		"One or more of the items you are trying to purchase requires a DLC you don't own. Upon purchase the item will be added to you but if dropped, you will not be able to pick it up. Are you sure you would like to continue?",
		"Confirmation",
		"Yes",
		"No"
	] call BIS_fnc_guiMessage;

	if (_action) exitWith {_nDlc = false};
};

if (_nDLC) exitWith {};

private _fnc_finishPurchase = {
	params [
		["_interrupted", false, [false]]
	];
	if (_interrupted) exitWith {
		closeDialog 0;
	};
	if !(life_clothing_store isEqualTo "war") then {
		if ((oev_clothing_data select 3) isEqualTo "V_HarnessOGL_brn") then {
			private _perkTier = ["civ_suicideVests"] call OEC_fnc_fetchStats;
			private _suiVestDisc = switch (_perkTier) do {
				case 1: {60000};
				case 2: {120000};
				default {0};
			};
			_price = _price - _suiVestDisc;
		};
		if (oev_cash >= _price) then {
			oev_cash = oev_cash - _price;
			oev_cache_cash = oev_cache_cash - _price;
		} else {
			oev_atmcash = oev_atmcash - _price;
			oev_cache_atmcash = oev_cache_atmcash - _price;
		};
	} else {
		[[1,_price,player],"OES_fnc_warGetSetPts",false,false] spawn OEC_fnc_MP;
		oev_warpts_count = oev_warpts_count - _price;
	};
	if ((oev_clothing_data select 3) isEqualTo "V_HarnessOGL_brn") then {
		[
			["event","Purchased Suicide Vest"],
			["player",name player],
			["player_id",getPlayerUID player],
			["position",getPosATL player],
			["shop_type",life_clothing_store],
			["price",_price]
		] call OEC_fnc_logIt;
	};


	life_clothesPurchased = true;

	closeDialog 0;

	[] call OEC_fnc_hudUpdate;

	if ((__GETC__(life_newslevel) >= 1) && (backpack player isEqualTo "B_AssaultPack_blk")) then {
		backpackContainer player setObjectTextureGlobal [0,""];
	};
};

if (missionNamespace getVariable ["oev_clothing_usedLoadout", false]) then {
	[
		"Purchasing Loadout",
		5,
		{
			if (!dialog) exitWith { true };
			false
		},
		_fnc_finishPurchase,
		""
	] call OEC_fnc_interruptableAction;
} else {
	[] call _fnc_finishPurchase;
};
