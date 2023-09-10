#include "..\..\macro.h"
//  File: fn_virt_buy.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Buy a virtual item from the store.

private["_type","_price","_amount","_diff","_name","_hideout","_marketprice"];
if (oev_purchActive) exitWith {hint "You currently have an active purchase or sale pending... please wait.";};
ctrlEnable[2406,false];
oev_purchActive = true;

if((lbCurSel 2401) isEqualTo -1) exitWith {hint localize "STR_Shop_Virt_Nothing"; oev_purchActive = false; ctrlEnable[2406,true];};
_type = lbData[2401,(lbCurSel 2401)];
_price = lbValue[2401,(lbCurSel 2401)];
_amount = ctrlText 2404;
if(!([_amount] call OEC_fnc_isNumeric)) exitWith {hint localize "STR_Shop_Virt_NoNum"; oev_purchActive = false; ctrlEnable[2406,true];};
_amount = parseNumber(_amount);
if (_amount > 120) exitWith {hint "You cannnot purchase more than 120 items at once."; oev_purchActive = false; ctrlEnable[2406,true];};
if (_amount isEqualTo 0) exitWith {hint "You need to enter an amount to buy!"; oev_purchActive = false; ctrlEnable[2406,true];};
_name = [([_type,0] call OEC_fnc_varHandle)] call OEC_fnc_varToStr;

private _exit = false;
if ((__GETC__(life_adminlevel) > 2) && (player distance2d (getMarkerPos "admin_island") < 120)) exitWith {
	private _crate = objNull;
	{
		if (((_x getVariable ["owner",["",""]]) select 0) isEqualTo (getPlayerUID player)) exitWith {_crate = _x;};
	} forEach nearestObjects [player,["IG_supplyCrate_F"],50];
	if (isNull _crate) exitWith {_exit = true; hint "The purchase cannot be completed at this time. Please spawn a compensation crate!"; closeDialog 0;};
	private _trunk = _crate getVariable ["trunk",[[],0]];
	private _inventory = _trunk select 0;
	private _index = [_type,_inventory] call OEC_fnc_index;
	if (_index isEqualTo -1) then {
		_inventory pushBack [_type,_amount];
	} else {
		private _val = _inventory select _index select 1;
		_inventory set [_index,[_type,(_val + _amount)]];
	};
	_crate setVariable ["trunk",[_inventory,0],true];
	ctrlEnable[2406,true];
	oev_purchActive = false;
};
if (_exit) exitWith {oev_purchActive = false; ctrlEnable[2406,true];};

private _mrktIndex = oev_market_arr find _type;
if (_mrktIndex isEqualTo -1) then {
	_marketprice = -1;
} else {
	_price = ((serv_market_current select _mrktIndex) select 0);
};

_diff = [_type,_amount,oev_carryWeight,oev_maxWeight] call OEC_fnc_calWeightDiff;
if(_diff <= 0) exitWith {hint localize "STR_NOTF_NoSpace"; ctrlEnable[2406,true]; oev_purchActive = false;};
_amount = _diff;
_hideout = (nearestObjects[getPosATL player,["Land_u_Barracks_V2_F","Land_i_Barracks_V2_F"],25]) select 0;

if ((_price * _amount) > oev_atmcash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"; oev_purchActive = false; ctrlEnable[2406,true];};

if([true,_type,_amount] call OEC_fnc_handleInv) then {
	if((_price * _amount) > oev_atmcash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"; [false,_type,_amount] call OEC_fnc_handleInv; oev_purchActive = false;};
	hint format[localize "STR_Shop_Virt_BoughtItem",_amount,_name,[(_price * _amount)] call OEC_fnc_numberText];

	oev_atmcash = oev_atmcash - (_price * _amount);
	oev_cache_atmcash = oev_cache_atmcash - (_price * _amount);

	if ((_price * _amount) >= 1000) then {
		[
			["event","Item Buy"],
			["player",name player],
			["player_id",getPlayerUID player],
			["item",_name],
			["amount",_amount],
			["value",(_price * _amount)]
		] call OEC_fnc_logIt;
	};
	[] call OEC_fnc_virt_update;

	if (life_shop_type isEqualTo "dopamine") then {
		private _crate = nearestObject [player,"Land_Cargo10_yellow_F"];
		if (isNull _crate) exitWith {};
		private _uid = _crate getVariable ["owner",""];
		if (_uid isEqualTo "") exitWith {};

		private _playerObject = objNull;
		{
			if(isPlayer _x && getPlayerUID _x isEqualTo _uid) exitWith {
				_playerObject = _x;
			};
		} forEach playableUnits;
		if !(isNull _playerObject) then {
			// [[(_price * _amount),player,1],"OEC_fnc_clientWireTransfer",_playerObject,false] spawn OEC_fnc_MP;
			// [(_price * _amount),player,1] remoteExec ["OEC_fnc_clientWireTransfer", _playerObject, false];
			[[3,(_price * _amount), name player],"OEC_fnc_payPlayer",_playerObject,false] spawn OEC_fnc_MP;
		};
	};
};

[false] call OEC_fnc_saveGear;

if(_amount > 5000) then {
	[1] call OEC_fnc_ClupdatePartial;
};

ctrlEnable[2406,true];
oev_purchActive = false;
