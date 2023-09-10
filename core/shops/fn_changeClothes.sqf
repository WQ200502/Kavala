//  File: fn_changeClothes.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Used in the clothing store to show a 'preview' of the piece of clothing.
disableSerialization;
private["_control","_selection","_data","_price","_total","_totalPrice"];
_control = (_this select 0) select 0;
_selection = (_this select 0) select 1;
_price = (findDisplay 3100) displayCtrl 3102;
_total = (findDisplay 3100) displayCtrl 3106;
if(_selection == -1) exitWith {hint localize "STR_Shop_NoSelection";};
if(isNull _control) exitWith {hint localize "STR_Shop_NoDisplay"};
if((player getVariable ["restrained",false]) || (player getVariable["downed",false])) exitWith {systemChat "你不能在被击倒时进入服装店。"; closeDialog 0;};
if(player getVariable ["zipTied",false]) exitWith {systemChat "你不能在受到限制的情况下进入服装店。"; closeDialog 0;};
if(life_cMenu_lock) exitWith {};

_data = _control lbData _selection;
if(_data == (vest player) || _data == (headgear player)) exitWith {};

life_cMenu_lock = true;

oev_clothing_purchase set[oev_clothing_filter,(_control lbValue _selection)];
oev_clothing_data set[oev_clothing_filter,(_control lbData _selection)];


[_data,true,nil,nil,nil,nil,nil,true] call OEC_fnc_handleItem;
life_cMenu_lock = false;
_price ctrlSetStructuredText parseText format [(localize "STR_GNOTF_Price")+ " <t color='#8cff9b'>$%1</t>",[(_control lbValue _selection)] call OEC_fnc_numberText];

_totalPrice = 0;
{
	if(_x != -1) then
	{
		_totalPrice = _totalPrice + _x;
	};
} foreach oev_clothing_purchase;

_total ctrlSetStructuredText parseText format [(localize "STR_Shop_Total")+ " <t color='#8cff9b'>$%1</t>",[_totalPrice] call OEC_fnc_numberText];
