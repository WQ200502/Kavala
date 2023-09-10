#include "..\..\macro.h"
//  File: fn_vehStoreItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Used in the vehicle trunk menu, stores the selected item and puts it in the vehicles virtual inventory
//	if the vehicle has room for the item.
private["_playerItemSelected","_quantity","_totalWeight","_itemWeight","_veh_data","_inv","_index","_val","_Truck","_FuelTrucks","_FuelStuff","_trunkUpgrade","_mods","_exit","_gangID"];
disableSerialization;

// Lagswitch checks
if!(oev_didServerRespond) exitWith {hint "等待服务器响应，几秒后再试一次...";};

//Nil cash values
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",name player],["player_id",getPlayerUID player],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)],["location",getPosATL player]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};
if((lbCurSel 4503) == -1) exitWith {hint localize "STR_Global_NoSelection";};

//Get the handles
_playerItemSelected = getSelData(4503); //Item Selected
_quantity = ctrlText 4506; //Amount entered
if(_playerItemSelected isEqualTo "") exitWith {hint localize "STR_Global_NoSelection";};

//Set quantity limit
//A bunch of checks
if !([_quantity] call OEC_fnc_isNumeric) exitWith {hint "无效号码格式";};
_quantity = parseNumber(_quantity);
if (_quantity isEqualTo 0) exitWith {hint "您需要输入要存储的金额!";};
if (_quantity < 1) exitWith {hint "You can't enter anything below 1!";};

//Distance check
private _vehPos = getPos oev_trunk_vehicle;
private _playerPos = getPos player;
if (_vehPos distance _playerPos > 10) exitWith {hint "你离得太远了!"; closeDialog 0;};

//Get the weight of the item
_itemWeight = 0;
_veh_data = [[],0];
_inv = []; //Trunk inventory

//Make sure they have the oil storage upgrade to be able to store oil
_exit = false;
_FuelStuff = ["oilu","oilp"];
if ((oev_trunk_vehicle isKindOf "House_F") && (_playerItemSelected in _FuelStuff)) then {
	private _storeOil = oev_trunk_vehicle getVariable ["oilstorage",false];
	if !(_storeOil) exitWith {_exit = true; hint "您必须购买石油存储插件，才能在家中存储石油.";};
};
if (_exit) exitWith {};

//can't store paintings in houses
if((oev_trunk_vehicle isKindOf "House_F") && (_playerItemSelected in ["paintingLg","paintingSm"])) exitWith {
	hint "你不能把画存放在房子里!";
};

//Set the boolean for logging
oev_houseInteract = true;

