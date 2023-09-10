#include "..\..\macro.h"
//  File: fn_garageLBChange.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Can't be bothered to answer it.. Already deleted it by accident..
disableSerialization;
private["_control","_index","_className","_dataArr","_vehicleColor","_vehicleInfo","_trunkSpace","_sellPrice","_retrievePrice","_mods","_securitySystems","_insurance","_upgrade1","_vehicleDetails","_sellPct","_units","_sortedPlayers","_type","_display"];
_control = _this select 0;
_index = _this select 1;


//Fetch some information.
_dataArr = _control lbData _index;
_dataArr = call compile format["%1",_dataArr];
_className = _dataArr select 0;
_vehicleColor = ["allSkins", _className] call OEC_fnc_vehicleSkins;
_colorIndex = (_dataArr select 1) select 0;
if(count _vehicleColor > 0) then {
	if(_colorIndex isEqualType "") then {
		{
			if ((_x select 0) isEqualTo _colorIndex) exitWith {
				_vehicleColor = _x select 1;
			};
		}forEach _vehicleColor;
	} else {
		_vehicleColor = "Default";
	};
} else {
	_vehicleColor = "Default";
};
if !(_vehicleColor isEqualType "") then {
	_vehicleColor = "Default";
};
_vehicleColor = _vehicleColor + (switch (_dataArr select 1 select 1) do {
	case 1: {" 有光泽的表面"};
	case 2: {" 镀铬饰面"};
	case 3: {" 金色饰面"};
	default {""};
});

_vehicleInfo = [_className] call OEC_fnc_fetchVehInfo;
_vehicleDetails = ["allVehicles", _className] call OEC_fnc_vehicleConfig;
_trunkSpace = (_vehicleDetails select 9);

_mods = _dataArr select 4;
_insurance = _dataArr select 3;
switch (_insurance) do {
	case 0: {_insurance = "没有保险";};
	case 1: {_insurance = "基本覆盖范围";};
	case 2: {_insurance = "全覆盖";};
};
_securitySystems = _mods select 2;
switch (_securitySystems) do {
	case 0: {_securitySystems = "出厂设置";};
	case 1: {_securitySystems = "售后警报";};
	case 2: {_securitySystems = "总部安全系统";};
	case 3: {_securitySystems = "跟踪安全系统";};
};
_upgrade1 = "涡轮增压器:";
if(_className in ["B_Heli_Light_01_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F"]) then {
	_upgrade1 = "Maneuverability Upgrade:";
};

_sellPct = 0.4;
// _retrievePrice = _vehicleDetails select 8;
_retrievePrice = 1000;
_sellPrice = ((_vehicleDetails select 6) * __GETC__(life_medDis) * _sellPct);

if(cursortarget isKindOF "House_f" && !isNil {cursortarget getVariable "house_owner"}) then {
	_retrievePrice = 0;
};

(getControl(2800,2803)) ctrlSetStructuredText parseText format[
	"车辆类型:"+ " %14<br/>
	" +(localize "STR_Shop_Veh_UI_RetrievalP")+ " <t color='#8cff9b'>%1元</t><br/>
	" +(localize "STR_Shop_Veh_UI_SellP")+ " <t color='#8cff9b'>%2元</t><br/>
	" +(localize "STR_Shop_Veh_UI_Color")+ " %8<br/>
	" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %3 km/h<br/>
	" +(localize "STR_Shop_Veh_UI_HPower")+ " %4<br/>
	" +(localize "STR_Shop_Veh_UI_PSeats")+ " %5<br/>
	" +(localize "STR_Shop_Veh_UI_Trunk")+ " %6 + %9<br/>
	" +(localize "STR_Shop_Veh_UI_Fuel")+ " %7<br/>
	" +"保险计划:"+ " %10<br/>
	" +"%13"+ " 等级 %11<br/>
	" +"安全系统:"+ " %12<br/>
	",
	[_retrievePrice] call OEC_fnc_numberText,
	[_sellPrice] call OEC_fnc_numberText,
	_vehicleInfo select 8,
	_vehicleInfo select 11,
	_vehicleInfo select 10,
	if(_trunkSpace == -1) then {"None"} else {_trunkSpace},
	_vehicleInfo select 12,
	_vehicleColor,
	round((_mods select 1)* (_trunkSpace * 0.05)),
	_insurance,
	_mods select 0,
	_securitySystems,
	_upgrade1,
	_vehicleInfo select 13
];
_display = findDisplay 2800;
_units = _display displayCtrl 2841;
_sortedPlayers = [];
{
	if(alive _x && side _x isEqualTo civilian) then
	{
		_type = "Civ";
		_sortedPlayers pushBack [format["%1 (%2)",_x getVariable["realname",name _x],_type],_x];
	};
}foreach playableUnits;

_sortedPlayers sort true;
lbClear _units;
{
	_units lbAdd (_x select 0);
	_units lbSetData [(lbSize _units)-1,str(_x select 1)];
}foreach _sortedPlayers;

lbSetCurSel [2841,0];

ctrlShow [2803,true];
ctrlShow [2830,true];
