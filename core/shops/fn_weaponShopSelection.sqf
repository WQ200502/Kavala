#include "..\..\macro.h"
//  File: fn_weaponShopSelection.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Checks the weapon & adds the price tag.
private["_control","_index","_priceTag","_price","_item"];
_control = param [0,controlNull,[controlNull]];
_index = param [1,-1,[0]];
if(isNull _control || _index == -1) exitWith {closeDialog 0;}; //Bad data

_priceTag = ((findDisplay 38400) displayCtrl 38404);
_item = _control lbData _index;
if((uiNamespace getVariable["Weapon_Shop_Filter",0]) == 1) then
{
	_iS = [_item,__GETC__(oev_weapon_shop_array)] call OEC_fnc_index;
	if(_iS == -1) then
	{
		_price = 0;
	}
		else
	{
		_price = (__GETC__(oev_weapon_shop_array) select _iS) select 1;
	};
	_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>价格: <t color='#8cff9b'>%1元</t></t>",[(_price)] call OEC_fnc_numberText];
	_control lbSetValue[_index,_price];
}
	else
{
	_price = _control lbValue _index;
	if(_price > oev_atmcash) then
	{
		_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>价格: <t color='#ff0000'>%1元</t><br/>You lack: <t color='#8cff9b'>%2元</t></t>",[(_price)] call OEC_fnc_numberText,[(_price - oev_cash)] call OEC_fnc_numberText];
	}
		else
	{
		_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>价格: <t color='#8cff9b'>%1元</t></t>",[(_price)] call OEC_fnc_numberText];
	};
};