//Updating trunk with stored items
if (oev_virtualItems) then {
	_itemWeight = ([_playerItemSelected] call OEC_fnc_itemWeight) * _quantity;
	_veh_data = oev_trunk_vehicle getVariable ["Trunk",[[],0]];
	_inv = _veh_data select 0; //Trunk inventory
	if !(typeOf oev_trunk_vehicle isEqualTo "Land_i_Shed_Ind_F") then {
		_totalWeight = [(oev_trunk_vehicle getVariable["storageCapacity",100]),((oev_trunk_vehicle getVariable["Trunk",[[],0]]) select 1)];
	} else {
		_totalWeight = [(oev_trunk_vehicle getVariable["storageCapacity",1000]),((oev_trunk_vehicle getVariable["Trunk",[[],0]]) select 1)];
	};
	if (_playerItemSelected == "money") then {
		_index = [_playerItemSelected,_inv] call OEC_fnc_index;
		if (oev_cash < _quantity) exitWith {hint "你身上没有那么多现金可以放在车里!"};
		if (_index isEqualTo -1) then {
			_inv pushBack [_playerItemSelected,_quantity];
		} else {
			_val = _inv select _index select 1;
			_inv set[_index,[_playerItemSelected,_val + _quantity]];
		};

		oev_cash = oev_cash - _quantity;
		oev_cache_cash = oev_cache_cash - _quantity;
		oev_trunk_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _itemWeight],true];
		[oev_trunk_vehicle] call OEC_fnc_houseInventory;
	} else {
		//House too full
		if ((((_totalWeight select 1) + _itemWeight) > (_totalWeight select 0)) && !oev_adminForce) exitWith {hint "车辆已满或无法容纳那么多."};
		//Error in removing item from player
		if (!([false,_playerItemSelected,_quantity] call OEC_fnc_handleInv) && !oev_adminForce) exitWith {hint "无法将物品从你的库存中移到车上.";};
		_index = [_playerItemSelected,_inv] call OEC_fnc_index;
		if (_index isEqualTo -1) then {
			_inv pushBack [_playerItemSelected,_quantity];
		} else {
			_val = _inv select _index select 1;
			_inv set[_index,[_playerItemSelected,_val + _quantity]];
		};

		oev_trunk_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _itemWeight],true];
		if !(oev_adminForce) then {
			[oev_trunk_vehicle,true] call OEC_fnc_houseInventory;
		} else {
			if ((call life_adminlevel) < 3) exitWith {closeDialog 0;};
			[oev_trunk_vehicle,true] call OEC_fnc_adminHouseInv;
		};
	};

	[false] call OEC_fnc_saveGear;
	if !(oev_newsTeam) then {
		[3] call OEC_fnc_ClupdatePartial;
	};
} else {
	if !(typeOf oev_trunk_vehicle isEqualTo "Land_i_Shed_Ind_F") then {
		_totalWeight = [(oev_trunk_vehicle getVariable["physicalStorageCapacity",100]),((oev_trunk_vehicle getVariable["PhysicalTrunk",[[],0]]) select 1)];
	} else {
		_totalWeight = [(oev_trunk_vehicle getVariable["physicalStorageCapacity",200]),((oev_trunk_vehicle getVariable["PhysicalTrunk",[[],0]]) select 1)];
	};
	_itemWeight = getNumber (missionConfigFile >> "CfgWeights" >> (_playerItemSelected)  >> "weight");
	_veh_data = oev_trunk_vehicle getVariable ["PhysicalTrunk",[[],0]];
	_inv = _veh_data select 0; //Trunk inventory
	private _combinedWeight = _itemWeight;
	private _tempItem = "";
	private _index = -1;
	private _maxValue = if !(oev_adminForce) then {lbValue[4503,(lbCurSel 4503)];} else {200};
	if (_quantity > _maxValue) then {_quantity = _maxValue};
	//if !(_trunkItemSelected in _data) exitWith {closeDialog 0;};

	//Adjust arrays for weapon items
	private _fnc_adjustArray = {
		params ["_item","_array"];
		if !(_item isEqualTo "") then {
			private _index = -1;
			{
				if !(_index isEqualTo -1) exitWith {};
				if (_item isEqualTo (_x select 0)) exitWith {
					_index = _forEachIndex;
				};
			} forEach _array;
			if (_index isEqualTo -1) then {
				_array pushBack [_item,1];
			} else {
				_array set [_index,[_item,((_array select _index) select 1) + 1]];
			};
		};
		_array;
	};

	if !(oev_adminForce) then {
		for "_i" from 1 to _quantity do {
			switch(true) do {
				//Check if it is the primary weapon
				case(_playerItemSelected isEqualTo (primaryWeapon player) && !(_playerItemSelected in (items player))): {
					//Check for any primary weapon items
					{
						if !(_x isEqualTo "") then {
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						};
					} forEach (primaryWeaponItems player);
					//Check for any primary weapon mags
					{
						if !(_x isEqualTo "") then {
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						};
					} forEach (primaryWeaponMagazine player);
					//Weight check
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "The vehicle is either full or cannot hold that much."};
					{
						_inv = [_x,_inv] call _fnc_adjustArray;
					} forEach (primaryWeaponItems player);
					{
						_inv = [_x,_inv] call _fnc_adjustArray;
					} forEach (primaryWeaponMagazine player);
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removeWeaponGlobal _playerItemSelected;
				};
				//Check if it is a primary weapon attachment
				case((_playerItemSelected in (primaryWeaponItems player)) || (_playerItemSelected in (primaryWeaponMagazine player))): {
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removePrimaryWeaponItem _playerItemSelected;
				};
				//Check if it is the secondary weapon
				case(_playerItemSelected isEqualTo (secondaryWeapon player)): {
					{
						if !(_x isEqualTo "") then {
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						};
					} forEach (secondaryWeaponItems player);
					{
						if !(_x isEqualTo "") then {
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						};
					} forEach (secondaryWeaponMagazine player);
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					{
						_inv = [_x,_inv] call _fnc_adjustArray;
					} forEach (secondaryWeaponItems player);
					{
						_inv = [_x,_inv] call _fnc_adjustArray;
					} forEach (secondaryWeaponMagazine player);
		        	_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removeWeaponGlobal _playerItemSelected;
				};
				//Check if it is a secondary weapon attachment
				case((_playerItemSelected in (secondaryWeaponItems player)) || (_playerItemSelected in (secondaryWeaponMagazine player))): {
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removeSecondaryWeaponItem _playerItemSelected;
				};
				//Check if it is the handgun
				case(_playerItemSelected isEqualTo (handgunWeapon player)): {
					{
						if !(_x isEqualTo "") then {
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						};
					} forEach (handgunItems player);
					{
						if !(_x isEqualTo "") then {
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						};
					} forEach (handgunMagazine player);
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					{
						_inv = [_x,_inv] call _fnc_adjustArray;
					} forEach (handgunItems player);
					{
						_inv = [_x,_inv] call _fnc_adjustArray;
					} forEach (handgunMagazine player);_inv pushBack _x;
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removeWeaponGlobal _playerItemSelected;
				};
				//Check if it is a handgun attachment
				case((_playerItemSelected in (handgunItems player)) || (_playerItemSelected in (handgunMagazine player))): {
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removeHandgunItem _playerItemSelected;
				};
				//Check if it is a helmet
				case(_playerItemSelected isEqualTo (headgear player)): {
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					removeHeadgear player;
				};
				//Check if it is a pair of goggles
				case(_playerItemSelected isEqualTo (goggles player)): {
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					removeGoggles player;
				};
				//Check if it is an assigned item
				case(_playerItemSelected in (assignedItems player)): {
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					if (_playerItemSelected in ["Binocular","Rangefinder"]) then {
						player removeWeapon _playerItemSelected;
					} else {
						player unassignItem _playerItemSelected;
						player removeItem _playerItemSelected;
					};
				};
				//Check if it is a uniform
				case(_playerItemSelected isEqualTo (uniform player)): {
					private _uniformItems = uniformItems player;
					if (count _uniformItems > 0) then {
						{
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						} forEach _uniformItems;
					};
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					if (count _uniformItems > 0) then {
						{
							_inv = [_x,_inv] call _fnc_adjustArray;
						} forEach _uniformItems;
					};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					removeUniform player;
				};
				//Check if it is a vest
				case(_playerItemSelected isEqualTo (vest player)): {
					private _vestItems = vestItems player;
					if (count _vestItems > 0) then {
						{
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						} forEach _vestItems;
					};
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					if (count _vestItems > 0) then {
						{
							_inv = [_x,_inv] call _fnc_adjustArray;
						} forEach _vestItems;
					};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					removeVest player;
				};
				//Check if it is a backpack
				case(_playerItemSelected isEqualTo (backpack player)): {
					private _backpackItems = backpackItems player;
					if (count _backpackItems > 0) then {
						{
							_combinedWeight = _combinedWeight + getNumber (missionConfigFile >> "CfgWeights" >> (_x)  >> "weight");
						} forEach _backpackItems;
					};
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					if (count _backpackItems > 0) then {
						{
							_inv = [_x,_inv] call _fnc_adjustArray;
						} forEach _backpackItems;
					};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					removeBackpackGlobal player;
				};
				default {
					if !(_playerItemSelected in (itemsWithMagazines player)) exitWith {};
					if(((_totalWeight select 1) + _combinedWeight) > (_totalWeight select 0)) exitWith {hint "车辆已满或无法容纳那么多."};
					_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
					player removeItem _playerItemSelected;
				};
			};
			private _saveWeight = _inv call OEC_fnc_physicalInventoryWeight;
			_totalWeight set [1,_saveWeight];
		};
	} else {
		if ((call life_adminlevel) < 3) exitWith {closeDialog 0;};
		for "_i" from 1 to _quantity do {
			_inv = [_playerItemSelected,_inv] call _fnc_adjustArray;
		};
	};


	private _finalWeight = _inv call OEC_fnc_physicalInventoryWeight;
	oev_trunk_vehicle setVariable["PhysicalTrunk",[_inv,_finalWeight],true];
	if !(oev_adminForce) then {
		[oev_trunk_vehicle, false] call OEC_fnc_houseInventory;
	} else {
		if ((call life_adminlevel) < 3) exitWith {closeDialog 0;};
		[oev_trunk_vehicle, false] call OEC_fnc_adminHouseInv;
	};
};
