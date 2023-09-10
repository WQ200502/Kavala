#include "..\..\macro.h"
//  File: fn_factionItems.sqf
//	Author: Astral
//	Description: Determines the items in each rank's shop.

params [
	["_faction",0,[0]],
	["_type",0,[0]]
];

_return = [];
_itemList = [];

// 1- cop. 2- med. 3- vigi. 4- rebel.

switch (_faction) do {
	case 1: {
		switch (true) do {
			case (__GETC__(life_coplevel) isEqualTo 1): {
				_itemList = ["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","painkillers","tbacon","blindfold","heliTowHook","gokart","dopeShot"];
				{
					_return pushBack ([_x,0] call OEC_fnc_varHandle);
				} forEach _itemList;
			};
			case (__GETC__(life_coplevel) isEqualTo 2): {
				_itemList = ["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","painkillers","tbacon","blindfold","heliTowHook","gokart","boltcutter","dopeShot"];
				{
					_return pushBack ([_x,0] call OEC_fnc_varHandle);
				} forEach _itemList;
			};
			case (__GETC__(life_coplevel) isEqualTo 3): {
				_itemList = ["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","painkillers","tbacon","blindfold","heliTowHook","gokart","boltcutter","baitcar","vehAmmo","dopeShot"];
				{
					_return pushBack ([_x,0] call OEC_fnc_varHandle);
				} forEach _itemList;
			};
			case (__GETC__(life_coplevel) >= 4): {
				_itemList = ["donuts","coffee","spikeStrip","water","fuelF","defusekit","gpstracker","egpstracker","bloodbag","epiPen","painkillers","tbacon","blindfold","heliTowHook","gokart","boltcutter","baitcar","vehAmmo","dopeShot"];
				{
					_return pushBack ([_x,0] call OEC_fnc_varHandle);
				} forEach _itemList;
			};
		};
	};

	case 2: {
		if(__GETC__(life_medicLevel) >= 1) then {
			_itemList = ["water","lollypop","tbacon","potato","fuelF","heliTowHook","gokart","bloodbag","epiPen","painkillers","fireaxe"];
			{
				_return pushBack ([_x,0] call OEC_fnc_varHandle);
			} forEach _itemList;
		} else {
			_itemList = ["water","redgull","tbacon","potato","fuelF","heliTowHook","gokart","bloodbag","epiPen","dopeShot"];
			{
				_return pushBack ([_x,0] call OEC_fnc_varHandle);
			} forEach _itemList;
		};
	};

	case 3: {
		_itemList = ["water","redgull","tbacon","potato","ziptie","blindfold","bloodbag","epiPen","dopeShot"];
		{
			_return pushBack ([_x,0] call OEC_fnc_varHandle);
		} forEach _itemList;
	};

	case 4: {
		_itemList = ["water","beer","epiPen","dopeShot","redgull","tbacon","potato","lockpick","fuelF","ziptie","boltcutter","blastingcharge","hackingterminal","gpstracker","egpstracker","gpsjammer","speedbomb","heliTowHook","bloodbag","blindfold","scalpel","vehAmmo","takeoverterminal"];
		{
			_return pushBack ([_x,0] call OEC_fnc_varHandle);
		} forEach _itemList;
	};
};

_return;
