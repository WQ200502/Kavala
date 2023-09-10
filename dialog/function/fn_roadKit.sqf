#include "..\..\macro.h"
//  File: fn_roadKit.sqf
//	Author: Ozadu
//	Description: Handles the road kit dialog
params[["_mode","",[""]]];

disableSerialization;
waitUntil {!isNull findDisplay 7365};

if !(isNull objectParent player) exitWith {closeDialog 0; hint "当您在车内时，不能使用公路工具包。";};
if (playerSide isEqualTo civilian || oev_newsTeam) exitWith {closeDialog 0; hint "平民无法使用道路工具包。";};
if (playerSide isEqualTo west && {oev_inCombat}) exitWith {closeDialog 0; hint "标记为战斗中时，您不能使用公路工具包。";};

_list = getControl(7365,2857);
switch (_mode) do {
	case "load":{
		_index =  _list lbAdd "1. 路锥";
		_list lbSetData [_index,"Cone"];
		_index = _list lbAdd "2. 路障";
		_list lbSetData [_index,"Barrier"];
		if(__GETC__(life_medicLevel) > 2 || call (life_coplevel) > 2) then {
			_index = _list lbAdd "3. 移动式直升机停机坪灯";
			_list lbSetData [_index,"HelipadLight"];
		};
	};

	case "select":{
		_selectedItem = getSelData(2857);
		[_selectedItem] call OEC_fnc_medicPlaceables;
		closeDialog 0;
	};
};
