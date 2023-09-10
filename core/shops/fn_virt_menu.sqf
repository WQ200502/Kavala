#include "..\..\macro.h"
//  File: fn_virt_menu.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Initialize the virtual shop menu.
private["_shop","_item_list","_display","_shop_data","_price","_name","_index","_icon","_var","_admin"];
_shop = _this select 3;
if(isNil {_shop}) exitWith {};
life_shop_type = _shop;
life_shop_npc = _this select 0;
if (_shop == "cop" && playerSide != west) exitWith {hint localize "STR_NOTF_NotACop"};
if (oev_newsTeam && {!(_shop isEqualTo "market")}) exitWith {hint "You cannot access this store while acting as a News Member!"; closeDialog 0;};
_admin = false;
if (player distance2d (getMarkerPos "admin_island") < 120) then {_admin = true;};
["shops_menu"] call OEC_fnc_createDialog;

disableSerialization;

//Setup control vars.
_display = findDisplay 2400;
_item_list = _display displayCtrl 2401;
lbClear _item_list;

_shop_data = [life_shop_type] call OEC_fnc_virt_shops;
ctrlSetText[2403,format["%1", _shop_data select 0]];

if !(_admin) then {
	{
		_var = [_x,0] call OEC_fnc_varHandle;
		_name = [_var] call OEC_fnc_varToStr;
		_index = [_x,__GETC__(oev_buy_array)] call OEC_fnc_index;
		_icon = [_var] call OEC_fnc_iconConfig;
		if(_index != -1) then {
			_price = (((__GETC__(oev_buy_array) select _index) select 1) * __GETC__(life_medDis));
			_item_list lbAdd format["%1  ($%2)",_name,[_price] call OEC_fnc_numberText];
			_item_list lbSetData [(lbSize _item_list)-1,_x];
			_item_list lbSetValue [(lbSize _item_list)-1,_price];
			_item_list lbSetPicture [(lbSize _item_list)-1,_icon];
		};
	} forEach (_shop_data select 1);
} else {
	{
		_var = [_x,0] call OEC_fnc_varHandle;
		_name = [_var] call OEC_fnc_varToStr;
		_index = [_x,__GETC__(oev_admin_array)] call OEC_fnc_index;
		_icon = [_var] call OEC_fnc_iconConfig;
		if(_index != -1) then {
			_price = ((__GETC__(oev_admin_array) select _index) select 1);
			_item_list lbAdd format["%1  ($%2)",_name,[_price] call OEC_fnc_numberText];
			_item_list lbSetData [(lbSize _item_list)-1,_x];
			_item_list lbSetValue [(lbSize _item_list)-1,_price];
			_item_list lbSetPicture [(lbSize _item_list)-1,_icon];
		};
	} forEach (_shop_data select 1);
};

[] call OEC_fnc_virt_update;

waitUntil { !dialog };
[false] call OEC_fnc_saveGear;

if(oev_lastSynced_gear != format["%1",life_gear]) then {
	[1] call OEC_fnc_ClupdatePartial;
	if !(oev_newsTeam) then {
		[3] call OEC_fnc_ClupdatePartial;
	};
};