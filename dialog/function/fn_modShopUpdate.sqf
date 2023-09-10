#include "..\..\macro.h"
//  File: fn_modShopUpdate
//	Description: updates the mod shop display and stuff
disableSerialization;
private["_vehicle","_total","_ctrl","_shopType","_vehicleDetails","_colorArray","_trunkBaseWeight","_temp","_turboMod","_totalPrice","_modshop_storagePrice","_modshop_securityPrice","_modshop_turboPrice","_modshop_insurancePrice","_modshop_paintFinishPrice","_isDriver","_insurLevel","_turboLevel","_securLevel","_storageLevel","_paintFinish","_insurance","_mods","_color","_className","_dataArr","_vehicleColor","_vehicleInfo","_trunkSpace","_buyPrice","_retrievePrice","_mods","_securitySystems","_insurance","_upgrade1","_upgrade3","_upgrade4","_upgrade5","_upgrade6","_upgrade7","_tier"];
_vehicle = param [0,ObjNull,[ObjNull]];
_isDriver = true;
if(vehicle player != player) then
{
	if(driver (vehicle player) != player) then {
		_isDriver = false;
	};
};

// if you add a vehicle here, you need to go to fn_colorVehicle.sqf and add it to either _oneRegionChrome, _twoRegionChrome, or _oneRegionChrome ONLY PICK ONE!
_chromableVehicles = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_03_black_F","C_Offroad_01_repair_F","B_Heli_Light_01_F","B_Quadbike_01_F","C_Offroad_01_F","I_MRAP_03_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_F","C_Boat_Civil_01_police_F","I_Truck_02_transport_F","I_Truck_02_covered_F","I_Heli_Transport_02_F","O_LSV_02_unarmed_viper_F","O_T_LSV_02_armed_F"];

if(!_isDriver) exitWith {closeDialog 0; hint "你必须是司机才能改装车辆！";};
if(isNull _vehicle) exitWith {closeDialog 0;};
if(modshop_vehicle != _vehicle) exitWith {closeDialog 0; hint "这不是您要改装的车辆！";};

waitUntil {!isNull (findDisplay 40000)};
ctrlShow[2803,false];
ctrlShow[2830,false];

_total = (findDisplay 40000) displayCtrl 40001;
_turboMod = (findDisplay 40000) displayCtrl 40010;
_insurLevel = (findDisplay 40000) displayCtrl 40900;
_turboLevel = (findDisplay 40000) displayCtrl 40901;
_securLevel = (findDisplay 40000) displayCtrl 40902;
_storageLevel = (findDisplay 40000) displayCtrl 40903;
_paintFinish = (findDisplay 40000) displayCtrl 40904;
_colorIndex = lbData[2304,(lbCurSel 2304)];
if !(_colorIndex isEqualTo -200) then {
	modshop_paintFinish = [lbData[40503,(lbCurSel 40503)],modshop_paintFinish select 1];
} else {
	modshop_paintFinish = modshop_old_paintFinish;
};

_className = typeof _vehicle;
if(playerSide isEqualTo independent && !(_className in ["B_Heli_Light_01_F","C_SUV_01_F","O_Heli_Light_02_unarmed_F","B_MRAP_01_F"])) then {modshop_paintFinish = modshop_old_paintFinish;};
if (playerSide isEqualTo west && !(_className in ["B_Heli_Transport_01_F","B_Heli_Light_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","O_Heli_Light_02_unarmed_F","O_LSV_02_unarmed_viper_F","B_MRAP_01_F"])) then {modshop_paintFinish = modshop_old_paintFinish;};

_vehicleDetails = ["allVehicles", _className] call OEC_fnc_vehicleConfig;
if(_vehicle getVariable ["modifications",[0,0,0,0]] select 3 isEqualTo 1) then {
	_vehicleDetails set[6,2000000];
};
_trunkBaseWeight = _vehicleDetails select 9;

if(_className in ["B_Heli_Transport_03_black_F","B_Heli_Transport_01_camo_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F","O_T_VTOL_02_infantry_F"]) then {
	ctrlEnable[40101,false];
	ctrlEnable[40102,false];
};

if(_className in ["C_Plane_Civil_01_racing_F"] && playerSide isEqualTo civilian && _vehicle getVariable ["modifications", [0,0,0,0,0,0,0,0]] select 3 isEqualTo 1) then {
	ctrlEnable[40101,false];
	ctrlEnable[40102,false];
};

if (_className in ["B_SDV_01_F","O_SDV_01_F"]) then {
	ctrlEnable [40901,false];
};

// chrome whitelist
if(!(_className in _chromableVehicles)) then {
	ctrlEnable[40501,false];
	ctrlEnable[40502,false];
};

