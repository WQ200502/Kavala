#include "..\..\macro.h"
//  File: fn_virt_update.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Update and fill the virtual shop menu.
private["_display","_gear_list","_shop_data","_name","_price","_icon"];
disableSerialization;

//Setup control vars.
_display = findDisplay 2400;
_gear_list = _display displayCtrl 2402;

//Purge list
lbClear _gear_list;

_shop_data = [life_shop_type] call OEC_fnc_virt_shops;

{
	_var = [_x,0] call OEC_fnc_varHandle;
	_val = missionNameSpace getVariable _var;
	_name = [_var] call OEC_fnc_varToStr;
	_icon = [_var] call OEC_fnc_iconConfig;

	if(_val > 0) then {
		_gear_list lbAdd format["%1x %2",_val,_name];
		_gear_list lbSetData [(lbSize _gear_list)-1,_x];
		_gear_list lbSetPicture [(lbSize _gear_list)-1,_icon];
	};
} forEach (_shop_data select 1);