#include "..\..\macro.h"
//  File: fn_vehStoreItem.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Used in the vehicle trunk menu, stores the selected item and puts it in the vehicles virtual inventory
//	if the vehicle has room for the item.
private["_ctrl","_num","_totalWeight","_itemWeight","_veh_data","_inv","_index","_val","_Truck","_FuelTrucks","_FuelStuff","_trunkUpgrade","_mods","_exit","_gangID"];
disableSerialization;
if(!oev_didServerRespond) exitWith {hint "Awaiting server response, try again in a few seconds..."};
if(isNil "oev_cash") then {oev_cash = 0; oev_cache_cash = oev_random_cash_val;};
if(isNil "oev_atmcash") then {oev_atmcash = 0; oev_cache_atmcash = oev_random_cash_val;};

if((oev_cash + (oev_random_cash_val - 5000)) > oev_cache_cash || (oev_atmcash + (oev_random_cash_val - 5000)) > oev_cache_atmcash) exitWith {
	[["event","Hacked Cash"],["player",getPlayerUID player],["target","null"],["hackedcash",oev_cash - (oev_cache_cash - oev_random_cash_val)],["hackedbank",oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]] call OEC_fnc_logIt;
	[[profileName,format["Hacked Cash Detected! (Cash Hacked In = %1) (Bank Hacked In = %2)",oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OEC_fnc_notifyAdmins",-2,false] spawn OEC_fnc_MP;
	[[1,player,[oev_cash - (oev_cache_cash - oev_random_cash_val),oev_atmcash - (oev_cache_atmcash - oev_random_cash_val)]],"OES_fnc_handleDisc",false,false] spawn OEC_fnc_MP;
	["HackedMoney",false,false] call compile PreProcessFileLineNumbers "\a3\functions_f\Misc\fn_endMission.sqf";
};

_ctrl = getSelData(3503);
_num = ctrlText 3506;
if(!([_num] call OEC_fnc_isNumeric)) exitWith {hint "Invalid Number format";};
_num = parseNumber(_num);
if (_num isEqualTo 0) exitWith {hint "You need to enter an amount to store!";};
if(_num < 1) exitWith {hint "You can't enter anything below 1!";};

private _vehPos = getPos oev_trunk_vehicle;
private _playerPos = getPos player;
_gangID = oev_trunk_vehicle getVariable ["gangID",0];
if (_vehPos distance _playerPos > 10) exitWith {hint "You are too far away!"; closeDialog 0;};

_trunkUpgrade = 0;
if(oev_trunk_vehicle isKindOf "House_F") then {
	_mWeight = oev_trunk_vehicle getVariable ["storageCapacity",100];
	_totalWeight = [_mWeight,((oev_trunk_vehicle getVariable["Trunk",[[],0]]) select 1)];
} else {
	_totalWeight = [oev_trunk_vehicle] call OEC_fnc_vehicle1Weight;
	_mods = oev_trunk_vehicle getVariable["modifications",[0,0,0,0,0,0,0,0]];
	_trunkUpgrade = round((_mods select 1) * ((_totalWeight select 0) * 0.05));

};
_itemWeight = ([_ctrl] call OEC_fnc_itemWeight) * _num;
_veh_data = oev_trunk_vehicle getVariable ["Trunk",[[],0]];
_inv = _veh_data select 0;
_vehPlate = (oev_trunk_vehicle getVariable "dbInfo");
_plate = _vehPlate select 1;


_totalWeight set[0,((_totalWeight select 0) + _trunkUpgrade)];

if(_ctrl == "goldbar" && {!(oev_trunk_vehicle isKindOf "LandVehicle" || oev_trunk_vehicle isKindOf "House_F")}) exitWith {hint "You can only store gold in land vehicles and houses!"};
if(_ctrl == "moneybag" && {!(oev_trunk_vehicle isKindOf "LandVehicle" || oev_trunk_vehicle isKindOf "House_F")}) exitWith {hint "You can only store money bags in land vehicles and houses!"};
if(_ctrl in ["paintingSm","paintingLg"] && {!(oev_trunk_vehicle isKindOf "LandVehicle" || oev_trunk_vehicle isKindOf "House_F")}) exitWith {hint "You can only store paintings in land vehicles!"};

_Truck = TypeOf oev_trunk_vehicle;
_FuelStuff = ["oilu","oilp"];
_FuelTrucks = ["O_Heli_Transport_04_fuel_F","B_Truck_01_fuel_F","O_Truck_03_fuel_F","I_Truck_02_fuel_F","C_Van_01_fuel_F"];

_exit = false;
if !(oev_trunk_vehicle isKindOf "House_F") then {
	switch (true) do {
		case (!(_ctrl in _FuelStuff) && (_Truck in _FuelTrucks)): {_exit = true; hint "You can only store oil related items in Fuel vehicles.";};
		case ((_ctrl in _FuelStuff) && !(_Truck in _FuelTrucks)): {_exit = true; hint "Only (Fuel) variants of vehicles can store oil."};
		default {_exit = false;};
	};
};
if ((_exit) && !(oev_trunk_vehicle isKindOf "House_F")) exitWith {};

_exit = false;
if ((oev_trunk_vehicle isKindOf "House_F") && (_ctrl in _FuelStuff)) then {
	private _storeOil = oev_trunk_vehicle getVariable ["oilstorage",false];
	if !(_storeOil) exitWith {_exit = true; hint "You must purchase the oil storage addon to be able to store oil in your home.";};
};
if (_exit) exitWith {};

if(_ctrl == "money") then {
	_index = [_ctrl,_inv] call OEC_fnc_index;
	if(oev_cash < _num) exitWith {hint "You don't have that much cash on you to store in the vehicle!"};
	if(_index == -1) then {
		_inv pushBack [_ctrl,_num];
	} else {
		_val = _inv select _index select 1;
		_inv set[_index,[_ctrl,_val + _num]];
	};

	oev_cash = oev_cash - _num;
	oev_cache_cash = oev_cache_cash - _num;
	oev_trunk_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _itemWeight],true];
	[oev_trunk_vehicle] call OEC_fnc_vehInventory;
} else {
	if(((_totalWeight select 1) + _itemWeight) > (_totalWeight select 0)) exitWith {hint "The vehicle is either full or cannot hold that much."};

	if(!([false,_ctrl,_num] call OEC_fnc_handleInv)) exitWith {hint "Couldn't remove the items from your inventory to put in the vehicle.";};
	_index = [_ctrl,_inv] call OEC_fnc_index;
	if(_index == -1) then {
		_inv pushBack [_ctrl,_num];
	} else {
		_val = _inv select _index select 1;
		_inv set[_index,[_ctrl,_val + _num]];
	};
	_log_event = "";
	if !(_gangID isEqualTo 0) then {
		_log_event = "Put Item Into Gang Vehicle";
	} else {
		_log_event = "Put Item Into Vehicle";
	};
	[
		["event",_log_event],
		["player",name player],
		["player_id",getPlayerUID player],
		["target",typeOf oev_trunk_vehicle],
		["item",_ctrl],
		["amount",_num],
		["plate",_plate],
		["position",getPosATL player]
	] call OEC_fnc_logIt;

	oev_trunk_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _itemWeight],true];
	[oev_trunk_vehicle] call OEC_fnc_vehInventory;
};

[false] call OEC_fnc_saveGear;
if !(oev_newsTeam) then {
	[3] call OEC_fnc_ClupdatePartial;
};