if((playerSide != civilian) || (modshop_noupdateskin == 1)) then {
	ctrlEnable[40501,false];
	ctrlEnable[40502,false];
	ctrlEnable[40503,false];
};

if (playerSide isEqualTo west && _className in ["O_LSV_02_unarmed_viper_F"]) then {
	ctrlEnable[40501,true];
	ctrlEnable[40502,true];
	ctrlEnable[40503,true];
};

if (playerSide isEqualTo independent && _classname in ["B_Heli_Light_01_F","C_SUV_01_F","O_Heli_Light_02_unarmed_F","B_MRAP_01_F"]) then {
	ctrlEnable[40503,true];
};

if (playerSide isEqualTo west && _classname in ["B_Heli_Transport_01_F","B_Heli_Light_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","O_Heli_Light_02_unarmed_F","O_LSV_02_unarmed_viper_F","B_MRAP_01_F"]) then {
	ctrlEnable[40503,true];
};

switch (modshop_insurance) do {
	case 0: {_insurLevel ctrlSetText "保险";};
	case 1: {_insurLevel ctrlSetText "基本覆盖";};
	case 2: {_insurLevel ctrlSetText "完全覆盖";};
};

switch (modshop_turbo) do {
	case 0: {_turboLevel ctrlSetText "库存";};
	case 1: {_turboLevel ctrlSetText "层级 1";};
	case 2: {_turboLevel ctrlSetText "层级 2";};
	case 3: {_turboLevel ctrlSetText "层级 3";};
	case 4: {_turboLevel ctrlSetText "层级 4";};
};

switch (modshop_security) do {
	case 0: {_securLevel ctrlSetText "出厂设置";};
	case 1: {_securLevel ctrlSetText "售后报警";};
	case 2: {_securLevel ctrlSetText "总部安全系统";};
	case 3: {_securLevel ctrlSetText "跟踪安全系统";};
};


switch (modshop_storage) do {
	case 0: {_storageLevel ctrlSetText "库存";};
	default {_storageLevel ctrlSetText format[" + %1",round(modshop_storage * (_trunkBaseWeight * 0.05))];};
};

switch (modshop_paintFinish select 1) do {
	case 1: {_paintFinish ctrlSetText "光泽度";};
	case 2: {_paintFinish ctrlSetText "镀铬";};
	case 3: {_paintFinish ctrlSetText "金饰";};
	default {_paintFinish ctrlSetText "没有完成";};
};

modshop_price = 0;

if(count _vehicleDetails > 0) then {
	_buyPrice = ((_vehicleDetails select 6) * __GETC__(life_medDis));
} else {
	_buyPrice = 1000;
};

_modshop_storagePrice = (modshop_storage - modshop_old_storage) * (_buyPrice * 0.125);
_modshop_securityPrice = (modshop_security - modshop_old_security) * (_buyPrice * 0.1);
_modshop_turboPrice = (modshop_turbo - modshop_old_turbo) * (_buyPrice * 0.05);
_modshop_insurancePrice = (modshop_insurance - modshop_old_insurance) * (_buyPrice * 0.4);

// the following makes gloss/chrome each cost 150% buy price and gold free after buying chrome
_CHROME_MULTI = 1.5;
_modshop_paintFinishPrice = if ((modshop_paintFinish select 1) > 2) then {_buyPrice * _CHROME_MULTI * 2} else {_buyPrice * _CHROME_MULTI * (modshop_paintFinish select 1)};
_modshop_paintFinishPrice = _modshop_paintFinishPrice - (if ((modshop_old_paintFinish select 1) > 2) then {_buyPrice * _CHROME_MULTI * 2} else {_buyPrice * _CHROME_MULTI * (modshop_old_paintFinish select 1)});

if(_modshop_storagePrice > 0) then {
	modshop_price = modshop_price + _modshop_storagePrice;
};

if(_modshop_securityPrice > 0) then {
	modshop_price = modshop_price + _modshop_securityPrice;
};

if(_modshop_turboPrice > 0) then {
	modshop_price = modshop_price + _modshop_turboPrice;
};

if(_modshop_insurancePrice > 0) then {
	modshop_price = modshop_price + _modshop_insurancePrice;
};

if(_modshop_paintFinishPrice > 0) then {
	modshop_price = modshop_price + _modshop_paintFinishPrice;
};

if !((modshop_paintFinish select 0) isEqualTo (modshop_old_paintFinish select 0)) then {
	modshop_price = modshop_price + 2500;
};


_total ctrlSetStructuredText parseText format [("Total Cost: ")+ " <t color='#8cff9b'>%1元</t>",[modshop_price] call OEC_fnc_numberText];
