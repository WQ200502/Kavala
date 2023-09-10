#include "..\..\macro.h"
//  File: fn_vehicleShopLBChange.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Called when a new selection is made in the list box and displays various bits of information about the vehicle.

disableSerialization;
private["_control","_index","_className","_basePrice","_vehicleInfo","_colorArray","_ctrl","_temp","_i","_pid","_copLevel","_medicLevel","_adminLevel","_donatorLevel","_goalDis"];
_control = _this select 0;
_index = _this select 1;

//Fetch some information.
_className = _control lbData _index;
_vIndex = _control lbValue _index;
_vehicleList = ["availableVehicles", life_veh_shop select 0] call OEC_fnc_vehicleConfig;
_goalDis = 1;
if (life_donation_active) then {_goalDis = .90;};
if (life_donation_vehicles) then {_goalDis = .80;};

if ((life_veh_shop select 0) == "reb_v") then {
	if (life_donation_rebVehicles) then {_goalDis = .90;};
	private _territory = "Arms";
	private _flagObj = call compile format["%1_flag",_territory];
	if(isNil "_flagObj" || isNull _flagObj) exitWith {};
	private _flagData = _flagObj getVariable ["capture_data",[]];
	if(count _flagData == 0) exitWith {};
	oev_armsCartel = [false,0,(_flagData select 0)];

	if(count oev_gang_data > 0) then {
		if(((_flagData select 0) == (oev_gang_data select 0)) && ((_flagData select 2) > 0) && !(oev_conquestData select 0)) then {
			_goalDis = _goalDis - 0.25;
			oev_armsCartel = [true,0,(_flagData select 0)];
		};
	};
};

if ((life_veh_shop select 0) != "war_v") then {
	_basePrice = ((((_vehicleList select _vIndex) select 6) * _goalDis) * __GETC__(life_medDis));
} else {
	_basePrice = ((_vehicleList select _vIndex) select 7);
};

_trunkSpace = ((_vehicleList select _vIndex) select 9);
_vehicleInfo = [_className] call OEC_fnc_fetchVehInfo;

ctrlShow [2330,true];
if ((life_veh_shop select 0) != "war_v") then {
	(getControl(2300,2303)) ctrlSetStructuredText parseText format[
	(localize "STR_Shop_Veh_UI_Ownership")+ " <t color='#8cff9b'>$%1</t><br/>" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %2 km/h<br/>" +(localize "STR_Shop_Veh_UI_HPower")+ " %3<br/>" +(localize "STR_Shop_Veh_UI_PSeats")+ " %4<br/>" +(localize "STR_Shop_Veh_UI_Trunk")+ " %5<br/>" +(localize "STR_Shop_Veh_UI_Fuel")+ " %6<br/>" +(localize "STR_Shop_Veh_UI_Armor")+ " %7",
	[_basePrice] call OEC_fnc_numberText,
	_vehicleInfo select 8,
	_vehicleInfo select 11,
	_vehicleInfo select 10,
	if(_trunkSpace == -1) then {"None"} else {_trunkSpace},
	_vehicleInfo select 12,
	_vehicleInfo select 9
	];
} else {
	(getControl(2300,2303)) ctrlSetStructuredText parseText format[
	(localize "STR_Shop_Veh_UI_Ownership")+ " <t color='#8cff9b'>%1 Warpoints</t><br/>" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %2 km/h<br/>" +(localize "STR_Shop_Veh_UI_HPower")+ " %3<br/>" +(localize "STR_Shop_Veh_UI_PSeats")+ " %4<br/>" +(localize "STR_Shop_Veh_UI_Trunk")+ " %5<br/>" +(localize "STR_Shop_Veh_UI_Fuel")+ " %6<br/>" +(localize "STR_Shop_Veh_UI_Armor")+ " %7",
	[_basePrice] call OEC_fnc_numberText,
	_vehicleInfo select 8,
	_vehicleInfo select 11,
	_vehicleInfo select 10,
	if(_trunkSpace == -1) then {"None"} else {_trunkSpace},
	_vehicleInfo select 12,
	_vehicleInfo select 9
	];
};

_pid = getPlayerUID player;
_copLevel = __GETC__(life_coplevel);
_medicLevel = __GETC__(life_medicLevel);
_adminLevel = __GETC__(life_adminlevel);
_donatorLevel = __GETC__(oev_donator);

_ctrl = getControl(2300,2304);
lbClear _ctrl;
_colorArray = ["access",_className] call OEC_fnc_vehicleSkins;
if (_className isEqualTo "C_Plane_Civil_01_racing_F") then {
	if (((_vehicleList select _vIndex) select 11) select 3 isEqualTo 1) then {
		_colorArray = ["bttArmed",_className] call OEC_fnc_vehicleSkins;
	} else {
		_colorArray = ["bttUnarmed",_className] call OEC_fnc_vehicleSkins;
	};
};
for "_i" from 0 to count(_colorArray)-1 do {
	_temp = _colorArray select _i;
	_ctrl lbAdd format['%1',(_temp select 1)];
	_ctrl lbSetData [(lbSize _ctrl)-1,_temp select 0];
};

if(!(life_veh_shop select 3)) then {
	ctrlEnable [2309,true];
};

lbSetCurSel[2304,0];
if((lbSize _ctrl)-1 != -1) then {
	ctrlShow[2304,true];
} else {
	_ctrl lbSetCurSel -1;
	ctrlShow[2304,false];
};
true;
