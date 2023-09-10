#include "..\..\macro.h"
//  File: fn_chopShopSelection.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Displays the pricing for the currently selected vehicle.
disableSerialization;
params [
	["_control",controlNull,[controlNull]],
	["_selection",-1,[0]]
];

if(isNull _control || _selection == -1) exitWith {};

private _vehicleArrayIndex = _control lbData (lbCurSel _control);
_vehicleArrayIndex = call compile format["%1", _vehicleArrayIndex];
private _nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Car","Truck","Air"],25];
private _vehicle = _nearVehicles select _vehicleArrayIndex;
private _class = (typeOf _vehicle);

private _price = _control lbValue _selection;
private _claimBtn = ((findDisplay 39400) displayCtrl 39408);
private _priceTag = ((findDisplay 39400) displayCtrl 39401);

_claimBtn ctrlShow false;
_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>" +(localize "STR_GNOTF_Price")+ "<t color='#8cff9b'>$%1</t></t>",[(_price)] call OEC_fnc_numberText];

if ((_vehicle getVariable ["side",""]) == "civ") then {
	if (_class in ["O_T_LSV_02_armed_F","B_T_LSV_01_armed_F","I_MRAP_03_F","B_MRAP_01_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","B_Heli_Transport_03_black_F","O_MRAP_02_F","O_Heli_Transport_04_bench_F","B_Heli_Transport_01_camo_F","C_Plane_Civil_01_racing_F","I_C_Offroad_02_LMG_F","I_G_Offroad_01_AT_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F"]) then {
		_claimBtn ctrlShow true;
	};
};

if(_vehicle getVariable ["side",""] == "cop") then {
	if(_class in ["C_Hatchback_01_sport_F","I_G_Offroad_01_armed_F","B_T_LSV_01_armed_F"]) then {
		_claimBtn ctrlShow true;
	};
};
